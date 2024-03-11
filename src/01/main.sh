#!/bin/bash

pattern='^[0-9]+(\.[0-9]+)?$'

if [[ $# -ne 1 ]]; then
  echo "error: many arguments"
elif [[ $1 =~ $pattern ]] ; then
  echo "error: invalid input" >&2
  exit 1
else
  echo $1
fi
