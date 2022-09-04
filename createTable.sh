#!/bin/bash

function createTable()
{
	echo "enter your table name "
    read -r  table_name

    flag=true
    while $flag 
    do
    if [[ -f $table_name ]];then
      echo "table exists , enter new table name or type c to cancel " 
      read -r table_name
      if [ $table_name = "c" ];then
        break
      fi
    elif [[ $table_name =~ (^[a-zA-Z]+[0-9]*$) ]];then
		
		
      flag=false
      curr_table=$table_name
      export curr_table
      #call assist table to complete creation
      asisst
      else
      echo "table name cant use a special char , enter new db name or type c to cancel " 
      read -r table_name
      if [ $table_name = "c" ];then
      break
        fi
    fi
    done
    

} 
