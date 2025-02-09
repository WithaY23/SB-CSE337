#!/bin/bash

#Take a txt file separated by ; : or , and sum the columns to an output file
#Output in Col <Num>: sum to an output file provided that is created/overwritten


#Test case 1:Works
# ./column_sum test2_1.txt testO2_1.txt 
#Uses commas, semicolons, and colons on each line

#Test case 2: Works
# ./column_sum test2_2.txt testO2_2.txt 
# Mixes separators


#Test case 3: Provides invalid argument
# ./column_sum test2_3.txt testO2_3.txt h
# Invalid input arguemnts provided

#Test case 4:
# ./column_sum test2_4.txt testO2_4.txt
# Uses negative values

#Test case 5: Provides invalid file
#./column_sum AHHHHH.txt testO2_3.txt
# “AHHHHH.txt not found”


#different outputs required for less than and not equal to 2
if [ "$#" -lt 2 ] 
    then echo "Data file or output file not found"

    elif [ "$#" -ne 2 ] 
        then echo "Invalid input arguemnts provided"

    else 

        #validate first file exists
        if [ -e $1 ]
            then
            inputFile=$1
            outputFile=$2 #create second if not exists, overwrite if it does exist

            #output in "Column i : sum" format
            awk 'BEGIN { FS = "[,:;]" } 

                {
                        for (i = 1; i <= NF; i++) 
                        tracker[i] += $i
                }

                END { 
                    for (i = 1; i <= NF; i++) 
                        printf "Col %i : %i\n", i, tracker[i] 
                }' "$inputFile" > "$outputFile" #output to outputFile
            echo "Calculated sum for columns from file $1 to $2" 

        else

        echo “$1 not found”
        fi



fi
