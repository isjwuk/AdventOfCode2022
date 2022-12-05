#Advent of Code Day 4 (part 2)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/4

#Read in our personal file
$assignmentFile=Get-Content "./input.txt"

#Loop Through the Elf Pairs in the file to make an object
$assignments=ForEach($elfPair in $assignmentFile){
    [PSCustomObject]@{  
        FirstPairMin=[int]$elfPair.Split(",")[0].Split("-")[0]
        FirstPairMax=[int]$elfPair.Split(",")[0].Split("-")[1]
        SecondPairMin=[int]$elfPair.Split(",")[1].Split("-")[0]
        SecondPairMax=[int]$elfPair.Split(",")[1].Split("-")[1]
    }
}

#Use that object to look for pairs where one assignment overlaps the other
$counter=0
ForEach($assignment in $assignments){


    if (($assignment.FirstPairMin -le $assignment.SecondPairMin -and 
        $assignment.FirstPairMax -ge $assignment.SecondPairMin) -or
        ($assignment.SecondPairMin -le $assignment.FirstPairMin -and
         $assignment.SecondPairMax -ge $assignment.FirstPairMin) -or
         ($assignment.FirstPairMax -ge $assignment.SecondPairMax -and 
        $assignment.FirstPairMin -le $assignment.SecondPairMax) -or
        ($assignment.SecondPairMax -ge $assignment.FirstPairMax -and 
        $assignment.SecondPairMin -le $assignment.FirstPairMax) 
         
         )
    {
        #Increase Counter
        $counter++
    }

}

#Display Result
[string]$counter+" assignment pairs exist where one range partly overlaps the other"
$othercounter