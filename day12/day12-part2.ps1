#Advent of Code Day 12 (part 2)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/12

#Read in our personal file
$inputFile=Get-Content "./input.txt"
#We can read the letter from coordinates with $inputFile[$y][$x]

$shortestPath=@{} #Hashtable to store current shortest path. Key is coordinates

#Find start position
for($x=0;$x -lt $inputFile[0].Length;$x++){
    for($y=0;$y -lt $inputFile.Count;$y++){
        if ($inputFile[$y][$x] -ceq "E"){
            $currentX=$x
            $currentY=$y
            #Replace the "E" with a "z"
            $inputFile[$currenty]=$inputfile[$currenty].Substring(0,$currentx)+"z"+$inputfile[$currenty].Substring($currentx+1)
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


function stepTo ([int]$X,[int]$Y){
    #"Looking for routes from ("+$X+","+$Y+")" #Useful debugging line to see where search is leading
    $currentChar=[byte][char]$inputFile[$y][$x]
    #See if our end is next to us and at a reachable height
    if(
    ($inputFile[$y][$x] -eq "b" ) -and (
    ($X -gt 0 -and $inputFile[$y][$x-1] -eq "a") -or
    ($X -lt $inputFile[0].length -and $inputFile[$y][$x+1] -eq "a") -or
    ($y -lt $inputFile.Count-1 -and $inputFile[$y+1][$x] -eq "a") -or
    ($y -gt 0 -and $inputFile[$y-1][$x] -eq "a")) ){
        #Reached the end, no point looking for more steps down this route
        $EndSteps=[int](getShortestPath $x $y)+1
        "Reached the end in "+$EndSteps+" steps"
        #Is this our shortest route so far?         
        if ($global:fewestSteps -lt 1 -or $global:fewestSteps -gt $EndSteps){
            $global:fewestSteps=$EndSteps
            " Shortest Route is now "+$global:fewestSteps #Display the change
        }else{
            " Shortest Route is still "+$global:fewestSteps #Display the result is unchanged
        }
    }else{
        #Optimisation- no point going further if we're already over the number of steps in the previous best route.
        if ([int](getShortestPath $x $y) -lt $global:fewestSteps) {
            #Look in each direction for something thats one step down, the same height or (some) up 
            #Left (x-1)
            if($X -gt 0 -and (([byte][char]$inputFile[$y][$x-1])-$currentChar -ge -1 )){
                #Destination is at most one lower than current
                #Update the shortest path to destination
                if(setShortestPath ($x-1) $y ((getShortestPath $x $y)+1)){
                    #Go to that location if we have a new shortest route (or first time visit).
                    stepTo ($x-1) $y 
                }
            }
            #Right (x+1)
            if($X -lt $inputFile[0].length -and (([byte][char]$inputFile[$y][$x+1])-$currentChar -ge -1 )){
                #Destination is at most one lower than current
                #Update the shortest path to destination
                if(setShortestPath ($x+1) $y ((getShortestPath $x $y)+1)){
                    #Visit the destination
                    stepTo ($x+1) $y 
                }
            }
            #Down (y+1)
            if($y -lt $inputFile.Count-1 -and (([byte][char]$inputFile[$y+1][$x])-$currentChar -ge -1 )){
                #Destination is at most one lower than current
                #Update the shortest path to destination
                if(setShortestPath ($x) ($y+1) ((getShortestPath $x $y)+1)){
                    #Visit the destination
                    stepTo ($x) ($y+1) 
                }
            }
            #Up (y-1)
            if($y -gt 0 -and (([byte][char]$inputFile[$y-1][$x])-$currentChar -ge -1 )){
                #Destination is at most one lower than current
                #Update the shortest path to destination
                if(setShortestPath ($x) ($y-1) ((getShortestPath $x $y)+1)){
                    #Visit the destination
                    stepTo ($x) ($y-1)
                }
            }
        }
    }
    
}

#Keep track of the shortest route
$global:fewestSteps=$inputFile[0].Length * $inputFile.count #Worst case scenario, we visit everything!
stepTo $currentX $currentY 
" "
#$shortestPath #Show a table with the shortest route to each coordinate
"Shortest route is: "+$global:fewestSteps


