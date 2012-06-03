#!/bin/bash
run1=$1
test1=$($1)
test1Solution=$(grep "$run1" tests )
tput sgr0                               # Reset colors to "normal."  
if [[ $test1Solution == *?$test1 ]]; then
echo -e $run1 '\E[0;32mPass'
else
  echo -e $run1 '\E[0;31mFail\n'$test1Solution" expected but got "$test1
fi
tput sgr0                               # Reset colors to "normal."  

