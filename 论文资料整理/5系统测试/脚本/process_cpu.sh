#!/bin/bash

# 系统监控,指定程序的cpu使用情况

TARGET_SET="VirtualBox"
TICKS_PER_SECOND="10"
#TARGET_NR="0"

# *** function start ***


main() {
  local processNames=$1
  local cycle=$2
  local cpuNum=$3
  local average=$4

  local pidSet
  local cpuUsage

  local cpuAvg=0
  local count=0

  local totalCpuTime1
  local totalCpuTime2
  local processCpuTime1
  local processCpuTime2

  local ctotal
  local ptotal


  pidSet=$(get_pids $processNames)
  
  totalCpuTime1=$(get_total_cpu_ticks $cpuNum)
  processCpuTime1=$(get_total_process_ticks $pidSet)

  echo $totalCpuTime1
  echo $processCpuTime1

  while [ true ]
  do
    sleep 3s

    totalCpuTime2=$(get_total_cpu_ticks $cpuNum)
    processCpuTime2=$(get_total_process_ticks $pidSet)

    ctotal=$[totalCpuTime2-totalCpuTime1]
    ptotal=$[processCpuTime2-processCpuTime1]

    #echo "ctotal=$ctotal"
    #echo "ptotal=$ptotal"
    
    #continue
    if [ "$ctotal" -le 0 ] || [ "$ptotal" -le 0 ]
    then
        #echo "continue--->$ctoal"
        #echo "continue--->$ptotal"
        continue
    fi

    cpuUsage=$(echo "scale=2; a=36*$ptotal*100/$ctotal; if (length(a)==scale(a)) print 0;print a "|bc | awk '{printf "%.2f", $0}')
    
    if [ "$average" -eq 1 ]
    then
        count=$(($count + 1))
        #echo $count

        cpuAvg=$(get_average $count $cpuAvg $cpuUsage)

        echo "$cpuUsage $cpuAvg---->$count"

    else
        echo $cpuUsage
    fi

    #output $CPU_USAGE

    totalCpuTime1=$totalCpuTime2
    processCpuTime1=$processCpuTime2
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

#获取程序名对应的进程id
get_pids()
{
    local NAME_SET=$1
    local proc
    local pid
    local PID_SET

    for proc in $NAME_SET
    do
        #pidof 会获取同名进程的所有pid
        pid=$(pidof $proc)
        PID_SET+=$pid" "
    done

  echo $PID_SET 
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

    for time in $total_time
    do

        ticks=$[ticks + time]
    done

    echo $ticks
}

#获取指定进程pid集合的总ticks
get_total_process_ticks()
{
  local PID_SET=$1
  local total_time
  local ticks
  local PROC_FILE
  local pid

  for pid in $PID_SET
  do

    PROC_FILE="/proc/"$pid"/stat"

    #utime stime cutime cstime
    total_time=$(cat $PROC_FILE | cut -d " " -f14-17)
  
    for time in $total_time
    do

        ticks=$[ticks + time]
    done

  done

  echo $ticks
}

# *** function end ***
# 测试输入参数
#目标名称
PROCESS_NAME=""
while [ true ]
do
    echo "请输入进程名称 :"
    read PROCESS_NAME
    if [ -z "$PROCESS_NAME" ]; then
        continue
    else
        break
    fi
done
echo $PROCESS_NAME

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

main $PROCESS_NAME $CYCLE $CPU_NUM $average

#get_total_cpu_ticks 0

