read -p "Enter opt (0. Names ,1. Numbers):" opt 

if [ $opt -eq 0 ] # Names
then 
    for name in Hassan Ali Mohamed
    do 
        echo $name
    done
elif [ $opt -eq 1 ] # Numbers 
then
    for i in {1..5}
    do 
        echo $i 
    done 
else 
    echo "Invaild Chose"
fi 


