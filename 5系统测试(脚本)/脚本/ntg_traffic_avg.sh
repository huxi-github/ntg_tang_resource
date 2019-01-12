#!/bin/bash

# 系统监控,记录cpu、memory、load average,当超过规定数值时发电邮通知管理员

# *** config start ***

#刷新周期
CYCLE=1
#网卡配置

INTERFACE=eth0

# 当前目录路径
ROOT=$(cd "$(dirname "$0")"; pwd)

# 当前服务器名
HOST=$(hostname)

# log 文件路径
CPU_LOG="${ROOT}/logs/cpu.log"
MEM_LOG="${ROOT}/logs/mem.log"

LOAD_LOG1="${ROOT}/logs/load1.log"
LOAD_LOG2="${ROOT}/logs/load2.log"
LOAD_LOG3="${ROOT}/logs/load3.log"

IO_LOG1="${ROOT}/logs/io1.log"
IO_LOG2="${ROOT}/logs/io2.log"


# 通知电邮列表
NOTICE_EMAIL='admin@admin.com'

# cpu,memory,load average 记录上一次发送通知电邮时间
CPU_REMARK='/tmp/servermonitor_cpu.remark'
MEM_REMARK='/tmp/servermonitor_mem.remark'
LOAD_REMARK='/tmp/servermonitor_loadaverage.remark'
IO_REMAK='/tmp/servermonitor_io.remark'

# 发通知电邮间隔时间
REMARK_EXPIRE=3600
NOW=$(date +%s)

# *** config end ***


# *** function start ***

#测试函数

# 获取CPU占用
function GetCpu() {
#    cpufree=$(vmstat 1 1 |sed -n '3,$p' |awk '{x = x + $15} END {print x/5}' |awk -F. '{print $1}')
    cpufree=$(top -b -n 1 | grep Cpu | awk '{print $8}')

    cpuused=$(echo "scale=2; 100 - $cpufree" | bc | awk '{printf "%.2f", $0}' )

    echo "${cpuused}"

 #   local remark
 #   remark=$(GetRemark ${CPU_REMARK})

    # 检查CPU占用是否超过90%
 #   if [ "$remark" = "" ] && [ "$cpuused" -gt 90 ]; then
 #       echo "Subject: ${HOST} CPU uses more than 90% $(date +%Y-%m-%d' '%H:%M:%S)" | sendmail ${NOTICE_EMAIL}
 #       echo "$(date +%s)" > "$CPU_REMARK"
 #   fi
}

# 获取内存使用情况
function GetMem() {
    mem=$(free -m | sed -n '3,3p')
    used=$(echo $mem | awk -F ' ' '{print $3}')
    free=$(echo $mem | awk -F ' ' '{print $4}')
    total=$(($used + $free))
    limit=$(($total/10))
#    echo "${total} ${used} ${free}"
    echo "${used}"
 #   local remark
 #   remark=$(GetRemark ${MEM_REMARK})

    # 检查内存占用是否超过90%
#   if [ "$remark" = "" ] && [ "$limit" -gt "$free" ]; then
#        echo "Subject: ${HOST} Memory uses more than 90% $(date +%Y-%m-%d' '%H:%M:%S)" | sendmail ${NOTICE_EMAIL}
#        echo "$(date +%s)" > "$MEM_REMARK"
#    fi
}

# 获取load average
function GetLoad() {
    load=$(uptime | awk -F 'load average: ' '{print $2}')
    m1=$(echo $load | awk -F ', ' '{print $1}')
    m5=$(echo $load | awk -F ', ' '{print $2}')
    m15=$(echo $load | awk -F ', ' '{print $3}')
    echo "${m1} ${m5} ${m15}"

 #   m1u=$(echo $m1 | awk -F '.' '{print $1}')

 #   local remark
 #   remark=$(GetRemark ${LOAD_REMARK})

    # 检查是否负载是否有压力
#    if [ "$remark" = "" ] && [ "$m1u" -gt "2" ]; then
#        echo "Subject: ${HOST} Load Average more than 2 $(date +%Y-%m-%d' '%H:%M:%S)" | sendmail ${NOTICE_EMAIL}
#        echo "$(date +%s)" > "$LOAD_REMARK"
#    fi
}

function GetIO() {
    io_rx_pre=$(cat /proc/net/dev | grep $INTERFACE | tr : " " | awk '{print $2}') # translate 将 ":"替换为" "
    io_tx_pre=$(cat /proc/net/dev | grep $INTERFACE | tr : " " | awk '{print $10}')

    sleep $CYCLE

    io_rx_next=$(cat /proc/net/dev | grep $INTERFACE | tr : " " | awk '{print $2}')
    io_tx_next=$(cat /proc/net/dev | grep $INTERFACE | tr : " " | awk '{print $10}')

    RX=$((io_rx_next - io_rx_pre))
    TX=$((io_tx_next - io_tx_pre))

    echo "${RX} ${TX}"
}

function getIO(){

    io_rx=$(cat /proc/net/dev | grep $INTERFACE | tr : " " | awk '{print $2}') #等号右边是一段linux 命令
    io_tx=$(cat /proc/net/dev | grep $INTERFACE | tr : " " | awk '{print $10}')
    
    echo "${io_rx} ${io_tx}"
}

# 获取上一次发送电邮时间
function GetRemark() {
    local remark

    if [ -f "$1" ] && [ -s "$1" ]; then
        remark=$(cat $1)

        if [ $(( $NOW - $remark )) -gt "$REMARK_EXPIRE" ]; then
            rm -f $1
            remark=""
        fi
    else
        remark=""
    fi

    echo $remark
}


get_average(){
    local count=$1
    local cpuAvg=$2
    local cpuUsage=$3
    local ret
    ret=$(echo "scale=2; a=($cpuAvg*($count-1)+$cpuUsage)/$count; if (length(a)==scale(a)) print 0;print a " | bc | awk '{printf "%.2f", $0}')
    
    echo $ret
}

# *** function end ***

# 测试输入参数

while [ true ]
do
    echo "Please enter the network card name(such as eth0) :"
    read INTERFACE
    if [ -z "$INTERFACE" ]; then
        continue
    else
        break
    fi
done
       

while [ true ]
do
    echo "Please enter refresh cycle(such as 5) :"
    read CYCLE
    if [ -z "$CYCLE" ]; then
        continue
    else
        break
    fi
done 


#清空原有文件内容


count=0
io1=0
io2=0
io=0
avg=0
while [ true ]
do

    count=$((count + 1))

    #cpuinfo=$(GetCpu)
    #meminfo=$(GetMem)
    #loadinfo=$(GetLoad)
    ioinfo=$(GetIO)

    io1=$(echo "${ioinfo}" | awk {'print $1'})
    io2=$(echo "${ioinfo}" | awk {'print $2'})

    io=$(($io1 + $io2))
    

    avg=$(get_average $count $avg $io)
    

    echo "$io $avg---->$count"



    #echo "${cpuinfo}" >> "${CPU_LOG}"
    #echo "${meminfo}" >> "${MEM_LOG}"


    #echo "${ioinfo}" | awk {'print $1'}>> "${IO_LOG1}"
    #echo "${ioinfo}" | awk {'print $2'}>> "${IO_LOG2}"

    #echo "${loadinfo}" | awk {'print $1'}  >> "${LOAD_LOG1}"
    #echo "${loadinfo}" | awk {'print $2'}  >> "${LOAD_LOG2}"
    #echo "${loadinfo}" | awk {'print $3'}  >> "${LOAD_LOG3}"
done
exit 0
