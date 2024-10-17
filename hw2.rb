class Array

  alias_method :oldAccess, :[] #create alias to access previous abilities of accessor
  alias_method :oldMap, :map

  def [](index)
     if(index.is_a?(Range)) #check if its a range or a single value
       final = [] # list to return values
       #check if the range falls valid for an array NOT EXHAUSTIVE IF NEED TO CONTINUE FOR INVALID END
       #if(index.begin < -(self.size) || index.end < -(self.size) || index.begin >= self.size || index.end >= self.size)
       

       if(index.begin >= self.size || index.begin < -(self.size)) #check if beginning of the range is valid, return fail if not
         return '\0'
       else
         #INVALID, ACCOUNTS (-2..3) FROM [-2, 3], SUPPOSED TO STOP AT -2, COULD IMPLEMENT A POSITIVE/ NEGATIVE PEEK (DID THAT)
         if((index.begin >= 0 && index.end >= 0) ||index.begin < 0 && index.end < 0) #Check if both positive or negative

           index.each do |i| #check each value of the range
             
             if i >= self.size || i < - (self.size) #check if values start to become invalid
               
               return final #return, its not going to get better
             
             else
               final.append(oldAccess(i)) #use original [] to access values
             end
           end
           return final #finished the elements, return the final array
         
         else #they have different starting and ending signs (positive or negative), accounting for that scenario
           return [oldAccess(index.begin)] #only outputs the first index whenever different signed indices occur
         end
       end
     else #One single element for index
       if index >= self.size || index < -(self.size) #cannot be greater or equal to  size or less than negative size for negative indices
         return '\0'
       else
         return oldAccess(index)
       end
     
     end
  end



end