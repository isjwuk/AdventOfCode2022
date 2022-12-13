#Advent of Code Day 8 (part 2)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/8

#Read in our personal file
$inputFile=Get-Content "./input.txt"

#Get the dimensions of the forest
$forestWidth=$inputFile[0].length
$forestHeight=$inputFile.Length

#A two-dimensional array of trees can be read using
#$inputFile[$y].Substring($x,1)
#x and y are zero-based

#Quick Function to calculate tree height
Function treeHeight([int]$x, [int]$y){
    $inputFile[$y].Substring($x,1)
}

#Main Function to get Scenic Score of all trees
Function getScenicScore(){
    #Loop through the trees in the forest and find out the scenic score for each.
    for([int]$x=0;$x -lt $forestWidth;$x++){
        for([int]$y=0;$y -lt $forestHeight;$y++){
            $currentTreeHeight=treeHeight $x $y 
            #Are any trees to the North (-y) taller
            $scenicScoreNorth=$y # If none are taller then all can be seen.
            for([int]$newY=$y-1;$newY -ge 0; $newY--){
                if((treeHeight $x $newY) -ge $currentTreeHeight) {
                    #A tree of equal height or higher is getting in the way
                    #Calculate Scenic Score for this direction
                    $scenicScoreNorth=($y-$newY)
                    #Stop looking in this direction
                    break
                }
            }
            #Are any trees to the South (+y) taller
            $scenicScoreSouth=$forestHeight-$y-1 # If none are taller then all can be seen.
            for([int]$newY=$y+1;$newY -lt $forestHeight; $newY++){
                if((treeHeight $x $newY) -ge $currentTreeHeight) {
                    #A tree of equal height or higher is getting in the way
                    #Calculate Scenic Score for this direction
                    $scenicScoreSouth=($newY-$y)
                    #Stop looking in this direction
                    break
                }
            }
            #Are any trees to the West (-x) taller
            $scenicScoreWest=$x # If none are taller then all can be seen.
            for([int]$newX=$x-1;$newX -ge 0; $newX--){
                if((treeHeight $newX $y) -ge $currentTreeHeight) {
                    #A tree of equal height or higher is getting in the way
                    #Calculate Scenic Score for this direction
                    $scenicScoreWest=($x-$newX)
                    #Stop looking in this direction
                    break
                }
            }
            #Are any trees to the East (+x) taller
            $scenicScoreEast=$forestHeight-$x-1 # If none are taller then all can be seen.
            for([int]$newX=$x+1;$newX -lt $forestWidth; $newX++){
                if((treeHeight $newX $y) -ge $currentTreeHeight) {
                    #A tree of equal height or higher is getting in the way
                    #Calculate Scenic Score for this direction
                    $scenicScoreEast=($newX-$x)
                    #Stop looking in this direction
                    break
                }
            }

            [PSCustomObject]@{
                x=$x
                y=$y
                height=$currentTreeHeight
                ScenicScore=$scenicScoreNorth*$scenicScoreSouth*$scenicScoreWest*$scenicScoreEast
            }
        }
    }
}

#What is the highest scenic score possible for any tree?
"The highest scenic score is :"+ (getScenicScore | Sort-Object -Property "ScenicScore" -Descending -Top 1).ScenicScore