#!/bin/bash

function display_usage () {
echo "Usage: enter -c for concatenator; file1 file2 output_file"
echo ""
echo "-c file1 file2 output_file    to concatenate"
echo "Options: "
echo "-h                 display help information"
echo ""
exit 1
}

#If no arguments
if [ $# -eq 0 ]; then
    Echo "Error: Missing Arguments"
    display_usage
    exit
fi


file1=""
file2=""
output_file=""

while getopts ":h:c"; do 
    case $opt in

    #option h to display help

    h) 
    display_usage
    ;;
    
    c) 
    concatenate ;;

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

if [ "$file1" = "" ]
then 
    echo "no input file"
fi

concatenate (){
read -p "Enter first file: " $file1
read -p "Enter second file: " $file2
read -p "Enter a name for concatenated file: "

if [ -f $file1 && $file2 ]
then
    cat $file1 $file2 >> $output_file
    echo "Concatenated file has been created"
else
echo "File does not exist, try again."
}