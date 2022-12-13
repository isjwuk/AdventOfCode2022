#Advent of Code Day 2
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/2

#Read in our personal input file
$strategyGuide=Get-Content "./input.txt"

#Reset Score to Zero
$myTotalScore=0

#Loop Through a round at a time
foreach($round in $strategyGuide){
    #Split out their move and the result
    $opponentMove=$round.split(" ")[0]
    $result=$round.split(" ")[1]
    #Get score for result of round: X=0, Y=3, Z=6
    $score=([byte][char]$result-88)*3
    #My move depends on result + their move 
    switch ($result) {
        "Y" {
            #The easy option- a draw 
            #A=X=1 and ASCII value of A is 65 so:
            $score+=[byte][char]$opponentMove -64
          }
        "X" {
            #I lost
            switch ($opponentMove) 
            {
                "A" { #They chose Rock so I chose Scissors
                    $score+=3
                }
                "B" { #They chose Paper so I chose Rock
                    $score+=1
                }
                "C" { #They chose Scissors so I chose Paper
                    $score+=2
                }
            }
        }
        "Z" {
            #I won
            switch ($opponentMove) 
            {
                "A" { #They chose Rock so I chose Paper
                    $score+=2
                }
                "B" { #They chose Paper so I chose Scissors
                    $score+=3
                }
                "C" { #They chose Scissors so I chose Rock
                    $score+=1
                }
            }
        }
    }
    $myTotalScore+=$score
}
$myTotalScore