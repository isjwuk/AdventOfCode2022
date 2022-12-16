#Advent of Code Day 15 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/15

#Read in our personal file
$inputFile=Get-Content "./Exampleinput.txt"

#Sample Input Line
#Sensor at x=2, y=18: closest beacon is at x=-2, y=15

#Simple Class to represent co-ordinates
class Coordinates {
    [int]$X
    [int]$Y

    #Constructors
    Coordinates([int]$X,[int]$Y){
        $this.X=$X
        $this.Y=$Y
    }
    
}

#Function to see if coordinates are in list. Rough and ready comparitor
Function listContains([System.Collections.ArrayList]$list, [Coordinates]$newCoordinates){
    #($noBeacon.Contains([Coordinates]::new($x,$y))))
    foreach($c in $list){
        if ($c.X -eq $newCoordinates.X -and $c.Y -eq $newCoordinates.Y){
            Return $true
        }
    }
    return $false
}


#Function to distance between two points
function manhattanDistance([Coordinates]$source, [Coordinates]$destination){
    #https://en.wikipedia.org/wiki/Taxicab_geometry
    [math]::abs($destination.X-$source.X) + [math]::abs($destination.Y-$source.Y)
}


#Function to display picture so we can debug
function drawData([System.Collections.ArrayList]$list)
{
    #Get lowest X and Y
    $minX=($noBeacon.X | sort-object -Top 1)-1
    $maxX=($noBeacon.X | sort-object -Descending -Top 1)+1
    $minY=($noBeacon.Y | sort-object -Top 1)-1
    $maxY=($noBeacon.Y | sort-object -Descending -Top 1)+1
    #Fill Grid with .'s
    $width=$maxX-$minX
    $height=$maxY-$minY
    $grid=@(("."*$width))*$height
    #$grid[$y].Substring($x,1)
    
    foreach($location in $list){
        #Draw a # at this location
        
       #     "X="+$location.X+ " Y="+$location.Y+" Width="+$height+ " Length="+$height+" MinY="+$minY+" MinX="+$minX
        $grid[$location.Y-$minY-1]=   $grid[$location.Y-$minY-1].Substring(0,$location.X-$minX-1)+"#"+$grid[$location.Y-$minY-1].Substring($location.X-$minX)

    }
#TODO
$grid
}

#List of places the Beacon Can't be
[System.Collections.ArrayList]$noBeacon=@()

#Loop through each line in the input file
ForEach($line in $inputFile){
    #Extract the values from the line
    $sensorX= [int](($line -split("="))[1] -split(","))[0]
    $sensorY= [int](($line -split("="))[2] -split(":"))[0]
    [Coordinates]$sensor = [Coordinates]::new($sensorX,$sensorY)
    $beaconX= [int](($line -split("="))[3] -split(","))[0]
    $beaconY= [int]($line -split("="))[4] 
    [Coordinates]$beacon = [Coordinates]::new($beaconX,$beaconY)
    #Calculate distance to nearest beacon
    $nearestBeaconDistance=manhattanDistance $sensor $beacon
    #Work out where a beacon can't be.
    #(based solely on this sensor a beacon can't be at any of the coordinates closer than $nearestBeaconDistance)
    for($x=($sensorX-$nearestBeaconDistance);$x -le $sensorX+$nearestBeaconDistance;$x++){
        for($y=($sensorY-$nearestBeaconDistance);$y -le $sensorY+$nearestBeaconDistance;$y++){
            #Ignore beacon and sensor themselves
            if(!($beacon.x -eq $x -and $beacon.y -eq $y) -and !($sensor.x -eq $x -and $sensor.y -eq $y)){
            #Can't be a beacon at $x, $y, add it to our list if it isn't already marked
            $coords=[Coordinates]::new($x,$y)
                if (!(listContains $noBeacon $coords)){
                    $null=$noBeacon.Add($coords)
                }
            }
        }
    }
    #TODO Debugging why this doesn't work by trying a drawing
    " "
    drawData($nobeacon)

}
#"10th Line"
#$noBeacon | Where-Object {$_.Y -eq 10}
#($noBeacon | Where-Object {$_.Y -eq 10} | Measure-Object).Count

#TODO not getting the right answer on test data


