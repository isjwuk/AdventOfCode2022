#Advent of Code Day 6 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/6

#Read in our personal file
$file=Get-Content "./input.txt"
#$file="mjqjpqmgbljsphdztnvjfqwrcgsmlb" #Test Line should be 7
#$file="bvwbjplbgvbhsrlpgdmjqwftvncz" #Test Line Should be 5
#$file="nppdvjthqldpwncqszvftbrmjlhg" #Test Line Should be 6
#$file="nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" #Test Line Should be 10
#$file="zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" #Test Line Should be 11

#Loop through characters
$markerFound=$false
$counter=4
while (!$markerFound -and $counter -le $file.Length) {
    #Get last four characters
    $lastFour=$file.Substring($counter-4,4)
    #See if we have any duplicates
    #by making a character array, removing any duplicates, and counting those unique characters
    if (($lastFour.ToCharArray() | Sort-Object -Unique | Measure-Object).Count -eq 4)
    {
        #We have duplicates
        $markerFound=$true
    }else{
        #Move to next character
        $counter++
    }
}
#Display Result
if ($markerFound){
    "Marker found after processing "+[string]$counter+" characters."
}else{
    "No marker found."
}