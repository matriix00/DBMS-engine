#!/bin/bash

function connectDB(){
    echo "enter your db name "
    read -r dbname
    flag=true
    while $flag 
    do
     if [ -z $dbname ];then
     echo "db can not be null , enter new db name or type c to cancel "
    read -r  dbname
        if [ $dbname = "c" ];then
            break
        fi
        elif [[ -d databases/$dbname ]];then
            curr_db=$dbname
             export $curr_db
            clear
            cd databases/$dbname
            echo "-------------------------"            
            echo "$dbname successfully connected "
            echo "-------------------------"
            showTable_menu
        elif [[ $dbname =~ [^((0-9)|(a-z)|(A-Z)|\s)] ]];then
            echo "db name cant use a special char , enter new db name or type c to cancel "
            read -r  dbname
            if [ $dbname = "c" ];then
            break
            fi
        else
            if [ ! -d databases ];then
                echo "data base is empty "
                break
            else
                echo "database name not exist , or type c to cancel "
                read -r  dbname
                if [ $dbname = "c" ];then
                break
                fi
            fi
        fi
    done 
}
