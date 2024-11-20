#Problem 1

: ' 
move .c files from src_dir to dest_dir


mv command to move .c from src
-e to show dir_src exists

'
#sed '0,/Apple/{s/Apple/Banana/}' input_filename

#move .c files from dirA to dirB, ensuring same file tree structure

#from 0th character to first instance of Apple replace Apple with Banana


#Gather all the filepaths that contain the desired file type
#Truncate the filename, leaving the folder name/path
#Loop over each dir path and check file amount
    #Needs to check [0 - 3+] as might be repeating a dir that has already been covered
#Based on choice, if available, loop over each dir individually and move files


#Used to gather directory name from files, getting rid of the repeat results

# for item in $(find "$src_dir" -type f -name "d[a-zA-Z]*.txt"); do
#   dirname "$item"
# done | sort | uniq


#ORIGINAL IDEA
# for item in $(find "$src_dir" -type f  -name "*.c"); do

    # dir=$(dirname "$item")


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


#Include directory used for testing in zip folder submission

#MOVE all commands to a read.me
#Test case 1: Works
# ./prog1.sh . ../Assignment1
#Uses subdir-3 supersubdir-1 dir-2; replace subdirs

#Test case 2: Works
# ./prog1.sh ./ ../Assignment1/
#Uses subdir-4 supersubdir-2 dir-2 with txt files; create subdirs

#Test case 3: Works
# ./prog1.sh ../myFolder/ ../yourFolder 
#Outside of execution file's initial directory, contains a folder with ".c" in the name, txt files 6-dir, 1-subdir
#Test case 4: Works
# ./prog1.sh . ../Assignment1
#Tells no in parent, but needs to go to sub to move, still processes, 4-subdir, 2-supersubdir, 2 dir w/ other files and directory
#Test case 5: Works
# ./prog1.sh ../myFolder/c.c_dontmove/ .
# Moves file in subdir outside of immediate dir to immediate dir, 1 file moved
#Test case 6: Works
# ./prog1.sh b
#Invalid number of arguments
#Test case 7: Works
# ./prog1.sh b a
#Invalid src_dir path


#gathter the directories with just c files
#possibly throw exception for no files found



#if need be, can deal with spaces and special characters with IFS while loop, we do it with for to resolve the confirmation being skipped
# while IFS= read -r dir; do
#     echo "Processing directory: $dir"
#     ...
# done <<< "$cDirectories"

        cFiles=$(find "$src_dir" -type f -name "*.c")
        cInitialDirectories=$(find "$src_dir" -type f -name "*.c" | sed 's|/[^/]*$||' | sort | uniq) #gather the directories with c, remove repeats
        ###echo "SourceDir: $src_dir"
        cDirectories=$(echo "$cInitialDirectories"| sed "s|^$src_dir/||") #remove the source directory from all
        cDirectories=$(echo "$cDirectories"| sed "s|^$src_dir$|.|") #if .c file is in source directory, represent as . to add later




# cDirectories=$(find "$src_dir" -type f -name "*.c" -exec dirname {} \;| sort | uniq) #use -exec dirname and sort uniq to only represent directories once
###echo "Directories:"
###echo "$cDirectories"

        IFS=$'\n'  # Set Internal Field Separator to newline DDCCCCC
        for strippedDir in $cDirectories; do #this strippedDir willnot have the src_dir


                
            # dir=$(realpath "$dir")  # Normalize the current directory path

            
            relative_dir="$strippedDir"
            dest_path="$dest_dir/$relative_dir" #no srcdir, can add dest_dir on
        
        ###    echo "DestPath: " $dest_path
        
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
                        #match file in directory with /*.c/
                        #use dirname item to get directory and keep matching items in there until no more items match
                        # mv "${src_dir}/${x}" "${dest_dir}/${x}" 
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
    
#Works for moving files in base dir, moving files with one sub dir y/n, creating directory in other dir if not there
#check multiple subdir, inner subdirs



    #$(find "$(dirname "$item")" -type f  -name "d[a-zA-Z]*.txt")
    #find "$(dirname "$item")" -type f -name "d[a-zA-Z]*.txt" | while IFS= read -r item; do THIS WHILE LOOP
  # Process each file found
#   echo "$item"  # or any processing you want
# done



    # echo "Before: $item"
    
    # # Remove leading source directory part from the file path
    # x=$(echo "$item" | sed "s|^$src_dir/||")
    
    # echo "After: $x"


    # #   # Get the parent directory of the current .c file
    # # parent_dir=$(dirname "$file")



    # # # Count the number of .c files in this directory
    # # num_c_files=$(find "$parent_dir" -maxdepth 1 -type f -name "*.c" | wc -l)


    # echo "$(find "${src_dir}/${extension}" | wc -l)"

    
    # #count the number of .c files in the directory
    # if [ "$(ls "${src_dir}/${x}" | wc -l)" -ge 3 ]; then
    #     #make it interactive 
    #     read -p "Move files in ${src_dir}${x} containing +3 .c files?" confirmation
    #     if [ "${confirmation}^" = "Y" ]; then
    #         mv "${src_dir}/${x}" "${dest_dir}/${x}" 
    #     else 
    #         echo "Skipping ${src_dir}/${x}"
    #     fi
    # else
    #     #no interaction needed, just move files

    #     # while [ "$(ls "${src_dir}/${x}" | wc -l)" -ge 1 ]
    #     # do
    #         mv "${src_dir}/${x}" "${dest_dir}/${x}"
    #     # done
        
    # fi

    # # mv "${src_dir}${x}"





#https://stackoverflow.com/questions/148451/how-to-use-sed-to-replace-only-the-first-occurrence-in-a-file
#'0,/${src_dir}/{s/${src_dir}/''}' 
