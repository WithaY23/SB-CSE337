c_mover.sh:
Move .c files from directory A to directory B while maintaining directory structure, require
user approval for more than three files. Creates destination directory B if it does not exist 
and handles other errors

*+Commented thoroughly, elaborating purpose of code
*+Spaced well to clarify more elaborate code
*+Tested thoroughly
*-Test cases depend on environment, pictures included of terminal and directory structure to demonstrate code.
Could implement general file for testing

~~~~~~~~~~~~~~~~~~~~~~~~~~
column_sum.sh:
Sum the entries in a column separated by a delimeter (,;:) and output formatted in an output file
Output format: "Column i : sum"
*+Commented thoroughly, details purpose of code
*+Tested thoroughly



~~~~~~~~~~~~~~~~~~~~~~~~~~
class_grade.sh:
Calculate the weighted average of an exam for a class of students. Take a data file, as formatted below,
with relevant weights, specified as numbers provided to the command line, and display weighted average. 

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

prog5.sh

Test case 1:
./prog5.sh words.txt wordsD.txt 
hate
love
Standard test to see if code works
Test case 2:
 ./prog5.sh punctuation.txt punctuationD.txt 
 With
 here
 Here
 oink
 oink
Show that the punctuation gets stripped
Test case 3:
 ./prog5.sh case.txt caseD.txt 
 Kick
 Skys
Shows both punctuation stripping and case insensitivity
Test case 4,5,6,7: Tests invalid arguments
 ./prog5.sh punctuation.txt punctuationD.t
 punctuationD.t is not a file

 ./prog5.sh punctuation.t punctuationD.t
 punctuation.t is not a file

 ./prog5.sh 
 input file and dictionary missing

 ./prog5.sh punctuation.t a b c
 Invalid amount of arguments provided