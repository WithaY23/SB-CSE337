
class Parser

  #variables used throughout the Parser class
  def initialize()
    @argIndex = 0
    @fileN = ""
    @option1 = ""
    @option2 = ""
    @pattern = ""
    @size= ARGV.size
    @fileStored = ""
  end

  def parsing #essentially main
    begin
      
      if @size < 2
        raise "Missing Required Arguments"
      end

      @fileN = ARGV[0] #can assign file to fileN now that its a valid size

      @argIndex +=1 #increment index, processed a value from ARGV

      fileOpener #test validity of file, can it open? Stored in @fileStored

      optionGather #get the options

      patternGather #get the pattern

      fileParser #go through the file with relevant options and pattern

    rescue => e #catching errors, expecting raised error
      puts e.message
      exit 1
    end

  end 




  #helpers to main


  def fileOpener #check validity of file

    begin
      if(@fileN.match(/^-.$/)) #check if its an option
        if (@fileN.match(/^-[^0-9wpvcm]$/)) #check if its an invalid option
          raise "Invalid option"
        
        else
          raise "Missing Required Arguments"
        end
      
        
      else
      
      
      end
      @fileStored = File.open(@fileN)


    rescue Errno::ENOENT => e #expecting fileopen error
      puts e.message
      exit 1
      
    
    rescue =>e #capture other possible errors
      puts e.message
      exit 1


    ensure 
      if (@fileStored != "")
        @fileStored.close #tested file's validity, close the file
      end
    end


  end

  def fileParser()#parse file with option and pattern

    begin
      @fileStored = File.open(@fileN) #open file

      if(@option2.empty?) #check if the second option is provided
        case @option1 #can only have w p v to be valid CHECK IN optionGather METHOD


          when "-w" #pattern is a word, search for and print relevant lines

            @fileStored.each do |line| 
              outputted = false
              words = line.split(" ") #cannot use pattern matching to match word, use flag instead
                                      #could likely pattern match word 
                                      #start ("^_ "), middle (" _ "), end (" _$")
              
              words.each do |w|
                if (w == @pattern && !outputted) #match word, only print one line if found
                  puts line
                  outputted = true
                end
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
                    searched = false
                    words = line.split(" ")
                    
                    words.each do |w|
                      if (w == @pattern && !searched)
                        count+=1
                        searched = true
                      end
                    end
                  end

                puts count #display count

              when "-m" #output the matched part of each line of the file
                @fileStored.each do |line| 
                  if (line.include?(@pattern)) #verify pattern is a word and is present in line
                    words = line.split(" ") #it's a word, separate by spaces
                    words.each do |w| #take each word in the array, output it if it has the letter
                      if(w == @pattern)
                        puts w
                      end
                    end
                  end
                end
            end
            
          when "-p"
            case @option2
              when "-c" 
                
                count = 0 #set count

                @fileStored.each do |line| 
                  if (line.match(@pattern))
                    count +=1
                  end
                end

                puts count #display count

              when "-m"
                altLine= ""
                @fileStored.each do |line|
                  if(line.match(@pattern))
                    altLine = line
                    while(altLine.match(@pattern))#Find pattern, output it, remove. Repeat process for entire line
                      puts altLine.match(@pattern)
                      altLine = altLine.sub(@pattern , "") #make it a regex and remove first occurence

                    end
                  end
                end
            end

          when "-v" #only uses -c, verified in optionGather
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
      exit 1
    ensure
      @fileStored.close
    end
  end


  def optionGather #parse and store options of parser
    
    begin
      if(@size == 2) #assume default option, check if last is an option
        if(ARGV[@size-1] =~ /^-.$/)
          raise "Missing Required Arguments"
        end
      end
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
                
                when /^-[^0-9wpvcm]$/ #check for other invalid flags
                  raise "Invalid option"

                else #invalid option, only pattern left
                  raise "Invalid combination of options"
                  
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
                
                when /^-[^0-9wpvcm]$/ #check for other invalid flags
                  raise "Invalid option" 
                
                else #invalid pairing, only pattern left
                  raise "Invalid combination of options"
                  
                end

              else
                raise "Invalid combination of options"
              end
            when /^-[^0-9wpvcm]$/ #check for other invalid flags
              
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

            when "-w", "-p", "-v"#valid options, invalid combination, only -v,-w, and -p left
              raise "Invalid combination of options"
            
            when /^-[^0-9wpvcm]$/
              raise "Invalid option"
              
            else
              raise "Invalid option" #Thrown for multiple patterns, etc.
          end
          @argIndex += 1 # increment index after processing the option
        else #Both options are filled, no longer need to process options
          break
        end

        
      end

    rescue => e #expecting invalid option or combination of options error
      puts e.message
      exit 1
    end
  end


  def patternGather #gather pattern

              
    begin
      if(@argIndex < @size) # check that there is a pattern NEEDED, no option, ruby rgrep.rb text.txt [no option] [no pattern]
        
        if(@option1.empty?) #check default case, assign if needed
          @option1 = "-p"
        end

          @argIndex = @size - 1 #set index to last element of ARGV

          if(ARGV[@argIndex].match(/-[a-z]/)) #CHECK Regexp, if it fits then its an option, not a pattern
            raise "Missing Required Arguments"
          else

            if(@option1 == "-p" || @option1 == "-v") #make pattern a regexp 
              @pattern = Regexp.new(ARGV[@argIndex])
            else
              @pattern = ARGV[@argIndex] #assign pattern to variable
            end

          end
      else
        raise "Missing Required Arguments"
      end
    rescue => e #expecting missing required arguments
      e.message
      exit 1
    
    end

  end


end


#USED FOR TEST CASES
mine = Parser.new
mine.parsing

#Test cases

#ruby rgrep.rb "h.txt" -w l
#Expected:
  #france           l 
#Actual:
  #france           l 

#ruby rgrep.rb "h.txt" -w -c l 
#Expected:
  #1
#Actual:
  #1

#ruby rgrep.rb "h.txt" -w -m l
#Expected:
#l
#Actual:
#l

#ruby rgrep.rb "h.txt" -p -m l
#Expected:
#l
#l
#l
#l
#l
#l
#l
#l
#l
#Actual:
#l
#l
#l
#l
#l
#l
#l
#l
#l

#ruby rgrep.rb "h.txt" -p "^.+\d"
#Expected:
#franky21 
#h23p
#paren509thesis
#Actual:
#franky21 
#h23p
#paren509thesis

#ruby rgrep.rb "h.txt" -p "^.*\d\w{2,}" 
#Expected:
#h23p
#paren509thesis
#Actual:
#h23p
#paren509thesis

#ruby rgrep.rb "h.txt" -p "^.*(l{2}|b{2}).*$"
#Expected:
#bubbubbus
#hello
#isabella
#tortilla
#Actual:
#bubbubbus
#hello
#isabella
#tortilla

#ruby rgrep.rb "h.txt" -p -c "^.*(l{2}|b{2}).*$"
#Expected:
#4
#Actual:
#4

#ruby rgrep.rb "h.txt" -m -p "(l{2}|b{2})"
#Expected:
#bb
#bb
#ll
#ll
#ll
#Actual:
#bb
#bb
#ll
#ll
#ll

#ruby rgrep.rb "h.txt" -v "(l{2}|b{2})"
#Expected:
#team

#france           l 
#2!tryme
#franky21
#h23p
#paren509thesis
#Actual:
#team

#france           l 
#2!tryme
#franky21
#h23p
#paren509thesis

#ruby rgrep.rb "h.txt" -c -v "(\d)"
#Expected:
#8
#Actual:
#8

#ruby rgrep.rb "h.txt" -v -m "(\d)"
#Expected:
#Invalid combination of options
#Actual:
#Invalid combination of options


#ruby rgrep.rb "h.txt" -m -v "(\d)"
#Expected:
#Invalid combination of options
#Actual:
#Invalid combination of options

#ruby rgrep.rb "h.txt" -m "(\d)"
#Expected:
#Invalid combination of options
#Actual:
#Invalid combination of options


#ruby rgrep.rb "h.txt" -m -v -v -v -v "(l{2}|b{2})"
#Expected:
#Invalid combination of options
#Actual:
#Invalid combination of options

#ruby rgrep.rb "h.txt" -v -f -v "(l{2}|b{2})"
#Expected:
#Invalid option
#Actual:
#Invalid option

#ruby rgrep.rb "h.txt" -m -w "(l{2}|b{2})" 
#Expected:
#
#Actual:
#

#ruby rgrep.rb "h.txt" -m -p -p -p -p "(l{2}|b{2})" 
#Expected:
#bb
#bb
#ll
#ll
#ll
#Actual:
#bb
#bb
#ll
#ll
#ll


#ruby rgrep.rb "h.txt" "(l{2}|b{2})" 
#Expected:
#bubbubbus
#hello
#isabella
#tortilla
#Actual:
#bubbubbus
#hello
#isabella
#tortilla