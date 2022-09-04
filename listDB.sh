#!/bin/bash

function listDB(){
    #check db folder exists
    if [ -d databases ];then
    clear
    echo "------------------------------------------------"
     echo "all existing databases"
    echo "------------------------------------------------"
    ls  databases/    
    echo "================================================"
    

    else
        echo "database is empty !! "
    fi
}
