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
  #FIND END ERROR, likely in option gather




  def initialize()
    @argIndex = 0
    @fileN = ""
    @option1 = ""
    @option2 = ""
    @pattern = ""
    @size= ARGV.size
  end

  def parsing #essentially main
    begin
      
      if @size < 2
        raise "Missing Requirements"
      end

      @fileN = ARGV[0] #can assign file to fileN now that its a valid size

      @argIndex +=1 #increment index, processed a value from ARGV

      fileOpener #test validity of file, can it open?

      optionGather #get the options

      patternGather #get the pattern

      fileParser #go through the file with relevant options and pattern

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


    ensure 
      @fileStored.close #tested file's validity, close the file
    end


  end

  def fileParser()#parse file with option and pattern

    begin
      @fileStored = File.open(@fileN) #open file

      if(@option2.empty?) #check if the second option is provided
        case @option1 #can only have w p v to be valid CHECK IN optionGather METHOD


          #word = include?, given the input, distinction is not needed
          #regex = match


          when "-w" #pattern is a word, search for and print relevant lines
            @fileStored.each do |line| 
              puts line
              puts @pattern
              if (line.include?(@pattern)) #check if the line contains the pattern
                puts line 
              end
            end
        
          when "-p" #pattern is a regex, search for and print relevant lnies
            @fileStored.each do |line| 
              if (line.match(@pattern)) #check if the line contains the pattern
                puts line 
              end
            end
        
          when "-v"#pattern is regex, print lines opposite of matched lines
            @fileStored.each do |line|
              if !(line.match(@pattern))
                puts line
              end
            end
        
          else
            puts "Unexpected assignmnet in option1, terminating"
            exit(1)
        end
      

      else #two options provided, option1 is -w,-p, or -v. option2 is -c or -m
        case @option1
          when "-w"

            case @option2
              when "-c" #count the number of lines that the word appears
                count = 0 #set count

                @fileStored.each do |line| 
                  if (line.include?(@pattern))
                    count +=1
                  end
                end

                puts count #display count

              when "-m" #output the matched part of each line of the file
                @fileStored.each do |line| 
                  if (line.include?(@pattern)) #verify pattern is a word and is there
                      puts line.scan(@pattern) #output pattern
                  end
                end
            end
            
          when "-p"
            case @option2
              when "-c" #count the number of lines that the word appears
                
                count = 0 #set count

                @fileStored.each do |line| 
                  if (line.match(@pattern))
                    count +=1
                  end
                end

                puts count #display count

              when "-m"
                @fileStored.each do |line|
                  puts line.scan(@pattern) #output pattern
                end
            end

          when "-v" #only uses -c
            count = 0

            @fileStored.each do |line| 
              if (!line.match(@pattern)) #find lines that don't match the pattern
                count +=1 #count them
              end
            end

            puts count
          
        end 
        
      end

    rescue TypeError
      puts "Expected a word, received regex"
    ensure
      @fileStored.close
    end
end


  def optionGather #parse and store options of parser
    begin
      while((@argIndex < @size-1) || !(@option1.empty? || @option2.empty?)) #check up until the last element, that will be the pattern
        if(@option1.empty?)#check if any value has been added to the first option

          case ARGV[@argIndex] #validate and gather supplied command, exception raised if invalid

            when "-w", "-p", "-v" #check provided option
              @option1 = ARGV[@argIndex] # assign to option1

            when "-c" #-c and -m need to be paired with other options, validate

              if(@argIndex + 1 < @size - 1) #check if there is another option

                case ARGV[@argIndex + 1] #"peek" other option

                when "-w", "-p", "-v" #pair with valid option
                  @option2 = ARGV[@argIndex] #always make option2 the conjunction operator

                  #increment and assign other option
                  @argIndex+=1
                  @option1 = ARGV[@argIndex] #assign and cause the elsif option2.empty? to get skipped
                
                when "-m", "-c" #valid options, invalid combination
                  raise "Invalid combination of options"

                else #invalid option
                  raise "Invalid option"
                  
                end

              else #no other options provided, raise exception
                raise "Invalid combination of options"
              end

            when "-m" #similar to -c, refer to "when -c" for more thorough documentation

              if(@argIndex + 1 < @size - 1)

                case ARGV[@argIndex + 1]

                when "-w", "-p" #only paired with -w and -p
                  @option2 = ARGV[@argIndex]

                  @argIndex+=1
                  @option1 = ARGV[@argIndex]
                
                when "-v", "-c","-m" #valid options, invalid combination
                  raise "Invalid combination of options"
                
                else #invalid pairing
                  raise "Invalid option"
                  
                end

              else
                raise "Invalid combination of options"
              end
            
            else
              raise "Invalid option" 
          end

          @argIndex +=1 #increment the index

        elsif(@option2.empty?) #check if the second has been added

          #Base allowed options off of first option
          case ARGV[@argIndex] # gather allowed options based on the first option

            when "-c" #pairs with all possibilities of option1, assign automatically
              @option2 = ARGV[@argIndex] # assign to option2

            when "-m" #only paired with -w and -p
              
              case @option1 #check option1 to validate pairing
                
                when "-w", "-p" #valid pairing
                  @option2 = ARGV[@argIndex]
                
                when "-v", "-c", "-m" #invalid pairing but valid options
                  raise "Invalid combination of options"

                else #invalid options
                  raise "Invalid option"
              end

            when "-w", "-p", "-v"#valid options, invalid combination, only -v,-m, and -p left
              raise "Invalid combination of options"
            
            else
              raise "Invalid option"
          end

        else #Both options are filled, no longer need to process options
          break
        end

        @argIndex += 1 # increment index after processing the option
      end

    rescue =>e #expecting invalid option or combination of options error
      puts e.message
    end
end


  def patternGather #gather pattern

    begin
      if(@argIndex < @size) # check that there is a pattern NEEDED, no option, ruby rgrep.rb text.txt [no option] [no pattern]

          @argIndex = @size - 1 #set index to last element of ARGV

          if(ARGV[@argIndex].match(/-[a-z]/)) #CHECK Regexp, if it fits then its an option, not a pattern
            raise "Missing Required Arguments"
          else
            @pattern = ARGV[@argIndex] #assign pattern to variable
          end
      else
        raise "Missing Required Arguments"
      end
    rescue => e #expecting missing required arguments
      e.message
    
    end

  end


end



# parse = Parser.new

# parse.parsing

# def tester  
#   ARGV.each do |x|
#     puts x
#   end
# end
# tester


def testing
  ARGV.each do |x|
    puts x.class
  end
end


mine = Parser.new
mine.parsing

testing
