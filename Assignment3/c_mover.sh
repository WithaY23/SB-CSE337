#Problem 1



: '
Test case 1: Works
 ./c_mover.sh Assignments/Assignment3/ Assignments/Assignment1
Uses subdir-3 supersubdir-1 dir-2; replace subdirs

Test case 2: Works
 ./c_mover.sh ./Assignments/Assignment3/ Assignments/Assignment1/
Uses subdir-4 supersubdir-2 dir-2 with txt files; create subdirs; prompts user confirmation

Test case 3: Works
 ./c_mover.sh Assignments/myFolder/ Assignments/yourFolder 
Outside of execution files initial directory, contains a folder with ".c" in the name, txt files 6-dir, 1-subdir; prompts user confirmation
Test case 4: Works
 ./c_mover.sh Assignments/Assignment3 Assignments/Assignment1
Tells no in parent, but needs to go to sub to move, still processes, 4-subdir, 2-supersubdir, 2 dir w/ other files and directory
Test case 5: Works
 ./c_mover.sh Assignments/myFolder/c.c_dontmove/ Assignments/Assignment3
 Moves file in subdir outside of immediate dir to immediate dir, 1 file moved
Test case 6: Works
 ./c_mover.sh b
Invalid number of arguments
Test case 7: Works
 ./c_mover.sh b a
Invalid src_dir path
'

: ' 
move .c files from src_dir to dest_dir


'


#verify input arguments are equal to 2 in format src_dir dest_dir
if [ "$#" -ne 2 ]
then 
    echo "src and dest dirs missing."
else

    src_dir="$1"
    if [ ! -d "$src_dir" ]
    then
        echo “$src_dir not found”
        exit 0
    else
        dest_dir="$2"







        cFiles=$(find "$src_dir" -type f -name "*.c")
        cInitialDirectories=$(find "$src_dir" -type f -name "*.c" | sed 's|/[^/]*$||' | sort | uniq) #gather the directories with c, remove repeats
        cDirectories=$(echo "$cInitialDirectories"| sed "s|^$src_dir/||") #remove the source directory from all
        cDirectories=$(echo "$cDirectories"| sed "s|^$src_dir$|.|") #if .c file is in source directory, represent as . to add later





        IFS=$'\n'  # Set Internal Field Separator to newline
        for strippedDir in $cDirectories; do #this strippedDir will not have the src_dir


                

            
            relative_dir="$strippedDir"
            dest_path="$dest_dir/$relative_dir" #no srcdir, can add dest_dir on
        
        
            mkdir -p "$dest_path"

            dir="$src_dir/$strippedDir" #add src_dir back on after dest_path


            countC=$(find "$dir" -maxdepth 1 -type f -name "*.c" | wc -l) #get the number of c files in current directory only
            
            if [ "$countC" -gt 3 ] #make interactive if greater than 3
            then
                read -p "Move files in ${dir} containing +3 .c files?" confirmation
            
                if [[ "$confirmation" == [yY] ]]; then
                echo "Moving files"
                
                    for file in "$dir"/*.c #match all the files with .c and move
                    
                    do
                        if [ -f "$file" ] #make sure it is a file (dirs can in their name)
                            then
                            mv "$file" "$dest_path/" 
                            echo "Moved $file to $dest_path/"
                        fi
                    done
                    
                else  #no, skip this directory
                    echo "Skipping $dir"
                fi
            else
                for file in "$dir"/*.c #move all if less or equal to 3
                
                do
                    if [ -f "$file" ]
                        then 
                        mv "$file" "$dest_path/"
                        echo "Moved $file to $dest_path/"

                    fi
                done


            fi
        done
    fi
fi
    

