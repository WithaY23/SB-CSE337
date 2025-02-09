#!/bin/bash

#Calculate the letter grade for students from a directory of scores that contain score files of one student per file
#Output ID:letter grade to console
# Test case 1:
# ./student_grade.sh student_files/
# 101:B
# 102:B
# 103:A
# 104:D

# Test case 2:
# ./student_grade.sh student_files/
# 101:B
# Invalid score entered for student 102
# 102:InvalidRange
# 103:D
# Invalid score entered for student 104
# 104:InvalidRange

#Test case 3:
# ./student_grade.sh
# Invalid arguments
# Tests input arguments, directory is there

#Test case 4:
# ./student_grade.sh student_files/
# 101:D
# 102:A
# 103:B
# 104:C

#Test case 5:
# ./student_grade.sh abbb
# Directory path isn't valid
#Tests directory path

#Verify input validity
if [ "$#" -ne 1 ]
then
echo "score directory missing"
else
    if [ ! -d $1 ]
    then
        echo "$1 is not a directory"
    else

        for file in "$1"/*.txt #Loop through each file provided in directory
        do

            awk 'BEGIN{ #$1 = ID, rest are scores ($2 - $6) #Cannot use awk if multiple records, could would have to enforce through NR = X where X is a record
                FS = ","
                scoreTotal = 0 #sum the score, multiply each by 10
                
                } 
                
                
                {
                    for (i=2;i<=6;i++) #goes up to 5 questions
                    {
                        if ($i >= 0 && $i <= 100) #check if the score is between 0 and 100
                        {  
                                scoreTotal += ($i * 10) #sum the score with relevant weight, always 10
                        }
                        else
                        {
                            print "Invalid score entered for student " $1
                            scoreTotal = -1000
                            break
                        }
                        
                    }

                   
                
                } 
                
                
                #calc scores, divide by number of Qs (5)
                #display with ID
                END {


                
                regularScore = (scoreTotal / 5 ) #ROUNDING

                if(regularScore - int(regularScore) >= .5)
                {
                    finalScore = int(regularScore) + 1
                }
                else
                {
                    finalScore = int(regularScore)
                }

                if (finalScore >= 93 && finalScore <= 100) #find relevant lettergrade
                {
                    letterGrade = "A"
                }
                else if (finalScore >= 80 && finalScore <= 92)
                {
                    letterGrade = "B"
                }
                else if (finalScore >= 65 && finalScore <= 79)
                {
                    letterGrade = "C"
                }

                else if (finalScore >= 0 && finalScore < 65)
                {
                    letterGrade = "D"
                }

                else #input registered as invalid or contains invalid range
                {
                    letterGrade = "InvalidRange"
                }

                print $1 ":" letterGrade #print the id with corresponding grade
                
                
                } ' "$file"
        done
    fi 
fi
