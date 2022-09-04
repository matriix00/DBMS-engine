 #!/bin/bash

insertRow()
{
	tName=""
	#asks user to get table name to insert 
	echo "Please enter the table you want to insert into";
    	read tName
	while true 
	do
		#check existence for the file to make operation on it
		if [ -f "../../databases/$curr_db/$tName" ]
		then
			break;
		else
			echo "There's no table with name $tName enter valid name"
			read tName
		fi
	done
	 #get first 2 rows name,type and save it in array
	 colNames=($(awk -F " - " ' {i = 1; if(NR==1){while (i <= NF) { print $i; ++i } }}' ../../databases/$curr_db/$tName))
	 colDType=($(awk -F " - " ' {i = 1; if(NR==2){while (i <= NF) { print $i; ++i } }}' ../../databases/$curr_db/$tName))

numOfRows=${#colNames[@]}
	# colPK=($(awk 'BEGIN{FS=" - "}{if(NR=0)print $1;}' ../../databases/$curr_db/$tName))
    # pktest=
# numOfRows
# set -x
while true
do
i=0
#here we made an array to insert a new row
	row=()
#loop on item by item in colum names and types
while (( i < numOfRows ))
do
flag=true

while $flag 
do
echo "Enter ${colNames[i]}  with data type ${colDType[i]}"
read -r input
	if [ -n $input ];then
	
		if [[ ${colDType[i]} == "num" ]];then
			if [[ $input =~ (^[0-9]+$) ]];then
			#check if is it a primary ke
				if [[ "$i" == "0" ]];then
						#and now here we check if primary key == value if it did so it will back data so we 
						#made error here so it should be unique
						value=$(awk -F "[ ]" -v key=$input ' { {if (NR> 2) {if($1==key){ print $0 }} }}' ../../databases/$curr_db/$tName)	
						if [ -z "$value" ];then
							row[i]=$input
							flag=false
						else
							echo "pk must be unique "
						fi
				else 
					row[i]=$input
					flag=false
				fi
			else	
			echo "enter a valid number "
			fi
		else 
			if [[ $input =~ (^[a-zA-Z]+[0-9]*$) ]];then
				#checkk if is it a primary key
				if [[ "$i" == "0" ]];then
						value=$(awk -F "[ ]" -v key=$input ' { {if (NR> 2) {if($1==key){ print $0 }} }}' ../../databases/$curr_db/$tName)	
						if [ -z "$value" ];then
							row[i]=$input
							flag=false
							
						else
							echo "pk must be unique "
						fi
				else
					row[i]=$input
					flag=false
				fi
			else	
			echo "enter a valid string "
			fi			

		fi
	fi
done
((i++))
done
# for((j=1;j<${#row[@]};j++));
# do
#     row+=" | "${row[$j]}
# done

#here we write alldata from array in file
echo "${row[*]}" >>  ../../databases/$curr_db/$tName
 echo "-------------------------"
echo "new row inserted successfully"
 echo "-------------------------"
echo "Do you want enter new row (press any key to enter new row except N)?"
	read ans
	if [[ "$ans" = "n" ]] || [[ "$ans" = "N" ]]
	then
	echo "========================================="
		showTable_menu
    fi 
done
# set +x

}

