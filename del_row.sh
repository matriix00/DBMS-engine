#!/bin/bash

function delete(){

    while true
    do
        echo "Enter table name u wanna select "
        read -r tname
        if [ -n "$tname" ];then
            
            if [ -f "../../databases/$curr_db/$tname" ];then
            
                echo "enter id for row that u wanna delete "
                echo "---------------------------"
                while true
                do
                    if [ -n $id ];then
                        read -r id          
                        #awk here will print  value  if id exists in the file 
                        value=$(awk -F " " -v key=$id ' { if($1==key){ print $0 } }' ../../databases/$curr_db/$tname)

                        if [[ -n $value ]];then
                            echo "---------------------------"
                            echo "deleted row was : "
                            #here we print row we wanna delete
                            awk -F " " -v key=$id ' { if($1==key){ print $0 } }' ../../databases/$curr_db/$tname
                            echo "---------------------------"
                            #and now we should get colum number to delete it from a file
                            col_num=$(awk -F " " -v key=$id ' { if($1==key){ print NR } }' ../../databases/$curr_db/$tname)
                            #sed i to force delete from the file actual action 
                            sed -i "$col_num d" ../../databases/$curr_db/$tname
                            echo " row deleted "
                            echo "========================================="
                            break
                            
                        else
                            echo "invalid id, enter valid id "
                        fi
                    else
                        echo "id can not be null"
                    fi
                done
                break
            else 
                    echo "table name does not exist "
            fi
        else 
            echo "table name can not be null"
        fi
    done

}