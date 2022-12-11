#Advent of Code Day 10 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/10

#Read in our personal file
$inputFile=Get-Content "./input.txt"

$queue=@{} #Hashtable, Step, Instruction
$counter=1
$currentValue=1
#Loop through input file, adding instructions to our queue
foreach($line in $inputFile){
    if($line -eq "noop"){
        $queue.add($counter,$currentValue)
    } else {
        $queue.add($counter,$currentValue)
        $counter++
        $currentValue+=[int]($line -split(" "))[1]
        $queue.add($counter,$currentValue)
    }
    $counter++
}

#Calculate important signal strengths:
$result=$queue[19]*20+$queue[59]*60+$queue[99]*100+$queue[139]*140+$queue[179]*180+$queue[219]*220
$result
