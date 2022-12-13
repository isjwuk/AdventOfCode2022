# Advent of Code 2022
## Day 12: Hill Climbing Algorithm 

* [Original Puzzle Page](https://adventofcode.com/2022/day/12)
* [My Part 1 Solution](./day12-part1.ps1)
* [My Part 2 Solution](./day12-part2.ps1)
* [My personal input file](./input.txt)
* [Example input file](./exampleinput.txt)

### Puzzle Description
#TODO


### My Solution
#### Part 1
#TODO
This method is very loosely based on the ideas of [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)

#### Part 2

First thought here would be to simply wrap part 1 in another loop, using each of the letters "a" (and "S") as a starting point. However, in my input file there are
1135 "a" characters, so this would be *very* time consuming to run.

But the idea I chose is to simply start at E (the top of the hill), find the quickest way downhill to an "a". As everything is reversed we can now only step down 1 level, or across to the same level, but can step up 1 or more.

#TODO