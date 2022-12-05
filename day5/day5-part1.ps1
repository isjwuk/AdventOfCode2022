#Advent of Code Day 5 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/5

#Read in our personal file
$File=Get-Content "./input.txt"

$startingConfigurationComplete=$false
$stackHeight=0
$stacks=@{}
#Move through file
foreach($line in $File) {
    if(!$startingConfigurationComplete){
        #Read in the Starting configuration
        if($line.trim().StartsWith("[")){
            #We have another row of crates
            $stackHeight++
            $row=@($line -split '(.{4})' -ne '')
            #$stacks[$stackHeight]=$row
            $stacks.Add($stackHeight,$row)
            
            #When complete $stacks looks something like this
            #Name                           Value
            #----                           -----
            #3                              {[Z] , [M] , [P]}
            #2                              {[N] , [C] ,    }
            #1                              {    , [D] ,    }
        }else{
            #We have reached the end of the starting configuration
            $startingConfigurationComplete=$true
            #Flip the stacks the right way up, so row 1 is the bottom
            $rowNumber=1
            $newStacks=@{}
            Foreach($row in $stacks.Keys){
                $newStacks.Add($rowNumber,$stacks[$row])
                $rowNumber++
            }
            #Add some empty rows on top. Bit messy :( fix later.
            For($i=1;$i -le 50;$i++){
                #$blankLine=@("                                                            ".subString($File[0].length)-split '(.{4})' -ne '')
                $blankLine=@("                                    " -split '(.{4})' -ne '')
                $newStacks.Add($rowNumber,$blankLine)
                $rowNumber++
            }
            $stacks=$newStacks
            $stacks
            
        }
    }else{
        #Work through the main body of the puzzle
        #Double-check the line starts with move, so we ignore blank lines etc.
        if($line.StartsWith("move")){
            #Parse instruction
            # For example "move 6 from 2 to 1"
            $numberToMove=[int]($line -split (" "))[1]
            $stackFrom=[int]($line -split (" "))[3]
            $stackTo=[int]($line -split (" "))[5]
            "Moving "+$numberToMove+" from stack "+$stackFrom+" to stack "+$stackTo
            For($i=0;$i -lt $numberToMove;$i++){
                #Take items from stack onto crane
                #Find top full item in stack $stackfrom
                $rowNumber=$stacks.Count
                While( $rowNumber -gt 0 -and $stacks[$rowNumber][$stackFrom-1].trim() -eq "" ){
                    $rowNumber--
                }
                " picking up "+$stacks[$rowNumber][$stackFrom-1]+" with crane."
                #Pick up this item
                $crane=$stacks[$rowNumber][$stackFrom-1]
                $stacks[$rowNumber][$stackFrom-1]=""
                #Find First empty slot in stack $stackto
                $rowNumber=$stacks.Count
                While($rowNumber -gt 0 -and $stacks[$rowNumber][$stackTo-1].trim() -eq ""){
                    $rowNumber--
                }
                $rowNumber=$rowNumber +1
                #Put down the item
                " putting down the item "+$crane+ " on top of stack "+$stackTo+" in row "+$rowNumber
                $stacks[$rowNumber][$stackTo-1]=$crane
                $crane=""
            }
            #$stacks # show current status
        }
    }
    
}
#Moves complete:
#Find Top Row
$topRow=""
For($i=1;$i -le $stacks[1].Count;$i++){
    #Find top full item in stack $i
    $rowNumber=$stacks.Count
    While( $rowNumber -gt 0 -and $stacks[$rowNumber][$i-1].trim() -eq "" ){
        $rowNumber--
    }
    $topRow+=$stacks[$rowNumber][$i-1]
}
"Top Row is: "+$topRow.replace("[","").replace("]","").replace(" ","")