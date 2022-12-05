#Advent of Code Day 3
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/3

#Read in our personal input file
$rucksacksFile=Get-Content "./input.txt"
# Make this a nice object

$priorityTotal=0 #This will be our sum of priorities of item types

#Loop through file, three lines at a time
for($i=0;$i -lt $rucksacksFile.length;$i=$i+3){
    #Go through each item type in the first of this block
    foreach($itemType in $rucksacksFile[$i].ToCharArray()){
        #Does that itemType exist in both the second and third in this block?
        if( $rucksacksFile[$i+1] -cmatch [string]$itemType -and $rucksacksFile[$i+2] -cmatch [string]$itemType){
            #Matching Item Type Found
            #Get Priority Value
            $priorityValue=[byte]$itemType -96
            #Correct Upper Case
            if($priorityValue -lt 0){$priorityValue+=58}
            #Increment Priority Total
            $priorityTotal+=$priorityValue 
            #Don't process any more items in this rucksack
            break 
        }
    }
}
"The sum of priorities for the item types common to each three elf group is "+$priorityTotal

