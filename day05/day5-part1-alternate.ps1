#Advent of Code Day 5 (part 1 alternate)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/5

#Read in our personal file
$File=Get-Content "./input.txt"

#After a really horrible way of dealing with these stacks in part1, a total rethink 
#of how that is done. So after doing part 2 I came back and did part 1 again. But better.

$startingConfigurationComplete=$false
#Make empty stacks array
$stacks=@()
$line=$File[0]
$row=@($line -split '(.{4})' -ne '')
forEach($crate in $row){$stacks+=""}
#Move through lines in file
foreach($line in $File) {
    if(!$startingConfigurationComplete){
        if($line.trim().StartsWith("[")){
            #Read in the next line of the Starting configuration
            $row=@($line -split '(.{4})' -ne '')
            #Work through each crate (or gap) in this row.
            $stackCounter=0
            forEach($crate in $row){
                #Remove the brackets and empty space so we just have letters
                $stacks[$stackCounter]=$crate.replace("[","").replace("]","").trim()+$stacks[$stackCounter]
                $stacks[$stackCounter]
                $stackCounter++
            }
        }else{
            #We have reached the end of the starting configuration
            $startingConfigurationComplete=$true
            #Example Output will now look like
            #ZN
            #MCD
            #P
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
            #Get the crates we're moving
            $crane=$stacks[$stackFrom-1].Substring($stacks[$stackFrom-1].Length-$numberToMove)
            " moving "+$crane+ " with crane"
            #Remove the crates from the old stack
            $stacks[$stackFrom-1]=$stacks[$stackFrom-1].Substring(0,$stacks[$stackFrom-1].Length-$numberToMove)
            #Reverse the order of the crates (the ScriptingGuy way: https://devblogs.microsoft.com/scripting/reverse-strings-with-powershell/)
            $crates = $crane.ToCharArray()
            [array]::Reverse($crates)
            $crane= -join($crates)
            #Add the crates to the new stack
            $stacks[$stackTo-1]+=$crane
        }
    }
}
#Collect top crate in every stack
$topRow=""
Foreach($stack in $stacks){
    $topRow+= $stack.Substring($stack.Length-1)
}
"The top crates on each stack are: "+$topRow