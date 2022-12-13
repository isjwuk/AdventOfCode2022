#Advent of Code Day 12 (part 2)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/12

#Read in our personal file
$inputFile=Get-Content "./exampleinput.txt"
#We can read the letter from coordinates with $inputFile[$y][$x]

$shortestPath=@{} #Hashtable to store current shortest path. Key is coordinates

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


function stepTo ([int]$X,[int]$Y,[string]$path){
    #"Looking for routes from ("+$X+","+$Y+")" #Useful debugging line to see where search is leading
    $currentChar=[byte][char]$inputFile[$y][$x]
    #Keep track of our route
    $path+=[string]$X+","+ [string]$Y+"|" 
    #See if our end is next to us and at a reachable height
    if(
        ($inputFile[$y][$x] -eq "y" -or  $inputFile[$y][$x] -eq "z") -and (
        ($X -gt 0 -and $inputFile[$y][$x-1] -eq "E") -or
        ($X -lt $inputFile[0].length -and $inputFile[$y][$x+1] -eq "E") -or
        ($y -lt $inputFile.Count-1 -and $inputFile[$y+1][$x] -eq "E") -or
        ($y -gt 0 -and $inputFile[$y-1][$x] -eq "E"))
        ){
            #Reached the end, no point looking for more steps down this route
            $EndSteps=[int](getShortestPath $x $y)+1
            "Reached the end in "+$EndSteps+" steps"
            #Is this our shortest route so far?         
            if ($global:fewestSteps -lt 1 -or $global:fewestSteps -gt $EndSteps){
                $global:fewestSteps=$EndSteps
                $global:bestPath=$path
                " Shortest Route is now "+$global:fewestSteps #Display the change
            }else{
                " Shortest Route is still "+$global:fewestSteps #Display the result is unchanged
            }
        }else{
            #Look in each direction for something thats one step up, the same height or (some) down 
            #or special case we're on an "S"-83 
            #TODO from part 1 handling S right- it has an elevation "a". Works in example and my input because all adjacent are a or b though.
            #Left (x-1)
            if($X -gt 0 -and (([byte][char]$inputFile[$y][$x-1])-$currentChar -le 1 -or $currentChar -eq 83)){
                #Destination is at most one higher than current
                #Update the shortest path to destination
                if(setShortestPath ($x-1) $y ((getShortestPath $x $y)+1)){
                    #Go to that location if we have a new shortest route (or first time visit).
                    stepTo ($x-1) $y $path
                }
            }
            #Right (x+1)
            if($X -lt $inputFile[0].length -and (([byte][char]$inputFile[$y][$x+1])-$currentChar -le 1 -or $currentChar -eq 83)){
                #Destination is at most one higher than current
                #Update the shortest path to destination
                if(setShortestPath ($x+1) $y ((getShortestPath $x $y)+1)){
                    #Visit the destination
                    stepTo ($x+1) $y $path
                }
            }
            #Down (y+1)
            if($y -lt $inputFile.Count-1 -and (([byte][char]$inputFile[$y+1][$x])-$currentChar -le 1 -or $currentChar -eq 83)){
                #Destination is at most one higher than current
                #Update the shortest path to destination
                if(setShortestPath ($x) ($y+1) ((getShortestPath $x $y)+1)){
                    #Visit the destination
                    stepTo ($x) ($y+1) $path
                }
            }
            #Up (y-1)
            if($y -gt 0 -and (([byte][char]$inputFile[$y-1][$x])-$currentChar -le 1 -or $currentChar -eq 83)){
                #Destination is at most one higher than current
                #Update the shortest path to destination
                if(setShortestPath ($x) ($y-1) ((getShortestPath $x $y)+1)){
                    #Visit the destination
                    stepTo ($x) ($y-1) $path
                }
            }
        }
    
}

#Keep track of the shortest route
$global:fewestSteps=0
$global:bestPath=""
$path="" #Keep track of our route
stepTo $currentX $currentY $path
" "
#$shortestPath #Show a table with the shortest route to each coordinate
"Shortest route is: "+$global:fewestSteps
#TODO: from part 1 answer is right, feel there could be more optimisation of the algorithm though.
"Route was:"+ $global:bestPath
$global:bestPath.trim("|").split("|") | select-object @{N="x";E={[int]$_.split(",")[0]}},@{N="y";E={[int]$_.split(",")[1]}} |% {$counter = 0} {$counter++; $_ | Add-Member -Name id -Value $counter -MemberType NoteProperty -PassThru}| Select-Object id, x, y, @{N="letter";E={$inputFile[$_.y][$_.x]}}
#This doesn't provide the correct answer, but instead answers the question: what's the last point at height "a" in the shortest route that starts at S. 
#ignoring this and rethinking, but committing for posterity because it's funky.