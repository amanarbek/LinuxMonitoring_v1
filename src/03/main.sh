#!/bin/bash

argument=1
pattern='^[1-6]?$'
white=97
red=31
green=32
blue=34
purple=35
black=30
endcolor='\e[0m'
colors=([1]=$white [2]=$red [3]=$green [4]=$blue [5]=$purple [6]=$black)

if [ $# -ne 4 ]; then
  echo "error: many(few) arguments"
  exit 1
fi

for value in "$@"
  do
  if [[ $value =~ $pattern ]]
    then
      continue
    else
      echo parameters are numeric. From 1 to 6.
      exit 1
  fi
  argument=$(( $argument + 1 ))
done

var1=$1
var2=$2
var3=$3
var4=$4

if [ $var1 -eq $var2 ] || [ $var3 -eq $var4 ]
  then
    echo "The font and background colors \
of one column must not match. Please, \
call the script again."
  exit 1
fi

var2=$(( ${colors[$2]}))
var4=$(( ${colors[$4]}))
var1=$(( ${colors[$1]} + 10))
var3=$(( ${colors[$3]} + 10))

bash ./system_research | \
awk '{print echo "\033['$var1'm" "\033['$var2'm" $1, \
"\033[0m" $2, $1="", $2="", "\033['$var3'm" "\033['$var4'm" $0, "\033[0m"}'
