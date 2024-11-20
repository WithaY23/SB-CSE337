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

#Test case 1:Works
# ./prog2.sh test2_1.txt testO2_1.txt 
#Uses commas, semicolons, and colons on each line

#Test case 2: Works
# ./prog2.sh test2_2.txt testO2_2.txt 
# Mixes separators


#ADJUST FOR FLOATING POINTS; RERUN ALL FILES
#Test case 3: Provides invalid argument
# ./prog2.sh test2_3.txt testO2_3.txt h
# Invalid input arguemnts provided

#Test case 4:
# ./prog2.sh test2_4.txt testO2_4.txt
# Uses negative values

#Test case 5: Provides invalid file
#./prog2.sh AHHHHH.txt testO2_3.txt
# “AHHHHH.txt not found”

echo "input amount", $#

if [ "$#" -lt 2 ] 
then echo "Data file or output file not found"

elif [ "$#" -ne 2 ] 
then echo "Invalid input arguemnts provided"

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
             printf "Col %i : %i\n", i, tracker[i] 
     }' "$inputFile" > "$outputFile"

else

echo “$1 not found”
fi



fi