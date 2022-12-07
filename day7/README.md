# Advent of Code 2022
## Day 7: No Space Left on Device

* [Original Puzzle Page](https://adventofcode.com/2022/day/7)
* [My Part 1 Solution](./day7.ps1)
* [My personal input file](./input.txt)
* [Example input file](./exampleinput.txt)

### Puzzle Description
Today we were given a terminal output from a session browsing round a file system, moving in and out of directories and
getting file sizes. The puzzles want us to free up some space on this nearly full disk to install a big update.

### My Solution
#### Part 1
Like the preceding days, I started by reading the file in and working through it line by line. The result of this was an array of the directories in the filesystem (recording their path, for example ``/a/b/c/``) and a hashtable of the files (recording their full path, for example ``/a/b/c/d.txt``, and their size).

These two sets of information were then used to create a table of directories and their total (including subfolder) sizes, which I called $directorySizes. The method here was that the size of the directory ``/a/b/`` was equal to the sum of the sizes of all the files where the path started with ``/a/b/``.

The puzzle was asking for the sum of sizes of all directories which each have a size up to 100,000, which was easy to calculate once I had this data:

```powershell
(($directorySizes | Where-Object {$_.size -le 100000}).Size | Measure-Object -sum).sum
```

#### Part 2
Today, my solution for part 2 is in the same file. I'm using the same data collected for part 1, but running a different calculation on it at the end. In this part I needed to get the smallest directory that, if deleted, would leave at least 30000000 free on the filesystem.

I get the current free space by taking the size of the ``/`` directory away from the given size (70000000) of the disk. We need 30000000 for this update so the required space is the difference between that and the current free space.

``` powershell
$currentAvailableSpace=70000000-($directorySizes | Where-Object{$_.Name -eq "/"}).size
$requiredSpace=30000000-$currentAvailableSpace
```

To find the smallest directory that can be removed and provide that required space, I filtered out any larger directories from the ``$directorySizes`` data, and then sorted the remainder by size, selecting the top (smallest) result.
``` powershell
$directorySizes | Where-Object{$_.Size -ge $requiredSpace} | Sort-Object -Top 1 -Property Size
```