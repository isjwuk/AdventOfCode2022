# Advent of Code 2022
## Day 6: Tuning Trouble

* [Original Puzzle Page](https://adventofcode.com/2022/day/6)
* [My Part 1 Solution](./day6-part1.ps1)
* [My Part 2 Solution](./day6-part2.ps1)
* [My personal input file](./input.txt)

### Puzzle Description
In this puzzle we are given a single string of characters- a datastream from the Elves - 
and need to look for a start-of-packet marker, in the case of Part 1 this is a sequence of four characters that are all different.

### My Solution
#### Part 1
I worked through the string, starting 4 characters in and picking out the last four characters. Then it was a simple case
of checking if there were any duplicates. For this I used the following PowerShell logic:
```powershell
$lastFour.ToCharArray() | Sort-Object -Unique | Measure-Object).Count -eq 4
```
Which breaks down into 
1. Take the string and break it down into a array of Characters
2. Sort that array and remove any duplicates using the ``-Unique`` parameter.
3. Count how many characters are left after we've removed the duplicates. 
4. If the answer is 4 then we have four unique characters (i.e. no duplicates.)

#### Part 2
Today part 2 was *very* straightforward based on how I'd tackled part 1. In this part we needed to look for a sequence of 14 unique characters, rather than 4, so the only necessary changes to the code were swapping 4's for 14's.