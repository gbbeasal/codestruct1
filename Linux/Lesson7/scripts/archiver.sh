#!/bin/bash

function logging() {
    inf=$1
    stp=$2
    ts=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$ts] $inf - $stp"
}

echo "=================================================================================="
logging INFO "Begin archiving log files ..."
echo "----------------------------------------------------------------------------------"
echo "=================================================================================="
sleep 1

#Directory Creation and Existince Check
logging INFO "Creating log_files directory ..."
echo "----------------------------------------------------------------------------------"
[ -d /home/$USER/log_files ] || mkdir -v /home/$USER/log_files
sleep 1

echo "=================================================================================="
logging INFO "Collecting log files from /var/log ..."
echo "----------------------------------------------------------------------------------"
sudo cp -vR /var/log log_files
sleep 1

echo "=================================================================================="
logging INFO "Updating permissions for global reading ..."
echo "----------------------------------------------------------------------------------"
sudo find log_files -type f | xargs sudo chmod -v a+r #find files
sudo find log_files -type d | xargs sudo chmod -v a+rx #find directories
sleep 1

echo "=================================================================================="
logging INFO "Calculating line count summary ..."
echo "----------------------------------------------------------------------------------"
echo "=================================================================================="
logging INFO "Calculating file size summary ..."
echo "----------------------------------------------------------------------------------"
touch /home/$USER/log_files/log_summary.txt

printf "======================
LOG SUMMARY
----------------------
======================
Line Count Summary
----------------------
" > /home/$USER/log_files/log_summary.txt
sudo find /home/$USER/log_files/log -type f | xargs wc -l >> /home/$USER/log_files/log_summary.txt
sleep 1
printf "======================
File Size Summary
----------------------
" >> /home/$USER/log_files/log_summary.txt
sudo find /home/$USER/log_files/log -type f | xargs wc -c >> /home/$USER/log_files/log_summary.txt
sleep 1

echo "=================================================================================="
logging INFO "Compressing log archive to /opt/log_files-$(date +%Y%m%d%H%M).zip ..."
echo "----------------------------------------------------------------------------------"
cd /opt
sudo zip -r log_files-$(date +%Y%m%d%H%M).zip /home/$USER/log_files
sleep 1

echo "=================================================================================="
logging INFO "Done."