#!/bin/bash
PC_USER=`whoami`
DATE=`date +%F`
cd /home/$PC_USER/.scriptmail-dependencies/graph-data
python3 graphmath.py
mv plot.png graph_$DATE.png
python3 sendemailgraph.py $DATE
cat /dev/null > graphdata.txt
rm graph_$PREVIOUSDATE.png
