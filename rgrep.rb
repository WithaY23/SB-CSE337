class Parent
  def initialize(n)
    @name= n
  end
  
  def greet
    "Hello my name is #{@name}"
  end
end

# class Child < Parent
#   def greet
#     result = super
#     result + ", and Hello from Child!"
#   end
# end

# child = Child.new

# puts child.greet

class Child < Parent
  def initialize()
    super(ARGV[0])
    @age = ARGV[1]

  end

  def display()
    puts ("Hi my name is #{@name}")
    puts ("I am #{@age} years old!")

  end
end


myC = Child.new
myC.display

puts ARGV.size



# class Parser
  




#   def initialize()
#     @argIndex = 0
#     @fileN = ""
#     @option1 = ""
#     @option2 = ""
#   end

#   def parsing #essentially main
#     begin
      
#       if ARGV.size < 2
#         raise "Missing Requirements"
#       end

#       @fileN = ARGV[0] #can assign file to fileN now that its a valid size

#       @argIndex +=1 #increment index

#       fileOpener #test validity of file, can it open?

#       optionGather #get the options











#     rescue => e #catching errors, expecting raised error
#       puts e.message
#     end






#   end



#   #helpers to main


#   def fileOpener #check validity of file

#     begin
#       @fileStored = File.open(@fileN)


#     rescue Errno::ENOENT => e #expecting fileopen error
#       puts e.message

#     rescue =>e #capture other possible errors
#       puts ("Captured an unexpected error")
#       puts e.message

#     end


#   end

#   def fileParser()#parse file with option and pattern




#     fileStored.close
#   end

#   def optionGather #parse and store options of parser
#     begin
#       while(@argIndex < ARGV.size)
#         if(@option1.empty?)#check if any value has been added to the first option

#           case ARGV[@argIndex] #gather supplied command DEPENDS ON ALLOWED PATTERN (can I use '-' to assume option, marking invalid options based on that and repeating options based on that?)
#             when 
          
          
#           end




        
#         elsif(@option2.empty?) #check if the second has been added
#           puts "filler"
#           #Base allowed options off of first option
#         end
#       end
    

        
#     rescue =>e #expecting invalid option or combination of options error
#       puts e.message
#     end
      


#   end

#   def patternGather #gather pattern
#     if(@option2.empty?) #check if the second option is provided
#       puts "hi"

#     else #only one option is provided
#       case @option1 #can only have w p v to be valid CHECK IN optionGather METHOD
#         when "-w"
          
      
#       end
#     end

#   end


# end



class Parser
  




  def initialize()
    @argIndex = 0
    @fileN = ""
    @option1 = ""
    @option2 = ""
    @pattern = ""
  end

  def parsing #essentially main
    begin
      
      if ARGV.size < 2
        raise "Missing Requirements"
      end

      @fileN = ARGV[0] #can assign file to fileN now that its a valid size

      @argIndex +=1 #increment index, processed a value from ARGV

      fileOpener #test validity of file, can it open?

      optionGather #get the options











    rescue => e #catching errors, expecting raised error
      puts e.message
    end






  end



  #helpers to main


  def fileOpener #check validity of file

    begin
      @fileStored = File.open(@fileN)


    rescue Errno::ENOENT => e #expecting fileopen error
      puts e.message

    rescue =>e #capture other possible errors
      puts ("Captured an unexpected error")
      puts e.message

    end


  end

  def fileParser()#parse file with option and pattern




    @fileStored.close
  end

  def optionGather #parse and store options of parser
    begin
      while(@argIndex < ARGV.size)
        if(@option1.empty?)#check if any value has been added to the first option

          case ARGV[@argIndex] #gather supplied command DEPENDS ON ALLOWED PATTERN (can I use '-' to assume option, marking invalid options based on that and repeating options based on that?)
            when "-w", "-p", "-v" # example options
              @option1 = ARGV[@argIndex] # assign to option1
            else
              raise "Invalid option"
          end
          @argIndex +=1 #increment the index
        
        




        
        elsif(@option2.empty?) #check if the second has been added
          #Base allowed options off of first option ***NESTED CASE option1 {case ARGV[index]}
          case ARGV[@argIndex] # gather allowed options based on the first option
            when "-x", "-y" # example options
              @option2 = ARGV[@argIndex] # assign to option2
            else
              raise "Invalid option combination"
          end
        end
        @argIndex += 1 # increment index after processing the option
      end
    

        
    rescue =>e #expecting invalid option or combination of options error
      puts e.message
    end
      


  end

  def patternGather #gather pattern
    if(@argIndex < ARGV.size) # check that there is a pattern
      
      @pattern = ARGV[@argIndex] #assign pattern to variable


      if(@option2.empty?) #check if the second option is provided
        case @option1 #can only have w p v to be valid CHECK IN optionGather METHOD

          #CAN'T USE .match, word can be a regex and regex can be a word
          when "-w" #pattern is a word, search for and print relevant lines
            @fileStored.each do |line| 
              if line.match(@pattern) #check if the line contains the pattern
                puts line 
              end
            end
        
          when "-p" #pattern is a regex, search for and print relevant lnies
            @fileStored.each do |line| 
              if line.match(@pattern) #check if the line contains the pattern
                puts line 
              end
            end
            # Do something for -p
        
          when "-v"#pattern is regex, print lines opposite of matched lines
            @fileStored.each do |line|
              if !(line.match.(@pattern))
                puts line
              end
            # Do something for -v
        
          else
            raise ""
        end
      end
    else
      raise "Missing Required Arguments" #BE MORE CONTROLLED HERE, CATCHES WHERE?
    end

  end


end


parse = Parser.new

parse.parsing

def tester  
  ARGV.each do |x|
    puts x
  end
end
tester
