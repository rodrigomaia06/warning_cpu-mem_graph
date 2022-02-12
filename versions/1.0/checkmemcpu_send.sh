#!/bin/bash
#---------PERSONAL VARIABLES
RAM_PERCENTAGE_WARNING="###ram_percentage_warning###"
CPU_PERCENTAGE_WARNING="###cpu_percentage_warning###"
SCRIPT_DIRECTORY="###script_directory###"
TMP_DIRECTORY="/tmp"
DATE=`date +%F`
TIME=`date +"%H:%M"`
#---------SCRIPT - CHECK MEM
USED_MEM=`vmstat -s |sed -n '2p' |cut -d'K' -f1 |sed "s/ //g"`
PC_MEM=`vmstat -s |sed -n '1p' |cut -d'K' -f1 | sed "s/ //g"`
RATIO_MEM=`echo "scale=2; $USED_MEM / $PC_MEM * 100" |bc|cut -d'.' -f1`
#--------SCRIPT - SEND EMAIL MEM       
if [[ "$RATIO_MEM" -ge $RAM_PERCENTAGE_WARNING  && ! -f $TMP_DIRECTORY/nosendmailwarningmem.txt ]]
then
	python3 $SCRIPT_DIRECTORY/sendmailwarningmem.py
	touch $TMP_DIRECTORY/nosendmailwarningmem.txt
fi
#---------SCRIPT - CHECK MEM
CPU_USAGE=$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]
#-------SCRIPT - SEND EMAIL CPU
if [[ "$CPU_USAGE" -ge $CPU_PERCENTAGE_WARNING && ! -f $TMP_FIRECTORY/nosendmailwarningcpu.txt ]]
then
        python3 $SCRIPT_DIRECTORY/sendmailwarningcpu.py
        touch $TMP_DIRECTORY/nosendmailwarningcpu.txt
fi
#-------WRITE DATA TO FILE
cd $SCRIPT_DIRECTORY/graph-data
echo $TIME $CPU_USAGE $RATIO_MEM >> graphdata.txt 
