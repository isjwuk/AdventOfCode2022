#Advent of Code Day 12 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/12

#Read in our personal file
$inputFile=Get-Content "./exampleinput.txt"

$shortestPath=@{} #Hashtable to store current shortest path. Key is coordinates

#We can read the letter from coordinates with $inputFile[$y][$x]

#Find start position
for($x=0;$x -lt $inputFile[0].Length;$x++){
    for($y=0;$y -lt $inputFile.Count;$y++){
        if ($inputFile[$y][$x] -ceq "S"){
            $currentX=$x
            $currentY=$y
        }
    }
}
#Set the shortest path to the start position as 0
$shortestPath.Add(([string]$currentX+","+$currentY),0)


#Get the shortest path value, 
function getShortestPath([int]$X,[int]$Y){
    $shortestPath[([string]$X+","+$Y)]
}

#Set the shortest path value, unless it's already lower.
function setShortestPath([int]$X,[int]$Y,[int]$distance){
    #Nothing Set
    if (!$shortestPath.ContainsKey(([string]$X+","+$Y))){
        $shortestPath[([string]$X+","+$Y)]=$distance
        return $true
    }
    #Something set, do comparison
    if((getShortestPath $x $y) -gt $distance){
        $shortestPath[([string]$X+","+$Y)]=$distance
        #" Set shortest path to ("+$x+","+$y+") to "+$distance
        $true
    } else {
        $false
    }
}


#Return true if this location has already been visited
function visited([int]$X,[int]$Y){
    $shortestPath.ContainsKey(([string]$X+","+$Y))
}

function stepTo ([int]$X,[int]$Y){

    "Looking for routes from ("+$X+","+$Y+")"
    $currentChar=[byte][char]$inputFile[$y][$x]

    #See if our end is next to us.

    #Look in each direction for something thats one step up, or lots down (or we're on an S-83)
    #Left (x-1)
    if($X -gt 0 -and (([byte][char]$inputFile[$y][$x-1])-$currentChar -lt 1 -or $currentChar -eq 83)){
        #Destination is at most one higher than current
        #Has it been visited
        #$alreadyVisited=visited ($x-1) $y
        #Update the shortest path to destination
        if(setShortestPath ($x-1) $y ((getShortestPath $x $y)+1)){
            stepTo ($x-1) $y 
        }
    }
    #Right (x+1)
    if($X -lt $inputFile[0].length -and (([byte][char]$inputFile[$y][$x+1])-$currentChar -lt 1 -or $currentChar -eq 83)){
        #Destination is at most one higher than current
        #Has it been visited
        #$alreadyVisited=visited ($x-1) $y
        #Update the shortest path to destination
        if(setShortestPath ($x+1) $y ((getShortestPath $x $y)+1)){
            #Visit the destination
            stepTo ($x+1) $y 
        }
    }
    #Down (y+1)
    $y 
    $X
    if($y -lt $inputFile.Count -and (([byte][char]$inputFile[$y+1][$x])-$currentChar -lt 1 -or $currentChar -eq 83)){
        #Destination is at most one higher than current
        #Has it been visited
        #$alreadyVisited=visited ($x-1) $y
        #Update the shortest path to destination
        if(setShortestPath ($x) ($y+1) ((getShortestPath $x $y)+1)){
            #Visit the destination
            stepTo ($x) ($y+1) 
        }
    }
     #Up (y-1)
     if($y -gt 0 -and (([byte][char]$inputFile[$y-1][$x])-$currentChar -lt 1 -or $currentChar -eq 83)){
        #Destination is at most one higher than current
        #Has it been visited
        #$alreadyVisited=visited ($x-1) $y
        #Update the shortest path to destination
        if(setShortestPath ($x) ($y-1) ((getShortestPath $x $y)+1)){
            #Visit the destination
            stepTo ($x) ($y-1) 
        }
    }

}

stepTo $currentX $currentY
$shortestPath