#!/bin/bash
#Test case 1:
#./spell_checker.sh words.txt wordsD.txt 
#hate
#love
#Standard test to see if code works
#Test case 2:
# ./spell_checker.sh punctuation.txt punctuationD.txt 
# With
# here
# Here
# oink
# oink
#Show that the punctuation gets stripped
#Test case 3:
# ./spell_checker.sh case.txt caseD.txt 
# Kick
# Skys
#Shows both punctuation stripping and case insensitivity
#Test case 4,5,6,7: Tests invalid arguments
# ./spell_checker.sh punctuation.txt punctuationD.t
# punctuationD.t is not a file

# ./spell_checker.sh punctuation.t punctuationD.t
# punctuation.t is not a file

# ./spell_checker.sh 
# input file and dictionary missing

# ./spell_checker.sh punctuation.t a b c
# Invalid amount of arguments provided


#verify validity of input
if [ "$#" -eq 0 ] 
then echo "input file and dictionary missing"

elif [ "$#" -ne 2  ]
then echo "Invalid amount of arguments provided"

else

  if [ -e "$1" ]
  then
    if [ -e "$2" ]
    then
      #sed replaces nonletters and spaces in the txt file provided
      sed 's/[^a-zA-Z ]//g' "$1" |  while read -r line || [[ -n "$line" ]]; do #account for no newlinespace
        for word in $line; do
          if [ ${#word} -eq 4 ]; then # Check if the word has a length of 4
            awk -v word="$word" 'BEGIN {
              found = 0; #initialize flag
            }
            {
              for (i = 1; i <= NF; i++) {
            
                if (tolower($i) == tolower(word)) { #check if word matches
                  found = 1; #change flag if found, break loop
                  break;
                }
              }
            }
            END {
              if (found == 0) {
                print word; #print word if not in the dictionary
              }
            }' "$2"
          fi
        done
      done
    else echo "$2 is not a file"
    fi
  else echo "$1 is not a file"
  fi

fi
