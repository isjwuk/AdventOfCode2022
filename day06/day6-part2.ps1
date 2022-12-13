#Advent of Code Day 6 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/6

#Read in our personal file
$file=Get-Content "./input.txt"
#$file="mjqjpqmgbljsphdztnvjfqwrcgsmlb" #Test Line should be 19
#$file="bvwbjplbgvbhsrlpgdmjqwftvncz" #Test Line should be 23
#$file="nppdvjthqldpwncqszvftbrmjlhg" #Test Line should be 23
#$file="nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" #Test Line should be 29
#$file="zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" #Test Line should be 26

#Loop through characters
$markerFound=$false
$counter=14
while (!$markerFound -and $counter -le $file.Length) {
    #Get last four characters
    $lastFour=$file.Substring($counter-14,14)
    #See if we have any duplicates
    #by making a character array, removing any duplicates, and counting those unique characters
    if (($lastFour.ToCharArray() | Sort-Object -Unique | Measure-Object).Count -eq 14)
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