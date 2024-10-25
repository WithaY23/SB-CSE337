def contain_virus(is_Infected)

  if(is_Infected.empty?) #verify that the array contains values
    puts "Infected is empty"
    return 0
  end
  if(is_Infected[0].empty?) #verify that it is not a 0xn array (empty)
    puts "Infected is empty"
    return 0
  end
  #assume array is in mxn format by constraint, m and n >0
  

  #assign variables to row and column max size
  rows = is_Infected.size
  columns = is_Infected[0].size

  infectedCounter = 0 #counter for infected cells
  adjacencyCounter = 0 #counter for "walls" to remove

  rows.times do |i| #loop the rows
    columns.times do |j| #loop the columns
      if(is_Infected[i][j]== 1) #check if cell is infected
        
        infectedCounter +=1 #increase infected count

        #check how many infected cells it is adjacent to
        adjacencyCounter+= adjacencyCounting(is_Infected,i,j,rows,columns)


      end


    end

  end

  #return the wall count
  return (infectedCounter*4) - adjacencyCounter #each infected has 4 walls minus the adjacent cells




end

#count how many the infected cells are adjacent to the infected cell
def adjacencyCounting(arr,i,j,r,c)
  #i, j = current rows and columns respectively
  #r,c = row and column count respectively
  
  #check for adjacent out of bounds
  #assume i and j have valid indices
  
  counter = 0 #adjacency counter for i,j spot


  case i
    when 0 #current row = beginning, don't check "below"
      
      if(i!=(r-1)) #verify it is not a single row, no adjacent rows

        if(arr[i+1][j] == 1) #increment counter if the adjacent is also infected, essentially remove the "wall"
          counter +=1 
        end
      end

    when (r-1) #current row = row indices, don't check "above"

      if(arr[i-1][j] == 1) #increment counter if the adjacent is also infected, essentially remove the "wall"
        counter +=1 
      end

    else #middle row
      if(arr[i+1][j] == 1) 
        counter +=1 
      end

      if(arr[i-1][j] == 1)
        counter +=1 
      end

    
  end

  case j #similar to i, refer to that for equivalency
    
    when 0 #current column = beginning, don't check "left"

      if(j!=(c-1)) #verify it is not a single column
        if(arr[i][j+1] == 1)
          counter +=1 
        end
      end

    when (c-1) #current column = column indices, don't check "right"

      if(arr[i][j-1] == 1) 
        counter +=1 
      end

    else

      if(arr[i][j+1] == 1) 
        counter +=1 
      end

      if(arr[i][j-1] == 1)
        counter +=1 
      end
  end

  return counter
  
end


#Test cases


#Output format UNCOMMENT THE FOLLOWING LINE

#outputLine = Proc.new{|results| puts "Number of walls needed: #{results}"}

#UNCOMMENT THE ABOVE LINE FOR TEST CASES

#isInfected = [[1],[1],[1]]
#outputLine.call(contain_virus(isInfected))
#Expected:
#Number of walls needed: 8
#Actual:
#Number of walls needed: 8

#isInfected = [[1,1,1,1],[1,1,1,1],[1,1,1,1]]
#outputLine.call(contain_virus(isInfected))
# Expected:
# Number of walls needed: 14
# Actual:
# Number of walls needed: 14

#isInfected = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
#outputLine.call(contain_virus(isInfected))
# Expected:
# Number of walls needed: 0
# Actual:
# Number of walls needed: 0

#isInfected = [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]
#outputLine.call(contain_virus(isInfected))
# Expected:
# Number of walls needed: 16
# Actual:
# Number of walls needed: 16

#isInfected = [[1,0,0,1],[0,1,1,0],[0,1,1,0],[1,0,0,1]]
#outputLine.call(contain_virus(isInfected))
# Expected:
# Number of walls needed: 24
# Actual:
# Number of walls needed: 24

#isInfected = [[1,1,1,1,1],[1,0,0,0,1],[1,0,0,0,1],[1,1,1,1,1]]
#outputLine.call(contain_virus(isInfected))
# Expected:
# Number of walls needed: 28
# Actual:
# Number of walls needed: 28




#Test case by problem question
#isInfected = [[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]
#outputLine.call(contain_virus(isInfected))
#Expected:
#Number of walls needed: 16
#Actual:
##Number of walls needed: 16




