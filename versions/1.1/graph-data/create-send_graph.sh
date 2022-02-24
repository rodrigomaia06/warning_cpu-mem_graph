#!/bin/bash
GRAPHDIR="###script_directory###/graph-data"
DATE=`date +%F`
cd $GRAPHDIR
#-----Creating graph and sending email
python3 graphmath.py $DATE
python3 sendemailgraph.py $DATE
#-----Removing file from previous day
rm graphdata.txt
rm graph_$DATE.png
