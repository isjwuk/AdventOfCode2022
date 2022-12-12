#Advent of Code Day 11 (part 2)
#
#https://github.com/isjwuk/AdventOfCode2022
#https://adventofcode.com/2022/day/10

#Read in our personal file
$inputFile=Get-Content "./Input.txt"

<# Sample from Example Input for reference
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3
#>

#Class to represent a Monkey
class Monkey
{
    [int64]$monkeyNumber
    [System.Collections.ArrayList]$items
    [string]$operationOperator
    [string]$operationValue
    [int64]$testDivisibleBy
    [int64]$monkeyOnTrue
    [int64]$monkeyOnFalse
    [int64]$inspectionCount
    
    #Constructor
    Monkey([int64]$monkeyNumber,
    [System.Collections.ArrayList]$items,
    [string]$operationOperator,
    [string]$operationValue,
    [int64]$testDivisibleBy,
    [int64]$monkeyOnTrue,
    [int64]$monkeyOnFalse) 
    {
       $this.monkeyNumber=[int64]$monkeyNumber
       $this.items=$items
       $this.operationOperator=$operationOperator
       $this.operationValue=$operationValue
       $this.testDivisibleBy=$testDivisibleBy
       $this.monkeyOnTrue=$monkeyOnTrue
       $this.monkeyOnFalse=$monkeyOnFalse
       $this.inspectionCount=0
    }
    Monkey()
    {}
}

#An empty set of monkeys
[System.Collections.ArrayList]$Monkeys=@()
#Read in Details from file.
for($position=0; $position -le $inputFile.Length; $position+=7){
    #Read in Monkey Details
    $monkeyNumber=[int64](($inputFile[$position] -split(" "))[1]).TrimEnd(":")
    [System.Collections.ArrayList]$items=@((($inputFile[$position+1] -split(":"))[1].trim() -split(",")).trim()| ForEach-Object {[int64]$_})
    $operationOperator=($inputFile[$position+2] -split(" "))[6]
    $operationValue=($inputFile[$position+2] -split(" "))[7]
    $testDivisibleBy=($inputFile[$position+3] -split(" divisible by "))[1]
    $monkeyOnTrue=($inputFile[$position+4] -split(" to monkey "))[1]
    $monkeyOnFalse=[int64]($inputFile[$position+5] -split(" to monkey "))[1]

    #Construct Parameters
    $parameters = @{
        TypeName = 'Monkey'
        ArgumentList = ($monkeyNumber,$items,$operationOperator,$operationValue,$testDivisibleBy,$monkeyOnTrue,$monkeyOnFalse)
    }
    #Make a monkey
    $monkey = New-Object @parameters
    #Add monkey to our group
    $null=$Monkeys.Add($monkey)
}

#Create Modulus Value for lowering our worry level without breaking the maths.
$mod=1;foreach($monkey in $monkeys){$mod=$mod*$monkey.testDivisibleBy}

for($round=1;$round -le 10000; $round++){
    #Round
    #Cycle through Monkeys
    Foreach($monkey in $monkeys){
        "Monkey "+$monkey.monkeyNumber+":"
        #If monkey is holding no items it's turn ends, so only consider monkeys with items.
        if($monkey.items) {
            #Collect Items being thrown away by monkey (a.k.a don't try and change the arraylist whilst reading from the arraylist!)
            [System.Collections.ArrayList]$itemsThrown=@()
            #Cycle through Items
            Foreach($item in $monkey.items){
                "  Monkey inspects an item with a worry level of "+$item+"."
                #Collect the inspected item
                $null=$itemsThrown.Add([int64]$item)
                #Increase the item count
                $monkey.inspectionCount++
                #Translate the "old" in the operationValue
                if($monkey.operationValue -eq "old"){
                    $value=[int64]$item
                } else {
                    $value=[int64]$monkey.operationValue
                }
                #Get worried
                switch ($monkey.operationOperator) {
                    "*" {  
                        $newValue=[int64]$item * $value
                        $outputString="is multiplied by "+$value+" to "+ $newValue
                    }
                    "+" {  
                        $newValue=[int64]$item + $value
                        $outputString="increases by "+$value+" to "+ $newValue
                    }
                }
                $item=[int64]$newValue
                "    Worry level "+$outputString
                #Get Less worried (using our modulus value)
                if ($item -gt $mod){$item=$item%$mod}
                #"    Monkey gets bored with item. Worry level is divided by 3 to "+$item
                #Is current worry level divisible by $testDivisibleBy
                if($item/$monkey.testDivisibleBy -eq [math]::Round($item/$monkey.testDivisibleBy)){
                    #Worry level is divisible by $testDivisibleBy
                    "    Current worry level is divisible by "+$monkey.testDivisibleBy
                    #Give to monkeyOnTrue
                    "    Item with worry level "+$item+" is thrown to monkey "+$monkey.monkeyOnTrue
                    $null=$monkeys[$monkey.monkeyOnTrue].items.add([int64]$item)
                }else{
                    #Worry level is not divisible by $testDivisibleBy
                    "    Current worry level is not divisible by "+$monkey.testDivisibleBy
                    #Give to monkeyOnFalse
                    "    Item with worry level "+$item+" is thrown to monkey "+$monkey.monkeyOnFalse
                    $null=$monkeys[$monkey.monkeyOnFalse].items.add([int64]$item)
                }
            }
            #Remove the thrown items from the list
            foreach($item in $itemsThrown){
                $null=$monkey.items.Remove($item)
            }
        } #End of Item loop
    } #End of Monkey loop
    "After round "+$round+", the monkeys are holding items with these worry levels:"
    foreach($monkey in $monkeys){
        "Monkey "+$monkey.monkeyNumber+":"+[string]$monkey.items -replace(" ",", ")
    }

}#End of Round loop
" "
#Show inspection counts
foreach($monkey in $monkeys){
    "Monkey "+$monkey.monkeyNumber+" inspected items "+$monkey.inspectionCount+" times."
}
" "
#Show monkey business figure- two most ative monkeys counts multiplied together
$top2=($monkeys |Sort-Object -Property inspectionCount -Descending -top 2).inspectionCount
"Monkey Business="+($top2[0]*$top2[1])


