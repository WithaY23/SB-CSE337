**NOTE**
THESE ALL REQUIRE THE PROGRAM NAME AS THE FIRST ENTRY TO THE COMMAND LINE USING './'. THESE ARE
SHELl FILES
Ex:
./c_mover.sh dirA dirB


c_mover.sh:
Move .c files from directory A to directory B while maintaining directory structure, require
user approval for more than three files. Creates destination directory B if it does not exist 
and handles other errors

Input: dirA dirB

*+Commented thoroughly, elaborating purpose of code
*+Spaced well to clarify more elaborate code
*+Tested thoroughly
*-Test cases depend on environment, pictures included of terminal and directory structure to demonstrate code.
Could implement general file for testing

~~~~~~~~~~~~~~~~~~~~~~~~~~
column_sum.sh:
Sum the entries in a column separated by a delimeter (,;:) and output formatted in an output file

Input: data.txt
Output format: "Column i : sum"

*+Commented thoroughly, details purpose of code
*+Tested thoroughly



~~~~~~~~~~~~~~~~~~~~~~~~~~
class_grade.sh:
Calculate the weighted average of an exam for a class of students. Take a data file, as formatted below,
with relevant weights, specified as numbers provided to the command line, and display weighted average. 

Input: data.txt W1 W2 W3 ... W1- Wn are weights for questions within the test

**ID,Q1,Q2,Q3,Q4,Q5**
101,8,6,9,4,4
102,9,9,9,10,4
103,5,6,2,4,4
...


*Uses awk
*+Commented thoroughly, details purpose of code
*+Tested thoroughly


~~~~~~~~~~~~~~~~~~~~~~~~~~
student_grade.sh:
Provided a directory of student scores in the following format, calculate their letter grades
and output in a formatted manner. 

Input:

student_files
|_ student1.txt --> 101,0,0,0,0,0  **ID,Q1,Q2,Q3,Q4,Q5**
|_ student2.txt
...


Each student is given a test with 5 questions worth 10 points. Grading format is as follows:
[100-93] => A
[92-80] =>  B
[79-65] =>  C
(65 - 0] => D


*Uses awk
*+Commented thoroughly, details purpose of code
*+Tested thoroughly
*+Handles errors


~~~~~~~~~~~~~~~~~~~~~~~~~~

spell_checker.sh:
Takes a text file and a dictionary text file, checking the text file for any four letter misspelled words
as according to the dictionary. Dictionary does not need to only have four letter words, any other words will be useless
as it only spellchecks for four letter words.

Input: data.txt dictionary.txt

*Uses awk and sed
*+Commented thoroughly, details purpose of code
*+Tested thoroughly
*+Handles errors
