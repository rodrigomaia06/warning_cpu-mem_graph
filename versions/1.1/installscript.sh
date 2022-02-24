#!/bin/bash
#------Developer Variables-----#
VERSION="1.1"
DEPENDENCIESLIST="bc python3 wget pip git"
DEPENDENCIESLISTPY="matplotlib"
#------Needed Varibles and Creating the Script's Directory
PCUSER=`whoami`
TEMPDIR="/home/$PCUSER/tempdir"
SCRIPTDIR="/home/$PCUSER/.scriptmail-dependencies"
GRAPHDIR="$SCRIPTDIR/graph-data"
#------Updating Packages and Installing Dependencies
echo "Updating Packages ......" 
sudo apt update &> /dev/null
echo "Installing Dependencies ......"
for dp in $DEPENDENCIESLIST; do sudo apt install $dp -y &> /dev/null; done
for dppy in $DEPENDENCIESLIST; do sudo apt install $dppy -y &> /dev/null; done
#-----Downloading Scripts from Github
echo "Downloading Needed Files ......"
mkdir $TEMPDIR
git clone -q https://github.com/rodrigomaia06/warning_cpu-mem_graph.git $TEMPDIR
mv $TEMPDIR/versions/$VERSION $SCRIPTDIR
rm -rf $TEMPDIR
find $SCRIPTDIR \( -name "*.py" -o -name "*.sh" \) -exec chmod +x {} \;
#-------Replacing Personal Varibles in Scripts
cd $SCRIPTDIR
find $SCRIPTDIR -name "*.sh" -exec sed -i 's,###script_directory###,'"$SCRIPTDIR"',' {} \;

read -p "Warning Percentage(Memory): " -r
find $SCRIPTDIR \( -name "*.py" -o -name "*.sh" \) -exec sed -i 's,###ram_percentage_warning###,'"$REPLY"',' {} \;

read -p "Warning Percentage(CPU): " -r
find $SCRIPTDIR \( -name "*.py" -o -name "*.sh" \) -exec sed -i 's,###cpu_percentage_warning###,'"$REPLY"',' {} \;

read -p "Sender's Gmail: " -r
find $SCRIPTDIR \( -name "*.py" -o -name "*.sh" \) -exec sed -i 's,###sender_email###,'"$REPLY"',' {} \;

read -p "Sender's Gmail Password: " -r
PASSWORD_BASE64B=$(echo -n $REPLY | base64)
find $SCRIPTDIR \( -name "*.py" -o -name "*.sh" \) -exec sed -i 's,###password_base64###,'"$PASSWORD_BASE64B"',' {} \;

read -p "Recipient Email: " -r
find $SCRIPTDIR \( -name "*.py" -o -name "*.sh" \) -exec sed -i 's,###rec_email###,'"$REPLY"',' {} \;
#--------Adding Cronjob
(crontab -l 2>/dev/null; echo "59 23 * * * /bin/bash $GRAPHDIR/create-send_graph.sh") | crontab -

read -p "Interval to Check Memory and CPU Usage(5,10,15,30): " -r
echo "Updating Crontab ......";(crontab -l 2>/dev/null; echo "*/$REPLY * * * * /bin/bash $SCRIPTDIR/checkmemcpu_send.sh") | crontab -; sleep 1
echo "Setup Complete!"; sleep 1
