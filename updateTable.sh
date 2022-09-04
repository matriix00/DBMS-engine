#!/bin/bash
function update_table(){
while true
do
    echo "Enter table name u wanna select "
    read tname
    if [ -n "$tname" ];then
        
        if [ -f "../../databases/$curr_db/$tname" ];then
            echo "enter id for row that u wanna update"
            echo "---------------------------"

            read -r id
            awk -F " - " ' { {if (NR<=2) { print $0} }}' ../../databases/$curr_db/$tname
            echo "---------------------------"

            value=$(awk -F " " -v key=$id ' { if($1==key){ print $0 } }' ../../databases/$curr_db/$tname)	
						if [ -z "$value" ];then
							echo "id does not exist "
							
						else
                            echo "enter column name that u wanna update "
                            read -r colname
                            if [ -n "$colname" ];then
                                #get column name if exists it will return value
                                colval=$(awk -F " " -v key="$colname" ' {if (NR==1) {i=1; while(i<=NF){ if($i==key){ print $i;} i++;} } }' ../../databases/$curr_db/$tname)	
                                 #get id colum 
                                idcolname=$(awk -F " - " ' { if (NR==1){print $1}}' ../../databases/$curr_db/$tname)
                                #get column number by looping on all column for exact value
                                
                                col_number=$(awk -F " - " -v key="$colname" ' {if (NR==1) {i=1; while(i<=NF){ if($i==key){ print i;} i++;} } }' ../../databases/$curr_db/$tname)
                                # we have column number so we can get data type 
                                coltype=$(awk -F " - " -v key="$col_number" ' {if (NR==2) { print $key; }  }' ../../databases/$curr_db/$tname)
                                # we have id so we can get value of that id 
                                old_val=$(awk -F " " -v col_num="$col_number" -v key=$id ' { if($1==key){ print $col_num } }' ../../databases/$curr_db/$tname)
                                if [ -z $colval ];then
                                    echo "$colname does not exist "
                                else
                                    echo "enter new value for $old_val that has id = $id "
                                    read -r newval
                                    if [[ $colname == "$idcolname" ]];then
                                        echo "can not update pk $idcolname it should be unique "
                                    else
                                        if [ -n "$newval" ];then
                                            if [[ $coltype == "var" ]];then
                                                if [[ $newval =~ (^-?[a-zA-Z]+[0-9]*$) ]];then
                                                    # get row number of that id 
                                                    
                                                    update_line_number=$(awk -F'[ ]' -v id=$id '{
                                                        if ($1 == id){
                                                            print NR;
                                                        }
                                                    }' ../../databases/$curr_db/$tname)
                                                    # print updated line pasing  id,new_value,col_num check for id to get row and update col_value with new data
                                                    new_line=$(awk -F'[ ]' -v id=$id -v val=$newval -v col=$col_number '{
                                                        if ($1 == id){
                                                            $col=val;
                                                            print $0;
                                                        }
                                                    }' ../../databases/$curr_db/$tname)
                                                    # force replace at row_num  all row with new line
                                                    sed -i "$update_line_number s/.*/$new_line/" ../../databases/$curr_db/$tname
                                                    echo "line updated"
                                                fi
                                                elif [[ $coltype == "num" ]];then
                                                    if [[ $newval =~ (^[0-9]+$[a-zA-Z]*) ]];then
                                                        update_line_number=$(awk -F'[ ]' -v id=$id '{
                                                            if ($1 == id){
                                                                print NR;
                                                            }
                                                        }' ../../databases/$curr_db/$tname)
                                                        new_line=$(awk -F'[ ]' -v id=$id -v val=$newval -v col=$col_number '{
                                                            if ($1 == id){
                                                                $col=val;
                                                                print $0;
                                                            }
                                                        }' ../../databases/$curr_db/$tname)

                                                        sed -i "$update_line_number s/.*/$new_line/" ../../databases/$curr_db/$tname
                                                        echo "line updated"
                                                    fi    
                                            fi
                                        else
                                            echo "invalid input cannot be empty"
                                        fi
                                    fi
                                    
                                fi
                            fi
						fi
            if [ -n "$id" ];then
                    
                    # echo "enter attribute that u wanna change " 
                    # read akey
                  #  echo "enter value that u wanna add " 
                   # read val

                    #sed -i ""
                    break
            
               
            
            else
                echo "input cannot be null"
            fi
        else
            echo "table ddoes not exist "
        fi
    else
    echo "Enter correct table name"
    fi
done
}