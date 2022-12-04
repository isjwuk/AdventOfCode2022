#Advent of Code Day 3
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/3

#Read in our personal input file
$rucksacksFile=Get-Content "./input.txt"
# Make this a nice object
$counter=1 # We're going to assign an ID in case we need to look it up later
$rucksacks=ForEach ($rucksackEntry in $rucksacksFile){
    $rucksack = [PSCustomObject]@{
        id= $counter
        firstCompartment= $rucksackEntry.Substring(0, $rucksackEntry.Length /2) #First half of string
        secondCompartment=$rucksackEntry.Substring($rucksackEntry.Length /2) #Second half of string
        rucksackEntry=$rucksackEntry #Keep this in the object in case we need it later
    }    
    $counter++ #Increment ID counter
    $rucksack
}

#With this split file, find those item types in both compartments
# of a single rucksack
$priorityTotal=0 #This will be our sum of priorities of item types
Foreach($rucksack in $rucksacks) {
    #Look for matching item type - use cmatch to be case sensitive
    foreach($itemType in $rucksack.firstCompartment.ToCharArray()){
        if( $rucksack.secondCompartment -cmatch [string]$itemType ){
            #Matching Item Type Found
            #Get Priority Value
            $priorityValue=[byte]$itemType -96
            #Correct Upper Case
            if($priorityValue -lt 0){$priorityValue+=58}
            #Increment Priority Total
            $priorityTotal+=$priorityValue 
            $itemType+" "+ $priorityValue
            #Don't process any more items in this rucksack
            break 
        }
    }
}
"Sum of the priorities of item types that appear in both compartments of a rucksack:" +$priorityTotal