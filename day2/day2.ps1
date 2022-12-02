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
    #Split out their move and my move
    $opponentMove=$round.split(" ")[0]
    $myMove=$round.split(" ")[1]
    #Get score for my move
    #X=1, Y=2, Z=3 . The ASCII value of X is 88 so:
    $score=[byte][char]$myMove - 87
    #See who won
    # Start with a quick test for a draw. 23 letters between A and X so...
    if ([byte][char]$myMove - 23 -eq [byte][char]$opponentMove)
    { #We chose the same
        #3 points
        $score +=3
    }else{
        #We chose differently
        switch ($myMove) 
        {
            "X" { #I chose Rock so the score only increases if they chose Scissors
                #As there are no points for a loss and we've already handled a draw
                if ($opponentMove -eq "C"){$score+=6}
            }
            "Y" { #I chose Paper so the score only increases if they chose Rock
                if ($opponentMove -eq "A"){$score+=6}
            }
            "Z" { #I chose Scissors so the score only increases if they chose Paper
                if ($opponentMove -eq "B"){$score+=6}
            }
        }
    }
    $myTotalScore+=$score
}
$myTotalScore