# Advent of Code 2022
## Day 8: Treetop Tree House

* [Original Puzzle Page](https://adventofcode.com/2022/day/8)
* [My Part 1 Solution](./day8-part1.ps1)
* [My Part 2 Solution](./day8-part2.ps1)
* [My personal input file](./input.txt)
* [Example input file](./exampleinput.txt)

### Puzzle Description
Todays puzzle finds the Elves looking to build a tree house. We are provided with an input
file containing a grid of tree heights. Each tree height is a single-digit number.

### My Solution
#### Part 1
Part 1 asks "How many trees are visible from outside the grid?" - a tree is not visible if there is a tree of equal or greater height between it and the edge in all of the four directions of the compass.

To solve this I built two functions, the first ``treeHeight($x,$y)`` returns the height of a tree at the given co-ordinates by reading that character from the imported file.

The second, main, function ``getVisibility`` uses a pair of nested ``for`` loops to iterate through the forest column by column. For each tree it then "looks" North, South, West, and East to see if a tree is blocking the view from the edge. For each tree it returns a PowerShell object including the visibility.
```powershell
$Visible=$visibleNorth -or $visibleSouth -or $visibleEast -or $VisibleWest
            [PSCustomObject]@{
                x=$x
                y=$y
                height=$currentTreeHeight
                visible=$Visible
            }
```

With a table of all the trees and their visibility it's a simple matter of counting up how many have a visibility of ``$true`` and returning that count for the answer.
```powershell
[string](getVisibility | Where-Object {$_.visible -eq $true} | measure-object).Count +
" trees are visible from outside the grid."
```

#### Part 2
Part 2 asks "What is the highest scenic score possible for any tree?", the [Advent of Code page](https://adventofcode.com/2022/day/8) explains how this score is calculated. I took my part 1 code, kept the ``treeHeight`` function and modified ``getVisibility`` to ``getScenicScore``. This function uses much of the same looping, but when a blocking tree is found we record the distance between the tree and the blocking one. 
```powershell
if((treeHeight $x $newY) -ge $currentTreeHeight) {
                    #A tree of equal height or higher is getting in the way
                    #Calculate Scenic Score for this direction
                    $scenicScoreNorth=($y-$newY)
...
```

Scores for each of the directions North, South, East, and West are multiplied together and returned in the PowerShell object which makes it straightforward to find the largest in the table using ``Sort-Object``:
```powershell
"The highest scenic score is :"+ 
(getScenicScore | Sort-Object -Property "ScenicScore" -Descending -Top 1).ScenicScore
```