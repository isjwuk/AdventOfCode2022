#Advent of Code Day 1
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/1

#Read in our personal input file
$elfList=Get-Content "./input.txt"

#Get a Total for each elf
#  Loop through each line
$elfIndex=1 #Start at 1 for the first elf.
$calorieCount=0 
$calculatedElfList=foreach($line in $elfList.Split()){
    if ($line -eq "") {
        #Empty line
        # Output the elfIndex (e.g. Elf Number 1) and the cumulative Calorie Count
        [PSCustomObject]@{  
            ElfNumber=$elfIndex
            CaloriesCarried=$calorieCount 
        }
        # Reset the calorie count
        $calorieCount=0
        # Move onto the next elf
        $elfIndex++
    }else{
        #Add the calories in this food item to the cumulative Calorie Count
        $calorieCount+= $line
    }
}
"Part 1 Answer"
($calculatedElfList | Sort-Object -Property "CaloriesCarried" -Descending -Top 1).CaloriesCarried

"Part 2 Answer"
(($calculatedElfList | Sort-Object -Property "CaloriesCarried" -Descending -Top 3).CaloriesCarried | Measure-Object -Sum).Sum
