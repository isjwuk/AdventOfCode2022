# Advent of Code 2022
## Day 4: Camp Cleanup

* [Original Puzzle Page](https://adventofcode.com/2022/day/4)
* [My Part 1 Solution](./day4-part1.ps1)
* [My Part 2 Solution](./day4-part2.ps1)
* [Example input from the puzzle](./exampleinput.txt)
* [My personal input file](./input.txt)


### Puzzle Description
 In this puzzle the elves are cleaning up the camp. The challenge is to find where one of a pair of Elves has been assigned sections to clean which include all the sections assigned to their partner, and in the second part find any overlap between the pair of elves. We are given a text file with a line for each pair of Elves showing their assignments.


### My Solution
#### Part 1
I split each line of the file into a PowerShell custom object with four attributes: FirstPairMin, FirstPairMax, SecondPairMin, and SecondPairMax. Important step I picked up on the way was to make sure these were Integer values, not strings. Leaving them as Strings worked for the test data, but not my personal input file.

Each Line looks like this:
```
2-4,6-8
```
So Elf 1 would be assigned sections 2 through 4 and Elf 2 6 through 8. In this example I get the lowest section number assigned to the first Elf in that pair.
```powershell
FirstPairMin=[int]$elfPair.Split(",")[0].Split("-")[0]
```

Once we have this list of elf assignments in a form we can manipulate I've looked for situations where Elf 1's range contains Elf 2's, or the other way round, and incremented a counter where it does. Therefore the counter is increased if either of the below are true:
* ``FirstElfMin <= SecondElfMin AND FirstElfMax => SecondElfMax`` *The First Elf range includes the Second Elf Range*
* ``SecondElfMin <= FirstElfMin AND SecondElfMax => FirstElfMax``  *The Second Elf range includes the First Elf Range*

#### Part 2
Today Part 2 was very similar, all that needed changing was the logic around the overlap. So now the counter is increased if *any* of the below are true.

* ``FirstElfMin <= SecondElfMin AND FirstElfMax => SecondElfMin`` *The First Elf range overlaps with the bottom of the Second Elf Range*
* ``SecondElfMin <= FirstElfMin AND SecondElfMax => FirstElfMin``  *The Second Elf range overlaps with the bottom of the First Elf Range*
* ``FirstElfMax => SecondElfMax AND FirstElfMin <= SecondElfMax`` *The First Elf range overlaps with the top of the Second Elf Range*
* ``SecondElfMax => FirstElfMax AND SecondElfMin <= FirstElfMax`` *The Second Elf range overlaps with the top of the First Elf Range*

