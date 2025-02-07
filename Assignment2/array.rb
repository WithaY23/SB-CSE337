class Array #modify the [] and map methods, described in README.md

  alias_method :oldAccess, :[] #create alias to access previous accessor
  alias_method :oldMap, :map



  def [](index)
    
    if index.is_a?(Range) #Check if its a range index

      #Assign relevant values to start and end
      rangeStart = (index.begin < 0) ? self.size + index.begin : index.begin #if negative, assign to positive equivalence
      rangeEnd = (index.end < 0) ? self.size + index.end : index.end

      # Ensure the range is valid
      if rangeStart < 0 || rangeStart >= self.size || rangeEnd < 0
        return '\0' # Return '\0' for invalid range
      end

      # Use the original access method to access the range
      return oldAccess(index)
       


    else #One single element for index
       if index >= self.size || index < -(self.size) #cannot be greater or equal to  size or less than negative size for negative indices
         return '\0'
       else
         return oldAccess(index)
       end
     
    end
  end 

  #applies map to an optional sequence with validated range
  #if range starts in bounds then goes out of bounds, it is still valid, cover valid indices
  def map(sequence = nil, &block) #applies block to valid sequences
    changed = []
    if (sequence.nil?)#check if there was a provided sequence
        #apply to all
        self.each do |apply|
          changed.append(block.call(apply))
        end
    return changed
      
    else #sequence provided
      if(self[sequence]  != '\0') #check if sequence is valid, array is modified to have '\0' as error
        self[sequence].each do |apply|
          changed.append(block.call(apply))
        end
      end

      return changed 
    end
      

  end
    




end


#Test Cases

myArr = [1,2,3,4,5]



range1 = (2..5)
range2 = (-5..3)
range3 = (1..-2)
range4 = (2..-1)
range5= (3..-3)
range6 = (3..-2)

proc1 = Proc.new{|x| x+2}
proc2 = Proc.new{|x| x * 3}



puts "Original Array"
myArr.each do |x| puts x end

puts "Test 1"
newArr = myArr.map(range1,&proc1)
newArr.each do |x| puts x end
#Expected: 5 6 7
#Actual: 5 6 7

puts "Test 2"
newArr = myArr.map(range2,&proc2)
newArr.each do |x| puts x end
#Expected: 3 6 9 12
#Actual: 3 6 9 12

puts "Test 3"
newArr = myArr.map(range3){|x| x.even?}
newArr.each do |x| puts x end
#Expected: true false true
#Actual: true false true

puts "Test 4"
newArr = myArr.map(range4){|x| x * x}
newArr.each do |x| puts x end
#Expected: 9 16 25
#Actual: 9 16 25

puts "Test 5"
newArr = myArr.map(range5){|x| x.to_s}
newArr.each do |x| puts x end
#Expected:
#Actual:


puts "Test 6"
newArr = myArr.map(range6){|x| x + 10 }
newArr.each do |x| puts x end
#Expected: 14
#Actual: 14

puts "Test 7"
puts myArr[-3] #3
puts myArr[10] #'\0'
puts myArr[-6] #'\0'
puts myArr[5] #'\0'
puts myArr[4] #5

puts
puts "Class test cases"
a= [1,2,34,5]

puts a[1] # 2
puts a[10] # '\0'
p a.map(2..4) { |i| i.to_f} # [34.0, 5.0]
p a.map { |i| i.to_f} # [1.0, 2.0, 34.0, 5.0]
b = ["cat", "bat", "mat", "sat"]
puts b[-1] # "sat"
puts b[5] # '\0'
p b.map(2..10) { |x| x[0].upcase + x[1,x.length] } # ["Mat", "Sat"]
p b.map(2..4) { |x| x[0].upcase + x[1,x.length] } # ["Mat", "Sat"]
p b.map(-3..-1) { |x| x[0].upcase + x[1,x.length] } # ["Bat", "Mat", “Sat”] 
p b.map { |x| x[0].upcase + x[1,x.length] } # ["Cat", "Bat", "Mat", "Sat"]
















