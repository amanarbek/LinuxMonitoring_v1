#!/bin/bash

. ./conf
pattern='^[1-6]?$'
white=97
red=31
green=32
blue=34
purple=35
black=30
endcolor='\e[0m'
colors=([1]=$white [2]=$red [3]=$green [4]=$blue [5]=$purple [6]=$black)
names_color=([1]=white [2]=red [3]=green [4]=blue [5]=purple [6]=black)
conf_colors=([1]=$column1_background [2]=$column1_font_color\
 [3]=$column2_background [4]=$column2_font_color)
text="The font and background colors \
of one column must not match. Please, \
call the script again."

if [ $# -gt 0 ]; then
  echo "error: many arguments"
  exit 1
fi

for value in ${conf_colors[@]}
  do
  if [[ $value =~ $pattern ]]
    then
      continue
    else
      echo parameters are numeric. From 1 to 6.
      exit 1
  fi
done

if [[ ! $column1_background ]]; then
  var1=$(( $white + 10))
  color1=white
  column1_background=default
else
  var1=$(( ${colors[$column1_background]} + 10))
  color1=${names_color[$column1_background]}
fi
if [[ ! $column1_font_color ]]; then
  var2=$(( $black))
  color2=black
  column1_font_color=default
else
  var2=$(( ${colors[$column1_font_color]}))
  if [[ $column1_background -eq $column1_font_color ]]; then
    echo $text
    exit 1
  fi
  color2=${names_color[$column1_font_color]}
fi
if [[ ! $column2_background ]]; then
  var3=$(( $white + 10))
  color3=white
  column2_background=default
else
  var3=$(( ${colors[$column2_background]} + 10))
  color3=${names_color[$column2_background]}
fi
if [[ ! $column2_font_color ]]; then
  var4=$(( $black))
  color4=black
  column2_font_color=default
else
  var4=$(( ${colors[$column1_font_color]} ))
  if [[ $column2_background -eq $column2_font_color ]]; then
    echo $text
    exit 1
  fi
  color4=${names_color[$column2_font_color]}
fi

source ./system_research | \
awk '{print echo "\033['$var1'm" "\033['$var2'm" $1, \
"\033[0m" $2, $1="", $2="", "\033['$var3'm" "\033['$var4'm" $0, "\033[0m"}'
echo "Column 1 background = $column1_background ($color1)
Column 1 font color = $column1_font_color ($color2)
Column 2 background = $column2_background ($color3)
Column 2 font color = $column2_font_color ($color4)"
