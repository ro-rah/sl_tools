#!/bin/sh
# Name: component_construction.sh
# Input: folder containing buildsessionid files
# Output: component.json as described here: https://sealights.atlassian.net/wiki/spaces/SUP/pages/1235845121/Reporting+an+Integration+Build+-+Per+component+update+delete+-+Java+or+Node.js

echo "component.json file being produced:"

# Verify we are passing in an argument
if [ $# -ne 1 ]; then
	echo "Error: Expecting 1 arg, folder location containing buildsessionid files"
	exit 3
fi

# Verify the folder path exists
if [ ! -d $1 ]; then
	echo "Directory $1 DOES NOT exists."
	exit 3
else
	bsidfolderpath=$1
	
fi

#loop through folder contents
FILES="$bsidfolderpath/*"
componentlist='['
for f in $FILES
do
  echo "Processing $f file..."
  componentlist+="{"
  componentlist+=$(cat $f)
  #properly comma seperate for more than just one component.
  filecount=$(ls -1q $FILES | wc -l)
  if [ $filecount -gt 1 ]; then
	componentlist+="},"
  else
	componentlist+="}"
  fi
done
componentlist+="]"
componentlist=$( echo $componentlist | sed 's/\(.*\),/\1 /')
echo "$componentlist" > component.json

