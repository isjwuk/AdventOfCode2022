#Advent of Code Day 5 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/5

#Read in our personal file
$File=Get-Content "./exampleinput.txt"

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
            
            #When complete $stacks looks something like
            #Name                           Value
            #----                           -----
            #3                              {[Z] , [M] , [P]}
            #2                              {[N] , [C] ,    }
            #1                              {    , [D] ,    }
        }else{
            #We have reached the end of the starting configuration
            $startingConfigurationComplete=$true
        }
    }else{
        #Work through the main body of the puzzle
        #Double-check the line starts with move, so we ignore blank lines etc.
        if($line.StartsWith("move")){


        }
    }

}
