#!/bin/bash

# for file in "$1"/*.txt #grab each file that 
# do

#Calculate the letter grade for students from a directory of scores that contain score files of one student per file
#Output ID:letter grade to console
awk 'BEGIN{ #$1 = ID, rest are scores ($2 - $6) #Cannot use awk if multiple records, could would have to enforce through NR = X where X is a record
    FS = ","
    scoreTotal = 0 #sum the score, multiply each by 10
    
    } 
    
    
    {
        for (i=2;i<=6;i++) #goes up to 5 questions
        {
            scoreTotal += ($i * 10) #sum the score with relevant weight, always 10
            print "Total: ", scoreTotal
        }

        #can add checks before and after
    
    } 
    
    
    #calc scores, divide by number of Qs (5)
    #display with ID
    END {

    finalScore = (scoreTotal / 5 )

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

    print $1 ":" letterGrade #print the id with corresponding grade
    
    
    } ' data.txt

# done