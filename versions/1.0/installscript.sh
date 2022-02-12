#!/bin/bash
#------Updating Packages and Installing Dependencies
echo "Updating Packages ......"; sudo apt update &> /dev/null ;
wget -q https://raw.githubusercontent.com/VladimirBromley0750/warning_cpu-mem_graph/main/versions/1.0/dependencies.sh; chmod +x dependencies.sh;  bash dependencies.sh &> /dev/null
echo "Installing Dependencies ......";
#------Setting Needed Varibles and Creating the Script's Directory
PCUSER=`whoami`
SCRIPTDIR="/home/$PCUSER/.scriptmail-dependencies"
GRAPHDIR="$SCRIPTDIR/graph-data"
DATE=`date +%F`
mkdir $SCRIPTDIR
cd $SCRIPTDIR
mkdir graph-data/
#-----Downloading Scripts from Github
wget -q https://raw.githubusercontent.com/VladimirBromley0750/warning_cpu-mem_graph/main/versions/1.0/checkmemcpu_send.sh; chmod +x checkmemcpu_send.sh
wget -q https://raw.githubusercontent.com/VladimirBromley0750/warning_cpu-mem_graph/main/versions/1.0/sendmailwarningcpu.py; chmod +x sendmailwarningcpu.py
wget -q https://raw.githubusercontent.com/VladimirBromley0750/warning_cpu-mem_graph/main/versions/1.0/sendmailwarningmem.py; chmod +x sendmailwarningmem.py
cd graph-data/
wget -q https://raw.githubusercontent.com/VladimirBromley0750/warning_cpu-mem_graph/main/versions/1.0/graph-data/create-send_graph.sh; chmod +x create-send_graph.sh
wget -q https://raw.githubusercontent.com/VladimirBromley0750/warning_cpu-mem_graph/main/versions/1.0/graph-data/graphmath.py; chmod +x graphmath.py
echo "Downloading Needed Files ......"; wget -q https://raw.githubusercontent.com/VladimirBromley0750/warning_cpu-mem_graph/main/versions/1.0/graph-data/sendemailgraph.py; chmod +x sendemailgraph.py; cd $SCRIPTDIR
#-------Replacing Personal Varibles in Scripts
sed -i 's,###script_directory###,'"$SCRIPTDIR"',' checkmemcpu_send.sh
sed -i 's,###date_installation###,'"$DATE"',' $GRAPHDIR/sendemailgraph.py

read -p "Warning Percentage(Memory): " -r
sed -i 's,###ram_percentage_warning###,'"$REPLY"',' checkmemcpu_send.sh
sed -i 's,###ram_percentage_warning###,'"$REPLY"',' sendmailwarningmem.py

read -p "Warning Percentage(CPU): " -r
sed -i 's,###cpu_percentage_warning###,'"$REPLY"',' checkmemcpu_send.sh
sed -i 's,###cpu_percentage_warning###,'"$REPLY"',' sendmailwarningcpu.py

read -p "Sender's Gmail: " -r
sed -i 's,###sender_email###,'"$REPLY"',' sendmailwarningmem.py
sed -i 's,###sender_email###,'"$REPLY"',' sendmailwarningcpu.py
sed -i 's,###sender_email###,'"$REPLY"',' $GRAPHDIR/sendemailgraph.py

read -p "Sender's Gmail Password: " -r
PASSWORD_BASE64B=$(echo -n $REPLY | base64)
sed -i 's,###password_base64###,'"$PASSWORD_BASE64B"',' sendmailwarningmem.py
sed -i 's,###password_base64###,'"$PASSWORD_BASE64B"',' sendmailwarningcpu.py
sed -i 's,###password_base64###,'"$PASSWORD_BASE64B"',' $GRAPHDIR/sendemailgraph.py

read -p "Recipient Email: " -r
sed -i 's,###rec_email###,'"$REPLY"',' sendmailwarningmem.py
sed -i 's,###rec_email###,'"$REPLY"',' sendmailwarningcpu.py
sed -i 's,###rec_email###,'"$REPLY"',' $GRAPHDIR/sendemailgraph.py
#--------Adding Cronjob
(crontab -l 2>/dev/null; echo "59 23 * * * /bin/bash $GRAPHDIR/create-send_graph.sh") | crontab -

read -p "Interval to Check Memory(5,10,15,30): " -r
echo "Updating Crontab ......";(crontab -l 2>/dev/null; echo "*/$REPLY * * * * /bin/bash $SCRIPTDIR/checkmemcpu_send.sh") | crontab -; sleep 1
echo "Setup Complete!"; sleep 1
