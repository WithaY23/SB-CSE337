
""""
1st itteration:
use find to find if a character exists elsewhere
use count to find how many times a character occurs, store in count variable
use replace to replace all the character occurences with empty spaces
2nd++ itteration:
use find to find if a character exists elsewhere
use count to find how many times a character occurs, **check** to see if it matches count variable
    if yes continue
    if no
        check how many over it is
            if 1
                check flag variable of one change
                    if false
                        turn true
                    if true
                        return false for function
            else    
                return false for function
use replace to replace all the character occurences with empty spaces


"""
#IMP: Have to consider case where first letter is less than the rest of occurences
#check if a string has the same number of occurrences throughout with a leniency of 1 character
def isValid(hello):

    if(len(hello) == 0): #check for empty string
        return "YES"
    
    #initialize variables

    count = 0 #count of char allowed
    end = False #flag for loop
    currentChar = ''


    #set values
    currentChar = hello[0]
    count=hello.count(currentChar)
    count2 = 0 #used for initial cases
    oneRemoved = False


    hello = hello.replace(currentChar, '') #remove all instances of currentChar for efficiency
    
    if(len(hello) == 0): #check for empty string
        return "YES"

    #check first and second case: first is not guaranteed to be the representative 'count' of the string
    
    currentChar = hello[0] #set value of second unique character
    
    #if(count == hello.count(currentChar)):
    if(not checkCount(count,hello)): #if counts of first and secound don't match, check if difference is valid
        

         #if difference is allowed, check the third character
        if(checkCountDifference(count,hello) or (count == hello.count(currentChar)+1)):
            
            count2 = hello.count(currentChar)
            hello = hello.replace(currentChar, '') #reset string for next checkCount


            if(not checkCount(count,hello.replace(currentChar,''))):#check first count against third character

                #1st one failed, test if second has correct count

                if(len(hello) == 0): #check for empty string
                    return "YES"
            

                if(not checkCount(count2,hello)): #check if both failed, if true then return False
                    return "NO"
            
            #if either is correct, third is the current count, assign value
            currentChar = hello[0]
            count = hello.count(currentChar) # if either is correct, third is the current count, assign value
                
            oneRemoved = True #used leniency (oneRemoved), set to True

            hello = hello.replace(currentChar,'')
                
        
            
        else: #count difference is inadequate, return false
            return "NO"
        



    while (not end): #end changes with end of string or count is mismatched
       
        if(len(hello) == 0):#check if string is empty, end loop
            end = True 

        else:
            currentChar = hello[0]

            if(checkCount(count,hello)): #check if matches count
                hello = hello.replace(currentChar, '') #replace the character with an empty space
            

            else: #check if string fails

                #Use helper function to check if the count difference is valid
                if(checkCountDifference(count,hello)): 

                    if(not oneRemoved): #check for oneRemoved
                        oneRemoved =True #No longer allow for other counts
                        hello = hello.replace(currentChar, '')

                    else: #the one time save is used, fail the string
                        return "NO"
            #REMOVE    
          #  if(len(hello) == 0): #check if string is empty, end loop
             #   end = True
       # checkCount

    return "YES"


       
#Helper functions for isValid

#Check if count of char matches general count
def checkCount(cnt,str): 
    ch = str[0]
    if(cnt ==  str.count(ch)):
        return True
    else:
        return False

#Check if count difference is too high
def checkCountDifference(cnt,str):
    ch = str[0]

    # check if it is exactly one over or if only one of that character exists
    if(str.count(ch) == cnt + 1 or str.count(ch) == 1):
        return True
    else:
        return False
                


            

            


        


    
    
    pass

def main():
    string = "aabbbccc"
    print(isValid('aabbcd')) #Expect: NO, Actual: NO
    print(isValid('aaabbcccddd')) #Expect: YES, Actual: YES
    print(isValid(string)) #Expect: YES, Actual: YES
    print(isValid('aabbcd'),isValid('aabbcdddeefghi'),isValid('abcdefghhgfedecba'))
    #Expect: NO NO YES, Actual: NO NO YES

    




if __name__ == '__main__':
    main()