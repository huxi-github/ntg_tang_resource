#!/bin/bash

# 系统监控,指定程序的cpu使用情况

# *** config start ***

#刷新周期
CYCLE=1
#网卡配置

PROGRAM=top

# 当前目录路径
ROOT=$(cd "$(dirname "$0")"; pwd)


# log 文件路径
CPU_LOG="${ROOT}/cpu/cpu.log"

# 获取CPU占用
function GetCpu() {
#    cpufree=$(vmstat 1 1 |sed -n '3,$p' |awk '{x = x + $15} END {print x/5}' |awk -F. '{print $1}')
    cpu=$(top -b -n 1 | grep $PROGRAM | awk '{print $9}')

    echo "${cpu}"
}


# *** function end ***

# 测试输入参数

while [ true ]
do
    echo "Please enter program's name :"
    read INTERFACE
    if [ -z "$PROGRAM" ]; then
        continue
    else
        break
    fi
done
       

while [ true ]
do
    echo "Please enter refresh cycle(such as 5) :"
    read CYCLE
    if [ -z "$CYCLE" ]; then #-z zero
        continue
    else
        break
    fi
done 


#清空原有文件内容
srcDir="${ROOT}/cpu"
for f in $( find $srcDir -name "*.log" )
do
   
    rm $f
    #mv $f anywhere
    if [ $? == 0 ]
    then
        echo "${f} is removed successfully."
    else
        echo "WARN: ${f} cannot be removed."
    fi
done

cout=1
while [ true ]
do
    echo "the times------${cout}-----"
    cout=$((cout + 1))

    cpuinfo=$(GetCpu)

    echo "${cpuinfo}"
    echo "${cpuinfo}" >> "${CPU_LOG}"

done
exit 0

