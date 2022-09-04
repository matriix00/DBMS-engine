#!/bin/bash

function listTables(){
    
    if [ -d ../../databases/"$curr_db" ];then
         if [ -z "$(ls "../../databases/$currentDb")" ];then
        echo "this $curr_db  is empty !! "
            
        else
            clear
            echo "------------------------------------------------"
            echo "all existing tables"
            echo "------------------------------------------------"
            ls
           echo "================================================"

        fi
    else
        echo "No table present"
    fi
}
