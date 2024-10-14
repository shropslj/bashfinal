#!/bin/bash

# Function to display help/usage information
function display_usage () {
    echo "Usage: enter -c for concatenator; file1 file2 output_file"
    echo ""
    echo "Options:"
    echo "-c file1 file2 output_file    to concatenate"
    echo "-h                 display help information"
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

# Function to concatenate files
concatenate () {
    # Prompt user for input without $
    read -p "Enter first file: " file1
    read -p "Enter second file: " file2
    read -p "Enter a name for concatenated file: " output_file

    # Check if both files exist
    if [[ -f "$file1" && -f "$file2" ]]; then
        # Concatenate the files into the output file
        cat "$file1" "$file2" > "$output_file"
        echo "Concatenated file has been created: $output_file"
    else
        echo "One or both of the files do not exist. Please try again."
    fi
}

# Process options
while getopts ":hc" opt; do 
    case $opt in
        # Option to display help
        h)
            display_usage
            ;;
        
        # Option to concatenate files
        c)
            concatenate
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


