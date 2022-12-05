#Advent of Code Day 4
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
#Very important to us the [int] there to make it a numerical value. If you don't
#then the values are later compared as strings. This gives the correct result for
#the sample data, but is way off for my input file
}

#Use that object to look for pairs where one assignment fully contains the other
$counter=0
ForEach($assignment in $assignments){

    #If 1stMin <= 2ndMin and 1stMax >= 2ndMax then it's self contained
    # or reversed
    if (($assignment.FirstPairMin -le $assignment.SecondPairMin -and $assignment.FirstPairMax -ge $assignment.SecondPairMax) -or
        ($assignment.SecondPairMin -le $assignment.FirstPairMin -and $assignment.SecondPairMax -ge $assignment.FirstPairMax))
    {
        #Increase Counter
        $counter++
    }

}

#Display Result
[string]$counter+" assignment pairs exist where one range fully contains the other"
$othercounter