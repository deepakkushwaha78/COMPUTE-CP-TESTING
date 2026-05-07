#- dir already exist
####- dir path incorrect
####- dir permission to create new dir


fun_warn_logging() {
date=$(date)
user=$(whoami)
log_message=$@
file_path="./1/access.log"
echo "$date   $user  [WARN] $action function $log_message " >> $file_path
}

fun_info_logging() {
date=$(date)
user=$(whoami)
log_message=$@
file_path="./1/access.log"
echo "$date   $user  [INFO] $action function $log_message " >> $file_path
}


fun_adddir() {
    local dir_path=$1
    local dir_name=$2

    if [ -d "$dir_path" ];
    then
        mkdir $dir_path/script_test 2> /dev/null
        output=$(echo $?)
        rm -rf $dir_path/script_test
        if [[ "$output" == "0" ]];
        then
            if [ -d "$dir_path/$dir_name" ];
            then
                echo "$dir_name already exist in $dir_path"
                fun_warn_logging $dir_name already exist in $dir_path 
            else
                mkdir $dir_path/$dir_name
                echo "$dir_name is created"
                fun_info_logging $dir_name is created in $dir_path
            fi
        else
            echo "User doesn't have permission to create directory in $dir_path"
            fun_warn_logging "User doesn't have permission to create directory in $dir_path"
        fi
    else
        echo "$dir_path is incorrect please check"
        fun_warn_logging $dir_path is incorrect please check
    fi  
}

deletedirectory() {
    local dir_path=$1
    local dir_name=$2
    rm -r $dir_path/$dir_name
    echo "$dir_name is deleted" 
}


