#Advent of Code Day 7 (part 1)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/7

#Read in our personal file
$inputFile=Get-Content "./input.txt"

$currentdir="" #The current directory we are looking at
$files=@{} # A table of the files in the filesystem with their paths and sizes
$directories=@("/") # An array of directories in the filesystem

#Work through input file. 
#Fill the array of directories and hashtable of files.
ForEach($line in $inputFile){
    if($line.StartsWith("$")){
        #Command
        if ($line.StartsWith("$ cd")){
            #Change Directory
            if ($line.StartsWith("$ cd /")){
                #Move to top directory
                $currentdir="/"
            }else{
                if ($line.StartsWith("$ cd ..")){
                    #Go up one level
                    $currentdir=$currentdir.Substring(0,$currentdir.length-$currentdir.Split("/")[-2].Length-1)
                }else{
                    #Change down into a subfolder
                    $currentdir=$currentdir+$line.split(" ")[2]+"/"
                }
            }
            if($line.StartsWith("$ ls")){
                #Next lines in file show contents of the current directory. Take no action here.
            }
        }
    } else {
        #Line in file is not a command
        if($line.StartsWith("dir")){
            #A subdirectory. Add it to our list if it's not there already
            $SubDirectory=$currentdir+$line.Split(" ")[1]
            if(!$directories.Contains($subDirectory)){
                $directories+=$SubDirectory
            }
        }else{
            #A file. Record the full filepath and size in the table
            $filepath=$currentdir+$line.Split(" ")[1]
            $filesize=[int]$line.Split(" ")[0]
            #Have we already got an entry for this file?
            if($files.ContainsKey($filepath)){
                #Update existing entry
                $files[$filepath]=$files[$filepath]+$filesize
            }else{
                #Add a new file to the table
                $files.Add($filepath,$filesize)
            }
        }
    }
}
#Create a list of directories and their sizes, including all subfolders
$directorySizes=foreach($directory in $directories) {
    $size=($files[($files.keys | Where-Object {$_ -like "$directory*"})] | Measure-Object -Sum).Sum
    [PSCustomObject]@{
        Name=$directory
        Size=$size
    }
}

#Part 2: Get the sum of sizes of all directories which each have a size up to 100,000
"Part 1: the sum of sizes of all directories which each have a size up to 100,000: "
(($directorySizes | Where-Object {$_.size -le 100000}).Size | Measure-Object -sum).sum
" "

#Part 2: Get the smallest directory that, if deleted, would leave at least 30000000 free on the filesystem
$currentAvailableSpace=70000000-($directorySizes | Where-Object{$_.Name -eq "/"}).size
$requiredSpace=30000000-$currentAvailableSpace
$myDirectory=$directorySizes | Where-Object{$_.Size -ge $requiredSpace} | Sort-Object -Top 1 -Property Size
"Part 2: The smallest directory that, if deleted, would leave at least 30000000 free on the filesystem is "
$myDirectory.Name +" with a size of "+$myDirectory.Size