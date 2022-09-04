#!/bin/bash

function deleteDB()
{
    
    flag=true
    echo "enter your data base u wanna delete "
    read -r dbname 
    while $flag 
    do
    if [ -z $dbname ];then
    echo "db name can not be null , enter new db name or type c to cancel "
    read -r  dbname
        if [ $dbname = "c" ];then
            break
        fi
    elif [[ -d databases/$dbname ]];then
        if [[ -z $(ls databases/$dbname) ]];then
            rm -r databases/$dbname
            flag=false
            clear
            echo "----------------------"
            echo "$dbname db deleted successfully"
            echo "----------------------"
        else
            echo "Data base contains some tables "
            
            select choice in "yes for delete" "no for stop deleting"
            do
            case $choice in
                "yes for delete")
                    rm -r databases/$dbname
                    flag=false
                    clear
                    echo "----------------------"
                    echo "$dbname db deleted successfully"
                    echo "----------------------"
                    showDB_menu
                ;;
                "no for stop deleting")
                clear
                showDB_menu
                ;;
                *)
                break;;
            esac
            done
        fi
            
    elif [[ $dbname =~ [^((0-9)|(a-z)|(A-Z)|\s)] ]];then
    echo "db name cant use a special char , enter new db name or type c to cancel "
    read -r  dbname
    if [ $dbname = "c" ];then
    break
    fi
    else
        echo "db not exists , enter new db name or type c to cancel "
        read -r  dbname
        if [ $dbname = "c" ];then
        break
        fi

    fi
    done
} 
