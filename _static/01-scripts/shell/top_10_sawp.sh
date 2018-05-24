#!/bin/bash
function swapoccupancy ()
{
    echo -e "Pid\tSwap\tProgame"
    num=0
    for pid in `ls -1 /proc|egrep "^[0-9]"`
    do
        if [[ $pid -lt 20 ]]
        then
            continue
        fi
        program=`ps -eo pid,command|grep -w $pid|grep -v grep|awk '{print $2}'`
        for swap in `grep Swap /proc/$pid/smaps 2>/dev/null|awk '{print $2}'`
        do
            let num=$num+$swap
        done
        echo -e "${pid}\t${num}\t${program}"
        num=0
    done|sort -nrk2|head
}
swapoccupancy
exit 0

