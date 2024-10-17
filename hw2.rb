class Array

  alias_method :oldAccess, :[] #create alias to access previous accessor
  alias_method :oldMap, :map

  def [](index)
    #IGNORE UNTIL "One single element for index" COMMENT. ACCOUNTED FOR RANGE POSSIBILITY, KEPT IN FOR THOROUGHNESS

    if index.is_a?(Range) #Check if its a range index
      #Assign relevant values to start and end
      rangeStart = (index.begin < 0) ? self.size + index.begin : index.begin
      rangeEnd = (index.end < 0) ? self.size + index.end : index.end

      # Ensure the range is valid
      if rangeStart < 0 || rangeStart >= self.size || rangeEnd < 0
        return '\0' # Return nil for invalid range, following Ruby convention
      end

      # Use the original `[]` method to access the range
      return oldAccess(index)
       


    else #One single element for index
       if index >= self.size || index < -(self.size) #cannot be greater or equal to  size or less than negative size for negative indices
         return '\0'
       else
         return oldAccess(index)
       end
     
    end
  end 
  def map(sequence = nil, &block) #applies block to valid sequences
    if (sequence.nil?)#check if there was a provided sequence
      #APPLY TO ALL
    else #sequence provided
      if(sequence.begin >= self.size || sequence.begin < -(self.size)) #check if beginning of the range is valid, return fail if not
        return []
      else

      
      end
      
      
      



    end

  end
    




end


myArr = [1,2,3,4,5]

myArr.map{|x| x+2}



















#EXTRA CODE- TEST CURRENT CODE EXTENSIVELY

    #IGNORE UNTIL "One single element for index" COMMENT. ACCOUNTED FOR RANGE POSSIBILITY, KEPT IN FOR THOROUGHNESS


    # if(index.is_a?(Range)) #check if its a range or a single value
    #   final = [] # list to return values
    #   #check if the range falls valid for an array NOT EXHAUSTIVE IF NEED TO CONTINUE FOR INVALID END
    #   #if(index.begin < -(self.size) || index.end < -(self.size) || index.begin >= self.size || index.end >= self.size)
      

    #   if(index.begin >= self.size || index.begin < -(self.size)) #check if beginning of the range is valid, return fail if not
    #     return '\0'
    #   else
    #     #INVALID, ACCOUNTS (-2..3) FROM [-2, 3], SUPPOSED TO STOP AT -2, COULD IMPLEMENT A POSITIVE/ NEGATIVE PEEK (DID THAT) 
    #     #INVALID CHECK, CAN DO POSITIVE AND NEGATIVES, NEED TO TRANSLATE INDICES
    #     if((index.begin >= 0 && index.end >= 0) ||(index.begin < 0 && index.end < 0)) #Check if both positive or negative

    #       index.each do |i| #check each value of the range
            
    #         if i >= self.size || i < - (self.size) #check if values start to become invalid
              
    #           return final #return, its not going to get better
            
    #         else
    #           final.append(oldAccess(i)) #use original [] to access values
    #         end
    #       end
    #       return final #finished the elements, return the final array
        
    #     else #they have different starting and ending signs (positive or negative), accounting for that scenario

    #      if(index.begin >= 0) #check which one is positive or negative
    #        if((index.end + self.size) >= index.begin) #end is negative, check that it has a valid range
             
    #          index.each do |i| #Know that all values are valid within the range
    #            final.append(oldAccess(i))
    #          end

    #        else #end is invalid, return fail, as would []
    #          return '\0'
    #        end

    #      else #begin is negative
    #        if((index.begin +self.size)>=0) #check if beginning is valid
             
    #          index.each do |i| #check each value of the range
            
    #            if i >= self.size || i < - (self.size) #check if values start to become invalid
                 
    #              return final #return, its not going to get better
               
    #            else
    #              final.append(oldAccess(i)) #use original [] to access values
    #            end
    #          end
    #          return final #finished the elements, return the final array


    #        else #begin is invalid, return fail, as would []
    #          return '\0'
    #        end

    #      end

