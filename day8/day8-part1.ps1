#Advent of Code Day 8 (part 1)
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

#Main Function to get visibility of all trees.
Function getVisibility(){
    #Loop through the trees in the forest and find out if each is visible from outside the grid
    for([int]$x=0;$x -lt $forestWidth;$x++){
        for([int]$y=0;$y -lt $forestHeight;$y++){
            $currentTreeHeight=treeHeight $x $y 
            #"x y height: "+$x+" "+ $y+" "+        $currentTreeHeight #debugging line
            #Are any trees to the North (-y) taller
            $visibleNorth=$true #Assume its visible in this direction until we prove otherwise
            for([int]$newY=$y-1;$newY -ge 0; $newY--){
                if((treeHeight $x $newY) -ge $currentTreeHeight) {
                    $visibleNorth=$false #A tree of equal height or higher is getting in the way
                }
            }
            #Are any trees to the South (+y) taller
            $visibleSouth=$true #Assume its visible in this direction until we prove otherwise
            for([int]$newY=$y+1;$newY -lt $forestHeight; $newY++){
                if((treeHeight $x $newY) -ge $currentTreeHeight) {
                    $visibleSouth=$false #A tree of equal height or higher is getting in the way
                }
            }
            #Are any trees to the West (-x) taller
            $visibleWest=$true #Assume its visible in this direction until we prove otherwise
            for([int]$newX=$x-1;$newX -ge 0; $newX--){
                if((treeHeight $newX $y) -ge $currentTreeHeight) {
                    $visibleWest=$false #A tree of equal height or higher is getting in the way
                }
            }
            #Are any trees to the East (+x) taller
            $visibleEast=$true #Assume its visible in this direction until we prove otherwise
            for([int]$newX=$x+1;$newX -lt $forestWidth; $newX++){
                if((treeHeight $newX $y) -ge $currentTreeHeight) {
                    $visibleEast=$false #A tree of equal height or higher is getting in the way
                }
            }


            $Visible=$visibleNorth -or $visibleSouth -or $visibleEast -or $VisibleWest
            [PSCustomObject]@{
                x=$x
                y=$y
                height=$currentTreeHeight
                visible=$Visible
            }
        }
    }
}



#how many trees are visible from outside the grid?
[string](getVisibility | Where-Object {$_.visible -eq $true} | measure-object).Count+" trees are visible from outside the grid."