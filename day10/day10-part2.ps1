#Advent of Code Day 10 (part 2)
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

for($y=1;$y -le $queue.count/40;$y++)
{
    #row
    $CRTRow="" #Start with an empty string
    for($x=1;$x -le 40;$x++)
    {
        $currentValue=$queue[$x+($y-1)*40]
        if($x -in (($currentValue),($currentValue-1),($currentValue+1))){
            $CRTRow+="#"
        } else {
            $CRTRow+="."
        }    
    }
    #output complete row
    $CRTRow
}

#TODO: Text is working, and (in my case) readable, but missing first column of display.
