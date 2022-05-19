backuppath=/home/serverBackup
backupscriptpath=/root/scripts/backup_mysql.sh

###################################
if [ ! -d $backuppath ]
then
echo "Backup destination path not exist!";exit;
fi

if [ ! -f $backupscriptpath ]
then
echo "Backup script not exist!";exit;
fi

service httpd reload

# Protect wrong deleteion of root or system folder
if [ ${#backuppath} -gt 6 ]
then
$backupscriptpath %
find $backuppath -name "Backup_MySQL_*" -mtime +3 -exec rm -rf {} \;
fi

