# Advent of Code 2022
## Day 5: Supply Stacks

* [Original Puzzle Page](https://adventofcode.com/2022/day/5)
* [My Part 1 Solution](./day5-part1-alternate.ps1)
* [My Part 2 Solution](./day5-part2.ps1)
* [Example input from the puzzle](./exampleinput.txt)
* [My personal input file](./input.txt)


### Puzzle Description
 In this puzzle the elves are moving crates between stacks using a giant cargo crane. We are provided with a text file containing a starting state and a set of instructions like *"move the top 2 from stack 3 to stack 4"*.


### My Solution
#### Part 1
[My original solution](./day5-part1.ps1) for Part 1 is a terrible example of code. It works, but not in a nice way. I only kept it as a good representation of why I shouldn't keep following a method blindly when it's not working and should come up with a better one.

I'm particularly not proud of this section where I'd backed myself into using an array in a hash table and needed to make sure there was enough empty space to make a potentially high stack of crates. Don't do this:
``` powershell
    #Add some empty rows on top. Bit messy :( fix later.
        For($i=1;$i -le 50;$i++){
            $blankLine=@("                                    " -split '(.{4})' -ne '')
            $newStacks.Add($rowNumber,$blankLine)
            $rowNumber++
        }
```        

Thankfully, after making this pigs ear of part 1 (it did work though!) I started from scratch for part 2, and then came back and reused *that* code to make [an alternative version of part 1](./day5-part1-alternate.ps1). I'll explain that later.

#### Part 2
The [code for part 2](./day5-part2.ps1) uses a shorter, tidier method than the array-per-stack in hash table I originally used for part 1. Here I'm representing each stack as a string of letters- each letter being a crate. The left hand end of the string is the bottom of the stack, and the right hand end is the top. This makes it's easy to drop crates onto a stack (add a string for those crates to the end of the stack string) and remove crates from a stack (make the stack string shorter). Strings are of variable length (like the stacks they represent), and we don't care about the empty space above a stack, so don't need to hold empty array cells etc for that information.

The example starting state from the puzzle looks like this
```
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 
```
So my string array representation looks like this (each line is an element in the array).
```
ZN
MCD
P
```

The "move crates" operation then works like this:
1. Make a string (``$crane``) of letters from the end of the starting stack string, the length of the number of crates to move.
2. Remove the number of letters from the end of the starting string equal to the number of crates to move.
3. Add the string representing the crane contents (``$crane``) to the end of the destination stack string.

#### Part 1 revisited
[My alternative version of part 1](./day5-part1-alternate.ps1) is lifted from the part 2 code with minor changes to the crane operation. That now looks like this.
1. Make a string (``$crane``) of letters from the end of the starting stack string, the length of the number of crates to move.
2. Remove the number of letters from the end of the starting string equal to the number of crates to move.
3. Reverse the order of the letters in the (``$crane``) string to show that the crates arrive in the opposite order. In my previous attempt I'd moved one crate at a time, but this produces the same result in a lot less code.
4. Add the string representing the crane contents (``$crane``) to the end of the destination stack string.