#!/bin/bash

# Function to display help/usage information
function display_usage () {
    echo "Usage: enter -c for concatenator; file1 file2 output_file"
    echo ""
    echo "Options:"
    echo "-c file1.txt file2.txt output_file    to concatenate. Remember to include the file extension"
    echo "-r 'regex'                           enter a regular expression to filter for"
    echo "-h                                   display help information"
    echo ""
    exit 1
}

# If no arguments
if [ $# -eq 0 ]; then
    echo "Error: Missing Arguments"
    display_usage
    exit
fi

# Initialize variables
file1=""
file2=""
output_file=""
regex=""

# Function to concatenate files
concatenate () {
    # Prompt user for input without $
    read -p "Enter first file: " file1 
    read -p "Enter second file: " file2
    read -p "Enter output file: " output_file

    # Check if both input files exist
    if [[ -f "$file1" && -f "$file2" ]]; then
        # Check if the output file exists
        if [[ ! -f "$output_file" ]]; then
            echo "Output file does not exist. It will be created."
        fi

        # Check if a regex is provided. Filter using regex
        if [[ -n "$regex" ]]; then
            echo "Filtering lines matching: $regex"
            grep -E "$regex" "$file1" > "$output_file"
            grep -E "$regex" "$file2" >> "$output_file"
        else
            # If no pattern
            cat "$file1" "$file2" > "$output_file"
        fi
        
        echo "Concatenated file has been created: $output_file"
    else
        echo "One or both of the input files do not exist, try again."
    fi
}

# Process options
while getopts ":hc:r:" opt; do 
    case $opt in
        # Option to display help
        h)
            display_usage
            ;;
        
        # Option to concatenate files
        c)
            concatenate
            ;;
        
        r) 
        regex=$OPTARG
        ;;
        # Invalid options
        \?)
            echo "Invalid option: -$OPTARG"
            display_usage
            ;;
        
        # Missing arguments for options
        :)
            echo "Option -$OPTARG requires an argument."
            display_usage
            ;;
    esac
done
shift $((OPTIND - 1))

# Check if files are provided
if [[ -z "$file1" || -z "$file2" || -z "$output_file" ]]; then
    echo "Error: Missing input files or output file."
fi


