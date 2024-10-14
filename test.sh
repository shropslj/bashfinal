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
    exit 1
fi

# Initialize variables
file1=""
file2=""
output_file=""
regex=""

# Function to concatenate files
concatenate () {
    # Prompt user for input if not provided
    if [[ -z "$file1" ]]; then
        read -p "Enter first file: " file1
    fi

    if [[ -z "$file2" ]]; then
        read -p "Enter second file: " file2
    fi

    if [[ -z "$output_file" ]]; then
        read -p "Enter output file: " output_file
    fi

    # Check if both input files exist
    if [[ -f "$file1" && -f "$file2" ]]; then
        # Check if the output file exists
        if [[ ! -f "$output_file" ]]; then
            echo "Output file does not exist. It will be created."
        fi

        # Check if a regex is provided and filter the files using the regex
        if [[ -n "$regex" ]]; then
            echo "Filtering lines matching regex: $regex"
            grep -E "$regex" "$file1" > "$output_file"
            grep -E "$regex" "$file2" >> "$output_file"
        else
            # If no regex, concatenate files directly
            cat "$file1" "$file2" > "$output_file"
        fi
        
        echo "Concatenated file has been created: $output_file"
    else
        echo "One or both of the input files do not exist. Please try again."
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
            file1="$2"
            file2="$3"
            output_file="$4"
            shift 3  # Shift the arguments so they don't conflict with the next option
            ;;
        
        # Option to use regular expression for filtering
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

# Call the concatenate function only if the `-c` option was used
if [[ -n "$file1" && -n "$file2" && -n "$output_file" ]]; then
    concatenate
else
    echo "Error: Missing input files or output file."
fi


