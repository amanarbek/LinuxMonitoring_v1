#!/bin/bash

pattern='\/$'

if [[ $# -lt 1 ]]; then
  echo "Where is argument, bitch?"
  exit 1
elif [[ $# -gt 1 ]]; then
  echo "Only one argument!"
  exit 1
elif ! [[ $1 =~ $pattern ]] ; then
    echo "The parameter must end with '/', for example : \
script05.sh /var/log/"
    exit 1
fi

start=$(date "+%s.%N")
find $1* -type d | wc -l | \
awk '{print "Total number of folders (including all nested ones) = " $1 }'
echo "TOP 5 folders of maximum size arranged in descending order (path and size): "
find $1* -maxdepth 0 -type d -exec du -h {} \; | head -n 5 | sort -rh \
| awk '{print NR " - " $2 ", " $1}'
ls -la $1 | head -n 1 | awk '{print "Total number of files = " $2 }'
echo "Number of:"
find $1*.conf 2> /dev/null | wc -l | awk '{print "Configuration files (with the .conf extension) = " $1 }'
find $1*.txt 2> /dev/null | wc -l | awk '{print "Text files = " $1 }'
find $1* -maxdepth 0 -executable -type f | wc -l | awk '{print "Executable files = " $1 }'
find $1*.log 2> /dev/null | wc -l | awk '{print "Log files (with the extension .log) = " $1 }'
find $1*.rar $1*.7z $1*.tar $1*.zip 2> /dev/null | wc -l | awk '{print "Archive files = " $1 }'
find $1* -maxdepth 0 -type l | wc -l | awk '{print "Symbolic links = " $1 }'
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
source ./top_10_files
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
source ./top_10_executable_files
end=$(date "+%s.%N")
calc="scale=1; $start / $end"
echo -n "Script execution time (in seconds) = "
bc <<< $calc | sed 's/^\./0\./'
