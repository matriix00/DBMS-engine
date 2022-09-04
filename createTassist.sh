#!/bin/bash


function asisst(){
#create 2 arrays for colnames,coltypes
arrn=()
arrt=()
echo "enter your primary key name " 
while true
do
#read primary key name from user 
read -r pkname
#now we check if name not equal zero
    if [ -n $pkname ];then
        if [[ $pkname =~ (^[a-zA-Z]+[_a-zA-Z0-9]*$) ]];then
            #if it passed if condition 
            #we will add name to colnames array 
           arrn+="$pkname "
 
           break
        else 
            echo "Invalid input can not be special char ,enter again"     
        fi

    else
        echo "invalid input can not be null ,enter again"
    fi
done


#now we ask for pk data type
#same as before
echo "enter your primary key datatype var or num" 
while true
do
read -r pktype

    if [ -n $pktype ];then
        if [[ $pktype =~ (^[a-zA-Z]+[^0-9]*$)  ]];then
            arrt+="$pktype "
            break
        else 
            echo "Invalid input can not be special char ,enter again"     
        fi

    else
        echo "invalid input can not be null ,enter again"
    fi
done

#here we ask for oother columns
echo "how many attribute do wanna add " 
while true
do
read -r ntimes
if [ -n $ntimes  ];then
    #and now we check if input number of colums  is a digit or not
    if [[ $ntimes =~ [0-9]+ ]];then
        break
    else
    echo "rows must be number "
    fi
else
echo "input can not be null"
fi
done

#make start point as j =1 because we wanna print number tart with 1
let j=1
while [ $j -le "$ntimes" ]
do
flagn=true
flagt=true
    echo "enter your $j rd attribute name "
    while $flagn
    do
    read -r colname
        #check if not equal zero
        if [ -n $colname ];then
        #check if equal that expression
            if [[ $colname =~ (^[a-zA-Z]+[_a-zA-Z0-9]*$) ]];then
            #check if is that name exists before ,so can not make multiple columnss with same name
                if [[ ${arrn[*]}  =~ $colname ]];then
                    echo "can not use col name : $colname twice, please enter again"
                else
                flagn=false
                fi
            else 
                echo "Invalid input can not be special char ,enter again"     
            fi

        else
            echo "invalid input can not be null ,enter again"
        fi
    done
    arrn+="- $colname "

    echo "enter your $j rd attribute datatype "
    while $flagt
    do
    read -r coltype

        if [ -n $coltype ];then
            if [[ $coltype =~ (^[a-zA-Z]+[_a-zA-Z0-9]*$) ]];then
                
                flagt=false
            else 
                echo "Invalid input can not be special char ,enter again"     
            fi

        else
            echo "invalid input can not be null ,enter again"
        fi
    done
    arrt+="- $coltype "

    ((j++))
    done
    #after adding data to array 
    #we should write it into a file
for((b=0;b<${#arrn[@]};b++));
do
    echo ${arrn[$b]} >> $curr_table
done
for((a=0;a<${#arrt[@]};a++));
do
    echo ${arrt[$a]} >> $curr_table
done
    clear
    echo "-------------------------"

	echo "$curr_table table created"

    echo "-------------------------"

}