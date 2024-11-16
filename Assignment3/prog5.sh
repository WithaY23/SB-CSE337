#!/bin/bash
#NOTE: might need to "clean" original file
#would need to run a parallel between the original and the cleaned, outputting the original when an inval word is found in the cleaned
  #assumed that the dictionary contains the clean version

#${#var} = length of var
#Program- take 2 files, ex: text.txt and dict.txt, and output invalid words (not found in dict.txt) from text.txt to console
#use awk to print out the line
#pipeline into bash to process each word
while read -r line || [[ -n "$line" ]]; do #account for no backspace

 for word in $line; do 

    if [ ${#word} -eq 4 ] #check if the word is length 4
    then # check if it's a valid word 
      found=false
      awk -v word="$word" -v found="$found" 'BEGIN {IGNORECASE=1} {
      
      for(i=1;i<=NF;i++)
      {
          if($i == word)
          {
            # print "here" finds the word and matches it, doesnt seem to change the flag
            found = "true"
            break;
            # if(found == true)
            # {
            #   print "true"
            # } converts found to true for relevant variables
          }

      }

      # if (found == true)
      # {
      # break;
      # }
      
      }
      
      
      END {
      if (found == "false")
      {print word}
      
      }' "$2"

    # else
    #   echo $word
    fi
  done
done < "$1"



  #account for the newline not being there with ||, likely remove awk from beginning
# while read -r line ||[[ -n "$line" ]] ; do
#   echo "$line"
# done < number.txt