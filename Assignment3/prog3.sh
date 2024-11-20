#!/bin/bash

# array[101]=2

# #use awk to get number of records separated by comma separated values
# #get the sum of the weights from arguments passed through CML through that, store in var
# #store each value within ID index, can loop through using bash (maybe awk)
#     #for i in "${array[@]}"
#         # do
#         # echo "$i"
#         # done
# #sum values from idarray, divide by # of id's provided (students), return value rounded down

# #general variables
# weightSum=0 #summation of weights
# nCount=$(($#-1))  #Number of parts, "N"
# echo "Ncount: $nCount"
# x=$(($nCount+1))
# echo "X: $x"
# echo "Ncount: $nCount"

# #gather the sum of weights
# if [[ "$1" =~ \.txt$ ]] #find if the first argument is a text file
# then
#     # for((i=2;i<=$#;i++)) #ignore first argument
#     # do
#     # weight=${i}    # Access the i-th command-line argument (starting from $2)
#     # echo "Weight $i: $weight"
#     # weightSum=$((weightSum + ${!i})) #use ! to access CML
#     # done
#     echo "hi"
# else #fail if not
# echo "text failed"
# fi


# echo "WeightSum= $weightSum"
# echo "new loop start"
# for((i=2;i<=$nCount+1;i++)) #ignore first argument
#     do
#     weightSum=$((weightSum+ ${!i-1}))
#     weightArr[i]=${!i}
#     done
# echo "Weightsum: $weightSum"
# echo "new loop end"

# for i in "${weightArr[@]}"
# do
# echo "$i"
# done


# # for (weight in "$@")
# # do
# #     weightSum=$((weightSum + weight))
# # done
# echo "$weightSum"


# weightS=$2
# # echo "$weightSum"
# # if [[ -z $weightS ]] #detect if the CML contains a 2nd argument
# # then echo "hi"
# # else echo "hiii"
# # fi

# awk 'BEGIN {FS= ","} 




#     {
#     weight=0
#     for (i=2;i<=NF;i++)
#         if (i-1 <= '$nCount')
#         {
#             weight = '${weightArr[$i]}'
#             print "itterance", i
#             print "Weight:", weight
#         }
#         else
#         {
#             weight=1
#             print "Static weight:", weight

#         }


#         # print $i #store the weight in weight
#     # print "nCount:", '$nCount'
#     }' number.txt

# for i in "${array[@]}"
# do
# echo "$i"
# done


#!/bin/bash
#Test case 1:
# ./prog3.sh data.txt 1 2 3 4 5 50 50 105 1000050
#Test case 2:
# ./prog3.sh 1 2 3 4 5
#Test case 3:
# ./prog3.sh data.txt 1 2 3 4 5
#Test case 4:
# ./prog3.sh data.txt 1 2 3 4 59
#Test case 5:
# ./prog3.sh data.txt

#Calculate classgrade from a txt file and a series of weights provided by the CML
#Output classgrade rounded down

#initialize variables
# weightSum=0  #summation of weights 
nCount=$(($#-1))  #number of parts, "N"; provided weights
#echo "Ncount: $nCount"
x=$(($nCount+1))
#echo "X: $x"
dataFile="$1"
#echo "DataFile: $dataFile"

#verify if the first argument is a text file
if [[ "$1" =~ \.txt$ ]]; then

    if [ -e $1 ] 
    then


    # Sum weights given as arguments (ignoring first argument, the filename)


    # echo "Total weight sum: $weightSum"

    #calculate weighted averages using awk
    # -v weightSum="$weightSum"
        awk -v nCount="$nCount"  -v weights="${*:2}" ' #variables from bash/CML to awk
            BEGIN {
                #make array of weights, entered as string separated by spaces
                split(weights, weightArray, " ")
                FS= ","
                studentCount=0
                classSum=0


            }
            {
                id = $1  #id is first field
                weightedScoreSum = 0
                scoreSum = 0

                weightSum=0


                for (i = 2; i <= NF; i++) 
                {

                    if ((i-1) <= nCount) #find if weight is provided and assign relevant value
                    {
                    weight = weightArray[i - 1] 
                    }
                    else
                    {
                    weight = 1
                    }
                    weightSum+=weight
                    score = $i #score for part i of N
#                    {print "Score: ", score, "Weight: ", weight, "WeightSum: ", weightSum}
                    weightedScoreSum += weight * score #calculate the weighted score of student $id
                }

                # {print "WSSum: ", weightedScoreSum}


                # Calculate weighted average for the current student
                if (weightSum > 0)
                {
                    weightedAverage = weightedScoreSum / weightSum
                } else 
                {
                    weightedAverage = 0
                }
#                print "ID:", id, "Weighted Average:", weightedAverage
                studentWeights[id]=weightedAverage
                studentCount++
            }

            END { #sum the values in the array divided by number of students, output value
                for (grade in studentWeights)
                { classSum+= studentWeights[grade]}
            
                if (studentCount > 0)
                {
                    finalGrade = int(classSum / studentCount)
#                    print "Class sum: ", classSum
                    print "Class grade:", finalGrade
                }
                else
                {
                    print "No students found"
                }
            
            } 
        ' "$1"
        else
        echo "file not found"
        fi
else
    echo "missing data file"
fi


# ./prog3.sh data.txt 1 2 3 4 5 50 50 105 1000050
# Class grade: 5
# ./prog3.sh 1 2 3 4 5
# missing data file
# ./prog3.sh data.txt 1 2 3 4 5
# Class grade: 5
# ./prog3.sh data.txt 1 2 3 4 59
# Class grade: 4
# ./prog3.sh data.txt 
# Class grade: 6