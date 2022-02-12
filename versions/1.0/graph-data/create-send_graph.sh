#!/bin/bash
PC_USER=`whoami`
PREVIOUSDATE=`date +%F`
cd /home/$PC_USER/.scriptmail-dependencies/graph-data
python3 graphmath.py
mv plot.png graph_$PREVIOUSDATE.png
python3 sendemailgraph.py
cat /dev/null > graphdata.txt
sleep 75
NEXTDATE=`date +%F`
sed -i "s,$PREVIOUSDATE,""$NEXTDATE"',' sendemailgraph.py
rm graph_$PREVIOUSDATE.png



