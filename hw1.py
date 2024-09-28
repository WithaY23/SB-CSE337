
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
    

    if(not checkCount(count,hello)): #if counts of first and secound don't match, check if difference is valid
        

         #if difference is allowed, check the third character
        if(checkCountDifference(count,hello) or (count == hello.count(currentChar)+1)): #one could be bigger/smaller and still work
            
            count2 = hello.count(currentChar)
            hello = hello.replace(currentChar, '') #reset string for next checkCount


            if(checkCount(count,hello)):#check first count against third character
                


                #first one failed, test if second has correct count
                
                #count one is accurate, check if two can be 'fixed' by removing a character
                if(count2 == count + 1):

                    #second can be removed, change leniency and continue
                    oneRemoved = True #used leniency (oneRemoved), set to True

                    hello = hello.replace(currentChar,'')
                
                
                else: #second is smaller, can't fix by removal, return "NO"
                    return "NO"
                
            elif(checkCount(count2,hello)):#check second count against third character
            
                #count two is accurate, check if one can be 'fixed' by removing a character
                if(count == count2 + 1):

                    #first can be removed, change leniency and continue
                    oneRemoved = True #used leniency (oneRemoved), set to True

                    hello = hello.replace(currentChar,'')

                    count = count2 #set count for future use
                
                else: #first is smaller, can't fix by removal, return "NO"
                    return "NO"
            
            
            else: #three counts don't match, fail and return "NO"
                return "NO"


                
                """if(len(hello) == 0): #check for empty string
                    return "YES"""
            

                """if(not checkCount(count2,hello)): #check if both failed, if true then return False
                    return "NO" """
            
            #if either is correct, third is the current count, assign value

            """"
            currentChar = hello[0]
            count = hello.count(currentChar)
                
            oneRemoved = True #used leniency (oneRemoved), set to True

            hello = hello.replace(currentChar,'')

            """
                
        
            
        else: #count difference is inadequate, return false
            return "NO"
        



    while (not end): #end changes with end of string or count is mismatched
       
        if(len(hello) == 0):#check if string is empty, end loop
            end = True 

        else:
            currentChar = hello[0]

            if(checkCount(count,hello)): #check if counts match
                hello = hello.replace(currentChar, '') #replace the character with an empty space
            

            else: #check if string fails

                #Use helper function to check if the count difference is valid
                if(checkCountDifference(count,hello)): 


                    if(not oneRemoved): #check for oneRemoved

                        oneRemoved =True #No longer allow for other counts

                        hello = hello.replace(currentChar, '')


                    else: #the one time save is used, fail the string
                        return "NO"

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
                

""""
isBalanced() algorithm:

check count of brackets, fancy, and parenth.
    if brackets % 2 == 0 *even* and fancy is even and parenth is even

        Check string, add to some COLLECTION (list)
        Keep adding till matching right side is found / string add runs out
            remove last added element (pop) from collection #CHECK IF THERE IS ANYTHING IN COLLECTION FIRST
            if expected matching side
                continue
            else 
                fail
        #string has ended, check if collection is also empty
        if collection is empty #if collection is empty, everything has been matched as planned, end
            success
        else
            fail
        
    

    else #doesn't have even number of items, can't pass
        fail

"""

#Check if a string has a valid ordering of opening and closing brackets
#Checking simulates FILO as the brackets have to match in the reverse order they enter
def isBalanced(brackets):

    #initializing variables

    brackMatch = {'}': '{', #dictionary for comparing brackets
                  ']':'[',
                  ')': '('} 

    brackCollection = [] #list to store brackets in stack-like access

    #check minimum conditions
    #if the bracket counts are even, and if they are equal to their closing brackets continue
    if((brackets.count('{') == brackets.count('}')) and
       (brackets.count('[') == brackets.count(']')) and
       (brackets.count('(') == brackets.count(')'))):
        
        for br in brackets: #loop through the string and gather the brackets
            
            if(brackMatch.get(br)): #check if character is an ending bracket
               
                #check brackCollection if last added value is the complimentary bracket

                if(len(brackCollection)): #check if brackCollection has any values
                    
                    if(brackMatch.get(br) == brackCollection.pop()): #check if values match
                        continue #verified  last element from the collection and removed, continue with loop
                    
                    
                    else: #brackets don't match, fail
                        return "NO"
                    
                else: #there is nothing in the collection, fail
                    return "NO"
                
            else: #add the element to the collection
                brackCollection.append(br)

        return "YES"

    else: #bracket counts are not valid, fail
        return "NO"

class Node():

    #Class constructor
    def __init__(self, v, lC = None,rC = None): #variables with default values
        self.value = v
        self.leftChild = lC
        self.rightChild = rC
    

    #traversals


    #root, left, right
    def preOrder(self, lst = None): #initialize lst as empty set for base case
       
       #set base case
       if (lst is None): 
           lst = []

       if(self is None): 
           return lst
       

       #loop through values, attach values to lst
       else:
            lst.append(self.value) #attach value to lst
            
            
            if(self.leftChild): #if it exists, go down it
                lst = self.leftChild.preOrder(lst) #reassign list explicitly to value
            
            if(self.rightChild): #after left check, if right exists, check down it
                lst =self.rightChild.preOrder(lst)
        
       return lst #get to bottom, return collected values and continue till end of tree



    #left, root, right; refer to preOrder for extensive comments
    def inOrder(self, lst = None): #initialize lst as empty set for base case
       
       #set base case
       if (lst is None): 
           lst = []
       if(self is None): 
           return lst
       

       #loop through values, attach values to lst
       else:
            if(self.leftChild):
                lst = self.leftChild.inOrder(lst)

            lst.append(self.value)

            if(self.rightChild):
                lst = self.rightChild.inOrder(lst)
       
       return lst
        
        #left, right, root; refer to preOrder for extensive comments
    def postOrder(self, lst = None): #initialize lst as empty set for base case
       
       #set base case
       if (lst is None): 
           lst = []

       if(self is None): 
           return lst
       
       #loop through values, attach values to lst
       else:
            if(self.leftChild):
                lst = self.leftChild.postOrder(lst)

            if(self.rightChild):
                lst = self.rightChild.postOrder(lst)

            lst.append(self.value)

       return lst
      

    #simulate preOrder to sum the values
    def sumTree(self, sum = 0): #initialize lst as empty set for base case
    
        #set base case
        if(self is None): 
            return 0
        

        #loop through values, add values to sum
        else:
            sum += self.value #add value to sum
            
            
            if(self.leftChild): #if it exists, go down it
                sum += self.leftChild.sumTree()
            
            if(self.rightChild):
                sum+= self.rightChild.sumTree()
        
        return sum #collect sum of the path till tree has been traversed


    

    



           








"""
 1.  The total number of lines in the file. 
 2.  The total number of words in the file. 
 3.  The total number of characters (including whitespace) in the file. 
 4.  A new file named reversed_lines.txt contains all the lines from the original file in
 reverse order
"""
#Read a file, gather and output number of lines, words, and characters. 
#Creates an additional file, reversed_lines.txt, which contains the lines in reversed order
#ADD TEST CASES
def fileReader(txt):

    #try except statement
    try:
        with open(txt,"r") as myTxt: #open file in read mode to read contents
            lines = myTxt.readlines() #gather contents as a list


    #Possible exceptions
    except FileNotFoundError: 
        print(f"The file, {txt}, was not found, shutting down program")

    except OSError:
        print("File found, error reading the file, shutting down program")



    #no errors arise, compute as normal
    else:

        #initialize variables
        characterCount = 0
        wordCount = 0 #assume words, by definition, are separated by one space
       


        #gather number of lines
        lengthOfText = len(lines)
        print(f"Text: {lines}, \n length of text: {lengthOfText}")
        


        #WRITE THIS RECURSIVELY
        #Get character and word count 
        for l in lines: #l represents individual lines
            
            for ch in l: #individual character in each line
                characterCount+= 1 #increase the character count for each word given

            print(l.split(" "))
            wordCount +=len(l.split(" ")) #separates words based on space and sums that to the count

        print(f"Total number of lines: {lengthOfText} \nTotal number of words: {wordCount} \
             \nTotal number of characters: {characterCount}")
        

        #write the contents from txt into a new file in reversed line order
        with open("reversed_lines.txt", "w") as newTxt:
            for reverse in lines[::-1]:
                newTxt.write(reverse)





        
        #TROUBLESHOOT CODE, NOT THOROUGH OR INTENDED FOR SUBMISSION OVERVIEW


        #newCharCount = 0
        #newWordCount= 0
        #with open("reversed_lines.txt","r") as newTxt:
        #   newL= newTxt.readlines()
        #     print(newL)
        #     for l in newL:
        #         for ch in l:
        #             newCharCount += 1
                
        #         newWordCount +=len(l.split(" "))

        # print(f"Old: {characterCount}, {wordCount} \n New: {newCharCount}, {newWordCount}")


        
        
      


firstNode = Node(2,Node(5),Node(6))
secondNode = Node(3,firstNode,Node(9))
thirdNode = Node(4,firstNode,secondNode)
fourthNode = Node(5)
fifthNode = Node(1, None, Node(3))

#print(firstNode.preOrder()) Expect: [2, 5, 6], Actual: [2, 5, 6]
#print(firstNode.inOrder()) Expect: [5, 2, 6], Actual: [5, 2, 6]
#print(firstNode.postOrder()) Expect: [5, 6, 2], Actual: [5, 6, 2]

#print(thirdNode.preOrder())
#Expected: [4, 2, 5, 6, 3, 2, 5, 6, 9], Actual: [4, 2, 5, 6, 3, 2, 5, 6, 9]

#print(thirdNode.inOrder())
#Expected: [5, 2, 6, 4, 5, 2, 6, 3, 9], Actual: [5, 2, 6, 4, 5, 2, 6, 3, 9]

#print(thirdNode.postOrder())
#Expected: [5, 6, 2, 5, 6, 2, 9, 3, 4], Actual: [5, 6, 2, 5, 6, 2, 9, 3, 4]

#print(fifthNode.postOrder()) Expected: [3,1], Actual: [3,1]

#print(firstNode.sumTree()) Expected: 13, Actual: 13
#print(secondNode.sumTree()) Expected: 25, Actual: 25
#print(thirdNode.sumTree()) Expected: 42, Actual: 42
#print(fourthNode.sumTree()) Expected: 5, Actual: 5
#print(fifthNode.sumTree()) Expected: 4, Actual: 4
"""
print(secondNode.inOrder())
print(firstNode.sumTree())
print(secondNode.sumTree())
print(thirdNode.sumTree())
"""



        














def main():
    """
    Problem 1:

    #print(isValid('aabbcd')) Expect: NO, Actual: NO
    #print(isValid('aaabbcccddd')) Expect: NO, Actual: NO
    #print(isValid('aabbcd'),isValid('aabbcdddeefghi'),isValid('abcdefghhgfedecba'))
    #Expect: NO NO YES, Actual: NO NO YES
    #print(isValid('aabbbcccddd')) Expect: NO, Actual: NO
    #print(isValid('aaaabbbcccdddeeefffggg')) Expect: YES, Actual:YES


    Problem 2:

    print(isBalanced('{[()]}')) Expect:YES, Actual: YES
    print(isBalanced('{[(])}')) Expect:NO, Actual: NO
    print(isBalanced('{{[[(())]]}}')) Expect:YES, Actual: YES
    print(isBalanced('[{}]()')) Expect:YES, Actual: YES
    print(isBalanced('[{}()]')) Expect:YES, Actual: YES
    print(isBalanced('[{}]()')) Expect:YES, Actual: YES



    Problem 3:
    #print(firstNode.preOrder()) Expect: [2, 5, 6], Actual: [2, 5, 6]
    #print(firstNode.inOrder()) Expect: [5, 2, 6], Actual: [5, 2, 6]
    #print(firstNode.postOrder()) Expect: [5, 6, 2], Actual: [5, 6, 2]

    #print(thirdNode.preOrder())
    #Expected: [4, 2, 5, 6, 3, 2, 5, 6, 9], Actual: [4, 2, 5, 6, 3, 2, 5, 6, 9]

    #print(thirdNode.inOrder())
    #Expected: [5, 2, 6, 4, 5, 2, 6, 3, 9], Actual: [5, 2, 6, 4, 5, 2, 6, 3, 9]

    #print(thirdNode.postOrder())
    #Expected: [5, 6, 2, 5, 6, 2, 9, 3, 4], Actual: [5, 6, 2, 5, 6, 2, 9, 3, 4]

    #print(fifthNode.postOrder()) Expected: [3,1], Actual: [3,1]

    
    #print(firstNode.sumTree()) Expected: 13, Actual: 13
    #print(secondNode.sumTree()) Expected: 25, Actual: 25
    #print(thirdNode.sumTree()) Expected: 42, Actual: 42
    #print(fourthNode.sumTree()) Expected: 5, Actual: 5
    #print(fifthNode.sumTree()) Expected: 4, Actual: 4


    Problem 4:
    See attached zip file
    #fileReader("/Users/aydenbudhoo/Desktop/School/College/SB/Code-CSE337/Assignments/Test_Folder/Test1.txt") 
    #Expected:
    # Total number of lines: 5 
    # Total number of words: 5              
    # Total number of characters: 10
    #Actual:
    # Total number of lines: 5 
    # Total number of words: 5              
    # Total number of characters: 10

    #fileReader("/Users/aydenbudhoo/Desktop/School/College/SB/Code-CSE337/Assignments/Test_Folder/Test2.txt") 
    #Expected:
    # Total number of lines: 13 
    # Total number of words: 81              
    # Total number of characters: 390
    #Actual:
    # Total number of lines: 13 
    # Total number of words: 81              
    # Total number of characters: 390

    #fileReader("/Users/aydenbudhoo/Desktop/School/College/SB/Code-CSE337/Assignments/Test_Folder/Test3.txt") 
    #Expected: 
    # Total number of lines: 4 
    # Total number of words: 32              
    # Total number of characters: 171
    #Actual:
    # Total number of lines: 4 
    # Total number of words: 32              
    # Total number of characters: 171

    #fileReader("/Users/aydenbudhoo/Desktop/School/College/SB/Code-CSE337/Assignments/Test_Folder/Test4.txt") 
    #Expected:
    # Total number of lines: 3 
    # Total number of words: 4              
    # Total number of characters: 21
    #Actual:
    # Total number of lines: 3 
    # Total number of words: 4              
    # Total number of characters: 21

    #fileReader("/Users/aydenbudhoo/Desktop/School/College/SB/Code-CSE337/Assignments/Test_Folder/Test5.txt")
    #Expected:
    # Total number of lines: 4 
    # Total number of words: 6              
    # Total number of characters: 30
    #Actual:
    # Total number of lines: 4 
    # Total number of words: 6              
    # Total number of characters: 30



"""


myNode = Node(5,Node(10),Node(20))
    #myNode.preOrder()






if __name__ == '__main__':
    main()