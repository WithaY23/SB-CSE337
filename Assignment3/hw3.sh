#Problem 1

: ' 
move .c files from src_dir to dest_dir


mv command to move .c from src
-e to show dir_src exists

'
#sed '0,/Apple/{s/Apple/Banana/}' input_filename

#move .c files from dirA to dirB, ensuring same file tree structure

#from 0th character to first instance of Apple replace Apple with Banana
src_dir="../.."
dest_dir="../Assignment1"
for item in $(find "$src_dir" -type f -name "dummy.txt"); do


    echo "Before: $item"
    
    # Remove leading source directory part from the file path
    x=$(echo "$item" | sed "s|^$src_dir/||")
    
    echo "After: $x"


    #   # Get the parent directory of the current .c file
    # parent_dir=$(dirname "$file")

    # # Count the number of .c files in this directory
    # num_c_files=$(find "$parent_dir" -maxdepth 1 -type f -name "*.c" | wc -l)



    #count the number of .c files in the directory
    if [ $"(ls "${src_dir}/${x}" | wc -l)" -ge 3 ]; then
        #make it interactive 
        read -p "Move files in ${src_dir}${x} containing +3 .c files?" confirmation
        if [ "${confirmation}^" = "Y" ]; then
            mv "${src_dir}/${x}" "${dest_dir}/${x}" 
        else 
            echo "Skipping ${src_dir}/${x}"
        fi
    else
        #no interaction needed, just move files
        mv "${src_dir}/${x}" "${dest_dir}/${x}"
        
    fi

    # mv "${src_dir}${x}"



done


#https://stackoverflow.com/questions/148451/how-to-use-sed-to-replace-only-the-first-occurrence-in-a-file
#'0,/${src_dir}/{s/${src_dir}/''}' 
