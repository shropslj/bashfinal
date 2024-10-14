#!/bin/bash

#Text File Concatenator
#This script should concatenate multiple text files into a single output file

function display_usage () {
echo "Usage: $0 [-c file1 file2... -o output_file] [-p pattern] [-h]"
echo "Files 1 and 2 must already exist"
echo ""
echo "Options: "
echo "-h                 display help information"
echo "-c file1 file2     begin concatenating files"
echo ""
echo "-o output_file     specify the output file"
echo ""
exit 1
}

#If no arguments
if [ $# -eq 0 ]; then
    Echo "Error: Missing Arguments"
    display_usage
    exit
fi

#intialize variables
files =()
file1=""
file2=""
outputfile=""

#parse options with getopt
while getopts ":h:c"; do 
    case $opt in

    #option h to display help

    h) 
    display_usage
    ;;

    #option to specify output file

    o)
        output_file=$OPTARG
        ;;

    #invalid options
    \?)
         echo "Invalid option: -$OPTARG"
            display_usage
            ;;
        # no argument
    : ) echo "Option -$OPTARG requires an argument."

            # display usage and exit
            display_usage
          ;;

    esac
done

