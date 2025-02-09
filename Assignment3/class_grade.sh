

#!/bin/bash

#Calculate classgrade from a txt file and a series of weights provided by the CML
#Output classgrade rounded down

#Test case 1:
# ./class_grade data.txt 1 2 3 4 5 50 50 105 1000050
# Class grade: 5
# Ignores excess arguments

#Test case 2:
# ./class_grade 1 2 3 4 5
# missing data file
# Needs first as datafile

#Test case 3:
# ./class_grade data.txt 1 2 3 4 5
# Class grade: 5
# Base comparison case

#Test case 4:
# ./class_grade data.txt 1 2 3 4 59
# Class grade: 4
# Grade does change from the weight

#Test case 5:
# ./class_grade data.txt
# Class grade: 6
# Autofill one's in place of weights




nCount=$(($#-1))  #number of parts, "N"; provided weights
#echo "Ncount: $nCount"
x=$(($nCount+1))
dataFile="$1"

#verify if the first argument is a text file
if [[ "$1" =~ \.txt$ ]]; then

    if [ -e $1 ] 
    then


    # Sum weights given as arguments (ignoring first argument, the filename)



    #calculate weighted averages using awk
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
              #      {print "Score: ", score, "Weight: ", weight, "WeightSum: ", weightSum}
                    weightedScoreSum += weight * score #calculate the weighted score of student $id
                }


                # Calculate weighted average for the current student
                if (weightSum > 0)
                {
                    weightedAverage = weightedScoreSum / weightSum
                } else 
                {
                    weightedAverage = 0
                }
                print "ID:", id, "Weighted Average:", weightedAverage
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
