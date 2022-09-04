#!/bin/bash
function deleteTable()
{
    flag=true
    echo "enter your table that u wanna delete "
    read -r  table_name 
    while $flag 
    do
    if [[ -f $table_name ]];then
        #check if it has lines more than 2  if not  we delete direct
        if [[ $( wc -l $table_name | cut -d " " -f1 ) =~ 2 ]];then
            rm $table_name
            flag=false
            echo "-------------------------"
            echo "$table_name deleted successfully"    
            echo "-------------------------"

            break

        else
            echo "table contains some data "
            select choice in "yes for delete" "no for stop deleting"
                do
                case $choice in
                    "yes for delete")
                        rm $table_name
                        clear
                        echo "-------------------------"
                        echo "$table_name deleted successfully"    
                        echo "-------------------------"
                        break
                    ;;
                    "no for stop deleting")
                        clear
                        break
                    ;;
                    *)
                    break;;
                esac
            done
        showTable_menu
        fi

    elif [[ $table_name =~ [^((0-9)|(a-z)|(A-Z)|\s)] ]];then
    echo "table name cant use a special char , enter new db name or type c to cancel "
    read -r  table_name
    if [ $table_name = "c" ];then
    break
    fi
    else
        echo "table not exists , enter new db name or type c to cancel "
        read -r  table_name
        if [ $table_name = "c" ];then
        break
        fi

    fi
    done
} 
