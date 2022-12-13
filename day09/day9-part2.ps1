#Advent of Code Day 9 (part 2)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/9

#Read in our personal file
$inputFile=Get-Content "./input.txt"

#Define number of Knots
$numberofKnots=10 # 0 is the head, 9 is the tail
#Define Starting Positions (1,1)
$x = @(1)*$numberofKnots
$y = @(1)*$numberofKnots

"Starting Head and Tail Position: "+$x[0]+","+$y[0]
#Empty ArrayList to keep visited positions of tail
[System.Collections.ArrayList]$tailPositions= @()
#Record where tail currently is
$null=$tailPositions.add([string]$x[9]+","+[string]$y[9])

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
                $y[0]=$y[0]+1
              }
            "D" {
                $y[0]=$y[0]-1
              }
            "L" {
                $x[0]=$x[0]-1
              }
            "R" {
                $x[0]=$x[0]+1
              }
        }
        "Head moved to: "+$x[0]+","+$y[0]

        #Move following knots if required
        for($knot=1;$knot -lt $numberofKnots;$knot++){
            #Move Knot (if required)
            if([Math]::abs($x[$knot-1]-$x[$knot]) -gt 1 -or [Math]::abs($y[$knot-1]-$y[$knot]) -gt 1){
                if($x[$knot] -ne $x[$knot-1] -and $y[$knot] -ne $y[$knot-1]){
                    #Move tail diagonally
                    if ($x[$knot-1] -gt $x[$knot] -and $y[$knot-1] -gt $y[$knot] ){$x[$knot]++;$y[$knot]++}
                    if ($x[$knot] -gt $x[$knot-1] -and $y[$knot-1] -gt $y[$knot] ){$x[$knot]--;$y[$knot]++}
                    if ($x[$knot-1] -gt $x[$knot] -and $y[$knot] -gt $y[$knot-1] ){$x[$knot]++;$y[$knot]--}
                    if ($x[$knot] -gt $x[$knot-1] -and $y[$knot] -gt $y[$knot-1] ){$x[$knot]--;$y[$knot]--}
                }else{
                    #Move Tail horizontally or vertically
                    if ($x[$knot-1]-$x[$knot] -gt 1){$x[$knot]++}
                    if ($x[$knot]-$x[$knot-1] -gt 1){$x[$knot]--}
                    if ($y[$knot-1]-$y[$knot] -gt 1){$y[$knot]++}
                    if ($y[$knot]-$y[$knot-1] -gt 1){$y[$knot]--}
                    }
                "Knot "+$knot+" moved to: "+$x[$knot]+","+$y[$knot]
                if ($knot -eq $numberofKnots-1) {
                    #Record where tail currently is
                    $null=$tailPositions.add([string]$x[$knot]+","+[string]$y[$knot])
                }
            } else {
                "Knot "+$knot+" stayed at: "+$x[$knot]+","+$y[$knot]
            }
        }


       
    }
}

#How many positions does the tail of the rope visit at least once?
"The tail visited "+($tailPositions | Sort-Object -Unique | Measure-Object).Count+" different positions."