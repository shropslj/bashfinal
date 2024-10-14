#!/bin/bash

# Function to display help/usage information
function display_usage () {
    echo "Usage: enter -cr for concatenator and regex filtering; file1 file2 output_file"
    echo ""
    echo "Options:"
    echo "-c                          Concatenate files. Use with -r for regex filtering."
    echo "-r 'regex'                  Enter a regular expression to filter lines."
    echo "-h                          Display help information."
    echo ""
    echo "Example:"
    echo "./Script.sh -cr file1.txt file2.txt output.txt '^pattern'"
    exit 1
}

# If no arguments are passed
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
    # Check if both input files exist
    if [[ -f "$file1" && -f "$file2" ]]; then
        # Check if the output file exists
        if [[ ! -f "$output_file" ]]; then
            echo "Output file does not exist. It will be created."
        fi

        # Check if a regex is provided, and filter using the regex
        if [[ -n "$regex" ]]; then
            echo "Filtering lines matching regex: $regex"
            grep -E "$regex" "$file1" > "$output_file"
            grep -E "$regex" "$file2" >> "$output_file"
        else
            # If no regex is provided, concatenate files normally
            cat "$file1" "$file2" > "$output_file"
        fi
        
        echo "Concatenated file has been created: $output_file"
    else
        echo "One or both of the input files do not exist. Please try again."
    fi
}

# Process options
while getopts ":hcr:" opt; do 
    case $opt in
        # Option to display help
        h)
            display_usage
            ;;
        
        # Option to concatenate files
        c)
            ;;
        
        # Option to provide regular expression for filtering
        r)
            regex=$OPTARG
            ;;
        
        # Invalid option handling
        \?)
            echo "Invalid option: -$OPTARG"
            display_usage
            ;;
        
        # Missing argument for options
        :)
            echo "Option -$OPTARG requires an argument."
            display_usage
            ;;
    esac
done
shift $((OPTIND - 1))

# postions for arguments after files
if [[ "$#" -ge 3 ]]; then
    file1="$1"
    file2="$2"
    output_file="$3"
else
    echo "Error: Missing input files or output file."
    display_usage
    exit 1
fi

# concatenate if -c is entered
concatenate



