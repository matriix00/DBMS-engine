#!/bin/bash
function select_table(){
while true
do
    echo "Enter table name u wanna select "
    read tname
    if [ -n "$tname" ];then
        
        if [ -f "../../databases/$curr_db/$tname" ];then
            value=$(awk -F " " '  {if (NR> 2) { print $0  } }' ../../databases/$curr_db/$tname)
            if [ -z "$value" ];then
                echo "================================================"
                echo "Table is empty"	
                echo "================================================"
                break 
            fi
            echo "isnert * to display all rows or inset any thing to display an option "
            # # echo "--------------------------------------------------------"
            # # awk -F " - " '{ if (NR==1) print $0 }' ../../databases/$curr_db/$tname
            # # echo "--------------------------------------------------------"
            # # echo "enter concolum for row that u wanna display or isnert * to display all rows"

            # # arrcon=()
            # # arrd=()
            # # while  true
            # # do
            # #     echo "enter column name"
            # #     read -r  col_con
            # #     #dont forget check
            # #     coln=$(awk -F " - " -v key="$col_con" ' { i=1; if (NR==1) { while(i<=NF){ if($i==key){ print $0 } i++; } } } ' ../../databases/$curr_db/$tName)	
            # #     if [[ -n $coln]];then
            # #     #we found column name
            # #     arrcon+="$col_con"
            # #     echo "enter column data"
            # #     read -r  col_d
            # #     arrd+="$col_d"

            # #     select a in "click to add condition one more time" "click to stop"
            # #     do
            # #     case $a in
            # #         "click to add condition one more time")

            # #         ;;
            # #         "click to stop")
            # #             break
            # #         ;;
            # #         *);;
            # #     esac
            # #     done


            # # done
            # numOfRows=${#col_con[@]}
            # ic=0
            # while ((ic<numOfRows))
            # do
            #     value=$(awk -F " - " -v key="${arrd[@]}" ' { i=1; if (NR>2) { while(i<=NF){ if($i==key){ print $0 } i++; } } } ' ../../databases/$curr_db/$tName)	
            # ((ic++))
            # done
            while true 
            do
                read -r id
                if [ -n "$id" ];then
                    if [[ $id == "*" ]];then
                        echo "================================================"
                        echo $(awk -F " "  ' { if (NR==1) { print $0 } }' ../../databases/$curr_db/$tname)
                         echo "------------------------------------------------"
                        bn=$(wc -l ../../databases/$curr_db/$tname | cut -d " " -f1 )
                        awk -F " " -v key=$bn ' {i=NR; if(NR>2){ print $0;if(key!=NR){print "------------------------------------------------" }}  }' ../../databases/$curr_db/$tname
                        #   { { BEGIN i=1; } { if (NR> 2) { while(i<=NF){print $i" - ";i++} } }' 
                        echo "================================================"
                        break
                        
                    else
                        echo "================================================"
                        echo "colum names "
                        echo "----------------------------------------------"
                        echo $(awk -F " "  ' { if (NR==1) { print $0 } }' ../../databases/$curr_db/$tname)
                        echo "----------------------------------------------"
                        colNames=($(awk -F " - " ' {i = 1; if(NR==1){while (i <= NF) { print $i; ++i } }}' ../../databases/$curr_db/$tname))
                        echo "enter your colum that u wanna get result "
                        while true
                        do
                            read -r choice
                            if [[ " ${colNames[*]} " =~ " ${choice} " ]]; then
                                echo "enter new value u awanna search for "
                            
                                read -r val
                                
                                col_number=$(awk -F " - " -v key="$choice" ' {if (NR==1) {i=1; while(i<=NF){ if($i==key){ print i;} i++;} } }' ../../databases/$curr_db/$tname)
                                xval2=$(awk -F " " -v key=$col_number -v val_data=$val ' { {if (NR> 2) {if($key==val_data){ print $0 }} }}' ../../databases/$curr_db/$tname)
                                if [ -z "$xval2" ];then
                                echo "data not found  "
                                echo "enter new val exist in table "
                                else
                                    echo "================================================"
                                    echo $(awk -F " "  ' { if (NR==1) { print $0 } }' ../../databases/$curr_db/$tname)
                                    echo "----------------------------------------------"
                                    awk -F " " -v key=$col_number -v val_data=$val ' { {if (NR> 2) {if($key==val_data){ print $0 }} }}' ../../databases/$curr_db/$tname
                                    echo "================================================"
                                    break
                                fi
                            else
                                echo "colum name not valid ,ente again"
                            fi
                        done
                        break
                    


                        # xval=$(awk -F " " -v key=$id ' { {if (NR> 2) {if($1==key){ print $0 }} }}' ../../databases/$curr_db/$tname)
                        # if [ -z "$xval" ];then
                        #     echo "not found id = $id "
                        #     echo "enter id exist in table "
                        # else
                        #     echo "================================================"
                        #     echo $(awk -F " "  ' { if (NR==1) { print $0 } }' ../../databases/$curr_db/$tname)
                        #     echo "----------------------------------------------"
                        #     echo $xval
                        #     echo "================================================"
                        #     break
                        # fi
                    fi
                
                else
                    echo "input cannot be null"
                fi
            done
            break
        else
            echo "table ddoes not exist "
        fi
    else
    echo "Enter correct table name"
    fi
done
}
