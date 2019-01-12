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
  local cpuNum2=$(($cpuNum1 + 1))

  local count=0

  local cpuUsage1
  local cpuUsage2


  local totalCpuTime11
  local totalCpuTime21
  local processCpuTime11
  local processCpuTime21

  local total1
  local idle1
  local usage1


  local totalCpuTime12
  local totalCpuTime22

  local processCpuTime12
  local processCpuTime22

  local total2
  local idle2
  local usage2
  
  echo "$cpuNum1 $cpuNum2"

  totalCpuTime11=($(get_cpu_total_and_idle $cpuNum1))
  totalCpuTime12=($(get_cpu_total_and_idle $cpuNum2))

  #echo $[totalCpuTime1[0]]"  "$[totalCpuTime1[1]]

  while [ true ]
  do
    sleep "${cycle}s"
    #total_time1=$(sed -n "${cpuNum1}p" "/proc/stat")
    #total_time2=$(sed -n "${cpuNum2}p" "/proc/stat")
    #echo $total_time1
    #echo $total_time2    

 #   echo "time1-->"${totalCpuTime1[@]}

    totalCpuTime21=($(get_cpu_total_and_idle $cpuNum1))
    totalCpuTime22=($(get_cpu_total_and_idle $cpuNum2))

    #echo "time21-->"${totalCpuTime21[@]}
    #echo "time22-->"${totalCpuTime22[@]}

    total1=$[totalCpuTime21[0]-totalCpuTime11[0]]
    idle1=$[totalCpuTime21[1]-totalCpuTime11[1]]
    usage1=$[total1 - idle1]

    #echo "ctotal=$ctotal"
    #echo "ptotal=$ptotal"
    
    #continue
    if [ "$total1" -lt 0 ] || [ "$usage1" -lt 0 ]
    then
        echo "continue--->$total - $idle = $usage"
        continue
    fi
    
    if [ "$total1" -eq 0 ]
    then
        cpuUsage1=$(echo 0 | awk '{printf "%.2f", $0}')
    else
        cpuUsage1=$(echo "scale=2; a=$usage1*100/$total1; if (length(a)==scale(a)) print 0;print a "|bc | awk '{printf "%.2f", $0}')
    fi

    #-----------------------------------------------
    total2=$[totalCpuTime22[0]-totalCpuTime12[0]]
    idle2=$[totalCpuTime22[1]-totalCpuTime12[1]]
    usage2=$[total2 - idle2]

    #echo "ctotal=$ctotal"
    #echo "ptotal=$ptotal"
    
    #continue
    if [ "$total2" -lt 0 ] || [ "$usage2" -lt 0 ]
    then
        echo "continue--->$total - $idle = $usage"
        continue
    fi
    
    if [ "$total2" -eq 0 ]
    then
        cpuUsage2=$(echo 0 | awk '{printf "%.2f", $0}')
    else
        cpuUsage2=$(echo "scale=2; a=$usage2*100/$total2; if (length(a)==scale(a)) print 0;print a "|bc | awk '{printf "%.2f", $0}')
    fi


    #echo -e "$cpuUsage1" >> "${CPU_LOG}.1"
    #echo -e "$cpuUsage1" >> "${CPU_LOG}.2"
    echo -e "$cpuUsage1\t$cpuUsage2" >> "${CPU_LOG}"

    #output $CPU_USAGE
    count=$(($count + 1))
    echo "---------$count-----------------"

    totalCpuTime11=(${totalCpuTime21[@]})
    totalCpuTime12=(${totalCpuTime22[@]})
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
    
    echo "$ticks $idle ${tickArr[@]}"
 #   echo "$ticks $idle"
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

echo "请输入开始的CPU编号,(默认为0) :"
read input

if [ -n "$input" ]; then
    CPU_NUM=$input
fi
echo $CPU_NUM


#是否打印平均值
file=0
echo "输入文件名:"
read input

if [ -n "$input" ]; then
    file=$input
fi
CPU_LOG="${ROOT}/${file}"

main $CYCLE $CPU_NUM

#get_total_cpu_ticks 0



