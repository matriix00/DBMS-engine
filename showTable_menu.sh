#!/bin/bash
. ./listTables.sh

function showTable_menu(){
select request in "create table" "list tables" "delete table" "insert table" "select table" "update table" "delete row" "Main menu" "exit Database Engine"
do 
case $request in
    "create table") 
        createTable
        showTable_menu

    ;;
    "list tables")
    listTables 
    showTable_menu
    ;;
    
    "delete table") 
    deleteTable
    showTable_menu
    ;;
    
    "insert table")
    insertRow
    showTable_menu
    ;;

     "select table") 
     select_table
     showTable_menu
    ;;
    "update table")
    update_table
    showTable_menu
    ;;
    "delete row")
    delete
    showTable_menu
    ;;
    "Main menu")
        clear
        cd ../../
        showDB_menu
    ;;
    "exit Database Engine")  
    figlet -f slant "bye bye my friend "
    exit
    
    break
    ;;
    *) echo "not exist try again "
    ;;
esac
done

}