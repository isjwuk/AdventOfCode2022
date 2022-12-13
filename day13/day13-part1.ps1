#Advent of Code Day 13 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/13

#Read in our personal file
$inputFile=Get-Content "./exampleinput.txt"

#Compare two values
    function packetCompare($left, $right) {
        Write-Host ("- Compare "+$left+" vs "+$right)
        if( $left -match "^[\d\.]+$" -and  $right -match "^[\d\.]+$"){
            #"both numbers"
            <#  If the left integer is lower than the right integer, the inputs are in the right order.
                If the left integer is higher than the right integer, the inputs are not in the right order. 
                Otherwise, the inputs are the same integer; continue checking the next part of the input.
            #>
            if($left -lt $right){return 1}
            if($left -gt $right){return -1}
            return 0
        }else{
            #One side an integer?
            <#  If exactly one value is an integer, convert the integer to a list which contains that 
                integer as its only value, then retry the comparison.
            #>
            if( $left -match "^[\d\.]+$"){$left="["+$left+"]"} 
            if($right -match "^[\d\.]+$"){$right="["+$right+"]"}
            #Compare two lists
            <#  compare the first value of each list, then the second value, and so on. 
                If the left list runs out of items first, the inputs are in the right order. 
                If the right list runs out of items first, the inputs are not in the right order. 
                If the lists are the same length and no comparison makes a decision about the order, 
                    continue checking the next part of the input.
            #>
            $leftlist=$left.Trim("[").Trim("]").Split(",")
            $rightlist=$right.Trim("[").Trim("]").Split(",")
            #Handle empty item 
            #TODO This isn't quite right- Pair 7 in Example input is failing, Pair 1 in my input too.
            if (!$leftlist -and $rightlist){return 1}
            if (!$leftlist -and !$rightlist){return 0} 
            if (!$leftlist -and $rightlist){return -1}
            $counter=0
            while($counter -lt $leftlist.Count -and $counter -lt $rightlist.Count){
                #Write-Host("Counter: "+$counter)
                $check=(packetCompare $leftlist[$counter] $rightlist[$counter])
                #Write-Host("Check: "+$check)
                if($check -ne 0){
                    return $check
                }
                $counter++
            }
            #One or both sides ran out of items
            if($counter -ge $leftlist.Count-and $counter -lt $rightlist.Count){
                return 1
            }
            if($counter -lt $leftlist.Count-and $counter -ge $rightlist.Count){
                return -1
            }
            return 0

        }
    }


$overallResult=0
#Work through code in 3-line blocks (packet1, packet2, blank line)
for($lineNumber=0;$lineNumber -lt $inputFile.count; $lineNumber+=3){
    Write-Host ("== Pair "+($lineNumber/3+1)+"==")
    #Get the two packets
    $packet1=$inputFile[$lineNumber]
    $packet2=$inputFile[$lineNumber+1]
    $result=packetCompare $packet1 $packet2
    switch ($result) {
        1 {
            Write-Host ("Correct Order")
            $overallResult+=($lineNumber/3+1)
          }
        -1 {Write-Host ("Incorrect Order") }
        Default { Write-Host("The same?")}
    }
}
" "
$overallResult