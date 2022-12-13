# Advent of Code 2022
## Day 9: Rope Bridge

* [Original Puzzle Page](https://adventofcode.com/2022/day/9)
* [My Part 1 Solution](./day9-part1.ps1)
* [My Part 2 Solution](./day9-part2.ps1)
* [My personal input file](./input.txt)
* [Example input file](./exampleinput.txt)
* [Second example input file](./exampleinput2.txt) provided for Part 2.

### Puzzle Description
We're plotting a rope movement around a grid, keeping the tail following the head of the rope. It reminds me a bit of playing Snake, and definitely in part 2!


### My Solution
#### Part 1
> How many positions does the tail of the rope visit at least once?

I used four variables here, ``$headX``, ``$tailX``, ``$headY``, ``$tailY`` to track the co-ordinates of the head and tail of the rope. Again, I looped through the instructions in the text breaking it down into a direction and number of steps.

Within that loop, for each line, I looped through the number of steps from that instruction, the Head was moved first, *a step in the right direction*.

To determine if the tail needed to move, I used this ``if`` statement to see if the head was more than 1 away in either the X or Y axis.
```powershell
if([Math]::abs($headX-$tailX) -gt 1 -or [Math]::abs($headY-$tailY) -gt 1)
```
Then I either moved the tail diagonally,  or horizontally/vertically and recorded it's new location in a list.

To get the final result, I pulled the number of unique entries from the list.


#### Part 2
The same puzzle, but now the rope has 10 knots rather than 2.

I solved this by introducing a pair of arrays for x and y co-ordinates, replacing the ``$headX``, ``$tailY`` etc. from the original. As we're still only interested in the tail, that was the only knot I recorded the list of locations in.

The length of the rope here can now be further varied by adjusting the ``$numberOfKnots`` variable at the top.