#Advent of Code Day 9 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/9

#Read in our personal file
$inputFile=Get-Content "./input.txt"

#Define Starting Positions
$headX=1
$headY=1
$tailX=1
$tailY=1
"Starting Head and Tail Position: "+$headX+","+$headY
#Empty ArrayList to keep visited positions
[System.Collections.ArrayList]$tailPositions= @()
#Record where tail currently is
$null=$tailPositions.add([string]$tailX+","+[string]$tailY)

#Loop through Instructions
ForEach($line in $inputFile){
    "== "+$line+" =="
    #Get the direction and number of steps in this line
    $directionOfSteps=$line.Split(" ")[0]
    $numberOfSteps=$line.Split(" ")[1]

    #Loop for the number of Steps
    for($i=1;$i -le $numberOfSteps;$i++){
        #Move Head
        switch ($directionOfSteps) {
            "U" {
                $headY=$headY+1
              }
            "D" {
                $headY=$headY-1
              }
            "L" {
                $headX=$headX-1
              }
            "R" {
                $headX=$headX+1
              }
        }
        "Head moved to: "+$headX+","+$headY
        #Move Tail (if required)
        if([Math]::abs($headX-$tailX) -gt 1 -or [Math]::abs($headY-$tailY) -gt 1){
            if($tailX -ne $headX -and $tailY -ne $headY){
                #Move tail diagonally
                if ($headX -gt $tailX -and $headY -gt $tailY ){$tailX++;$tailY++}
                if ($tailX -gt $headX -and $headY -gt $tailY ){$tailX--;$tailY++}
                if ($headX -gt $tailX -and $tailY -gt $headY ){$tailX++;$tailY--}
                if ($tailX -gt $headX -and $tailY -gt $headY ){$tailX--;$tailY--}
            }else{
                #Move Tail horizontally or vertically
                if ($headX-$tailX -gt 1){$tailX++}
                if ($tailX-$headX -gt 1){$tailX--}
                if ($headY-$tailY -gt 1){$tailY++}
                if ($tailY-$headY -gt 1){$tailY--}
                }
            "Tail moved to: "+$tailX+","+$tailY
            #Record where tail currently is
            $null=$tailPositions.add([string]$tailX+","+[string]$tailY)
        } else {
            "Tail stayed at: "+$tailX+","+$tailY
        }
    }
}

#How many positions does the tail of the rope visit at least once?
"The tail visited "+($tailPositions | Sort-Object -Unique | Measure-Object).Count+" different positions."