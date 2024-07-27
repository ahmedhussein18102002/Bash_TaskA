#!/usr/bin/bash

###################################################################################
# @auther : Ahmed Hussein
# @date   : 27/7/2024
# @description :
#       The code is used to organize a specific directory and 
#       make sub-directories according to the extention of files
####################################################################################
if [ -z "$1" ]; then
    echo "Error,no directory received!"
    exit 1
fi
##########################################################################################
DIR=$1
######################################################################################

function organize () {
    shopt -s dotglob nullglob
    mkSub "$1" 
    place  "$1"
    shopt -u dotglob nullglob
  return 0
}

function mkSub () {
        temp=0

        for file in "$1"*; do
            if [ -f "${file}" ]; then
               EXT="${file##*.}" 
               if [ "${file##*.}" == "${file#.*}" ];then   #${file#.*} if there is a dot . in the first remove it ,because it will be removed from ${file##*.} in case of extentionless.
                 EXT="misc"
               fi
               if [[ "$(basename "$file")" == .* ]]; then
                    EXT="hidden"
               fi
             fi
            for directory in "$1"*; do
                    if [[ "${directory}" == "$1$EXT"  ]]; then
                      temp="1"
                      break
                    fi
            done
            if [ "$temp" != "1" ] ;then
                mkdir -p "$1$EXT/"
            fi
        done
   return 0 
}

function place () {
    for file in "$1"*; do
        if [ -f "${file}" ]; then
            EXT="${file##*.}" 
            if [ "${file##*.}" == "${file#.*}" ];then
                EXT="misc"
            fi
            if [[ "$(basename "$file")" == .* ]]; then
                    EXT="hidden"
            fi
            mv "${file}" "$1$EXT/"
        fi
        
    done
   return 0 
}

###########################################################################################

function main () {
    organize "$1"
    echo "Organization done succesfully !"
}

main "$DIR"


