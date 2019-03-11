#!/bin/bash
    # The arguments relevant for the user
    dirPath=$1
    program=$2
   
   
   
      
    cd $dirPath
        make   &> /dev/null
         

    clang++-5.0 $program ${@:3} &> /dev/null


    
    
    if [[ $? -gt 0 ]]; then
        answerFirst=1
        
    else
        answerFirst=0

    fi
    # Checking memory leak with valgrind
    valgrind --tool=memcheck --leak-check=full --error-exitcode=3 -q ./a.out &> /dev/null
    if [[ $? -gt 0 ]] ; then
             answerSecond=1
    else
             answerSecond=0
    fi
    
    # helgrind check
    valgrind --tool=helgrind -q ./a.out  &> /dev/null
    if [[ $? -gt 0 ]]; then
             answerThird=1
    else
             answerThird=0
    fi
   
     
       
         echo "hello";

    # binary ans request and print it in the end
     ans=$answerFirst$answerSecond$answerThird
     if [ $ans -eq '000' ]; then
         echo -e "Compilation   Memory leaks   Thread race\n    PASS         PASS           PASS"
         exit 0;
     fi
     if [ $ans -eq '010' ]; then
        echo -e "Compilation   Memory leaks   Thread race\n    PASS         FAIL           PASS"
        exit 2;
     fi
     if [ $ans -eq '001' ]; then
        echo -e "Compilation   Memory leaks   Thread race\n    PASS         PASS           FAIL"    exit 1;
     fi
   
     if [ $ans -eq '011' ]; then
        echo -e "Compilation   Memory leaks   Thread race\n    PASS         FAIL           FAIL"    exit 3;
     fi
     if [ $ans -eq '111' ]; then
        echo -e "Program is wrong  - 111" exit 7;
        
     fi


	

