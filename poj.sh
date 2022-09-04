#!/bin/bash
. ./createDB.sh
. ./deleteDB.sh
. ./listDB.sh
. ./connectDB.sh
. ./showTable_menu.sh
. ./createTable.sh
. ./deleteTable.sh
. ./listTables.sh
. ./createTassist.sh
. ./insertTable.sh
. ./selectTable.sh
. ./updateTable.sh
. ./del_row.sh

echo ""
echo "----------------------------------------------- Welcome to our DBMS Engine. -------------------------------------------- "
echo ""
function showDB_menu(){

select request in "create Database" "list Database" "drop Database" "connect Database" "exit Database Engine"
do 
case $request in
    "create Database") 
    createDB
    showDB_menu
    ;;
    "list Database") 
    listDB
    showDB_menu
    ;;
    "drop Database") 
    deleteDB
    showDB_menu
    ;;
    "connect Database") 
    connectDB
    break
        
    ;;
    "exit Database Engine")  
    figlet -f slant "bye bye my friend "
    exit
    ;;
    *) echo "not exist try again"
    ;;
esac
done

}
showDB_menu