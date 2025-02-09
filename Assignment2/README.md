array.rb:
Modify array accessor method,[], to return '\0' instead of nil as an out of bounds method. 
*Accounts for individual indices and range.

Modify map method to return an instance of an array provided an optional range and block method

~~~~~~~~~~~~~~~~~~~~~~~~~~
rgrep.rb:
A ruby grep that takes a text file, one mandatory option (-w, -p, -v), an optional option (-c, -m),
and a pattern to search in  the text file

Mandatory:
*Default option is -p
*-w: Treat the pattern as a word, search the filename for a match. Return all lines in the file that 
match it
*-p: Treat the pattern as a regular expresiion, search the filename for a match. Return all lines in
the file that match it
*-v: Antithesis to -p, treat the pattern as a regular expresiion, search the filename for a match. 
Return all lines in the file that **do not** match it

Optional:
*-c: Can be used with -w, -p, or -v. Return the number of lines that match the pattern
*-m: Can only be used with -w or -p. Return the specific pattern that matched


*Handles errors described in file
*Thoroughly commented
*Tested thoroughly
*-Files tested not included, used to display the testing done that may be verified by users

~~~~~~~~~~~~~~~~~~~~~~~~~~
contains_virus.rb:
Solve for the lowest amount of walls needed to contain a virus in a simulated virus outbreak.
Cells containing the virus are indicated with a '1' in a 2D array.

*Commented thoroughly with purpose
*Tested thoroughly


~~~~~~~~~~~~~~~~~~~~~~~~~~
vehicle.rb:
Simulate characteristics of vehicles including cars and trucks. Demonstrate subclass
and module.

*Commented throughly with purpose
*Tested thoroughly