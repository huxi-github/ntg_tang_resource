#!/bin/bash

# 系统监控,指定核的cpu使用情况

TARGET_SET="VirtualBox"
TICKS_PER_SECOND="10"
#TARGET_NR="0"

# *** function start ***

ROOT=$(cd "$(dirname "$0")"; pwd)
CPU_LOG=""

main() {
  local cycle=$1
  local cpuNum1=$2
  local average=$3

  local cpuUsage

  local cpuAvg=0
  local count=0

  local totalCpuTime1
  local totalCpuTime2
  local processCpuTime1
  local processCpuTime2

  local total
  local idle
  local usage

  
  totalCpuTime1=($(get_cpu_total_and_idle $cpuNum))

  echo $[totalCpuTime1[0]]"  "$[totalCpuTime1[1]]

  while [ true ]
  do
    sleep "${cycle}s"

 #   echo "time1-->"${totalCpuTime1[@]}

    totalCpuTime2=($(get_cpu_total_and_idle $cpuNum))
 #   echo "time2-->"${totalCpuTime2[@]}

    total=$[totalCpuTime2[0]-totalCpuTime1[0]]
    idle=$[totalCpuTime2[1]-totalCpuTime1[1]]
    usage=$[total - idle]

    #echo "ctotal=$ctotal"
    #echo "ptotal=$ptotal"
    
    #continue
    if [ "$total" -lt 0 ] || [ "$usage" -lt 0 ]
    then
        echo "continue--->$total - $idle = $usage"
        continue
    fi
    
    if [ "$total" -eq 0 ]
    then
        cpuUsage=$(echo 0 | awk '{printf "%.2f", $0}')
    else
        cpuUsage=$(echo "scale=2; a=$usage*100/$total; if (length(a)==scale(a)) print 0;print a "|bc | awk '{printf "%.2f", $0}')
    fi

    if [ "$average" -eq 1 ]
    then
        count=$(($count + 1))
        #echo $count

        cpuAvg=$(get_average $count $cpuAvg $cpuUsage)

        #echo "$cpuUsage $cpuAvg---->$count"
        echo "$cpuUsage $cpuAvg"
        echo "---------$count-----------------"

    else
        echo "$cpuUsage" >> "${CPU_LOG}"
        echo "---------$count-------------"
    fi

    #output $CPU_USAGE

    totalCpuTime1=(${totalCpuTime2[@]})
  done

}

get_average(){
    local count=$1
    local cpuAvg=$2
    local cpuUsage=$3
    local ret
    ret=$(echo "scale=2; a=($cpuAvg*($count-1)+$cpuUsage)/$count; if (length(a)==scale(a)) print 0;print a " | bc | awk '{printf "%.2f", $0}')
    
    echo $ret
}


get_cpu_total_and_idle(){

    local ncpu=$[$1+1]
    local tickArr
    local nArr
    local CPU_FILE="/proc/stat"
    
    local ticks
    local idle


    tickArr=($(sed -n "${ncpu}p" $CPU_FILE | cut -d " " -f2-))
    nArr=${#tickArr[@]}
    
    #for i in "${!tickArr[@]}"
    for ((i=0;i<$nArr;i++))
    do 
        if [ "$i" -eq 3 ]
        then
            idle=$[tickArr[$i]]
        fi
        ticks=$[ticks + tickArr[$i]]
    done
    
#    echo "$ticks $idle ${tickArr[@]}"
    echo "$ticks $idle"
}


#获取指定cpu的ticks,0表示total
get_total_cpu_ticks(){
    local ncpu=$[$1+1]
    local utime
    local stime
    local ticks
    local CPU_FILE="/proc/stat"
    local total_time

    total_time=$(sed -n "${ncpu}p" $CPU_FILE | cut -d " " -f2-)
    echo 
    for time in $total_time
    do

        ticks=$[ticks + time]
    done

    echo $ticks
}

# *** function end ***

# 测试输入参数

#循环周期      
CYCLE=3
echo "请输入循环周期,单位为s(默认为3s) :"
read input

if [ -n "$input" ]; then
    CYCLE=$input
fi
echo $CYCLE

#cpu编号
CPU_NUM=0

echo "请输入CPU编号,(默认为0) :"
read input

if [ -n "$input" ]; then
    CPU_NUM=$input
fi
echo $CPU_NUM

#是否打印平均值
average=0
echo "是否求平均值,(1为是,0为否,默认为0) :"
read input

if [ -n "$input" ]; then
    average=$input
fi

echo $average

#是否打印平均值
file=0
echo "输入文件名:"
read input

if [ -n "$input" ]; then
    file=$input
fi
CPU_LOG="${ROOT}/${file}"

main $CYCLE $CPU_NUM $average

#get_total_cpu_ticks 0



