#!/bin/bash
echo "Script filename is: $0"
#Take a txt file separated by ; : or , and sum the columns to an output file
#Output in Col <Num>: sum to an output file provided that is created/overwritten

# awk '{print}' "$0" 
# sum=0
#FS = "[,:;]"
#tracker[i]+= $i
#{print tracker[0]} not tested
#sum+= $i
# awk '{for (i = 1; i<=3;i++) print $i}' number.txt
#below code stores the sum of tracker[i] of respective columns, separated via spaces, and displays them at end 
#awk 'BEGIN {FS = " "} {for (i = 1; i<=NF;i++) tracker[i]+=$i;} END {for (i=1;i<=NF;i++) print tracker[i]} ' number.txt 

echo "input amount", $#

if [ "$#" -lt 2 ] 
then echo "data file or output file not found"

else 

if [ -e $1 ]
then
inputFile=$1
outputFile=$2

# awk 'BEGIN {FS = " "} {for (i = 1; i<=NF;i++) tracker[i]+=$i;} END {for (i=1;i<=NF;i++) print tracker[i]} ' number.txt
#multiline for readability
awk 'BEGIN { FS = "[,:;]" } 

     {
            for (i = 1; i <= NF; i++) 
             tracker[i] += $i
     }

     END { 
         for (i = 1; i <= NF; i++) 
             printf "Col %d : %d\n", i, tracker[i] 
     }' "$inputFile" > "$outputFile"

else

echo “$1 not found”
fi



fi