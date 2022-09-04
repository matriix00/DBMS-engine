#!/bin/bash

function createDB()
{
    echo "enter your db name "
    read -r  dbname

    flag=true
    while $flag 
    do
    if [[ $dbname =~ (^[a-zA-Z]+[0-9]*$) ]];then
        if [[ -d databases/$dbname ]];then
        echo "db exists , enter new db name or type c to cancel "
        read -r  dbname
            if [ $dbname == "c" ];then
            break
            fi
        else
        mkdir -p databases/$dbname
            
            flag=false
            curr_db=$dbname
            export curr_db
            clear
                echo "-------------------------"

            echo "$dbname data base created"
                echo "-------------------------"

 
            
        fi
   
    else
    echo "db name cant start with number,special , enter new db name or type c to cancel "
    read -r  dbname
        if [[ $dbname = "c" ]];then
        break
        fi
    
    fi
    done
} 
