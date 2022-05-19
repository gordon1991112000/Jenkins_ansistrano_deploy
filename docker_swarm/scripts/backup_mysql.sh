# Backup databases by using mysql dump
# v.4
# Tony Chan (20130514-1706)
# sh ./backup_mysql.sh dbprefix

[[ -n "$1" ]] || {
echo "MySQL DB Backup Script. V0.6";
echo "Usage: $0 [dbprefix_]"; exit ; }


#dbprefix='dbprefix_'
dbprefix=$1
intranet_user=root
intranet_passwd=uU4ZGdPBq9
backuppath=/home/serverBackup
logfile=/var/log/mysql_backup.log
errorlogfile=/var/log/mysql_backup_error.log
fileprefix=Backup_MySQL_$dbprefix
compressfolder=yes

# Added email alert function
alertemailto=backup@broadlearning.com

#####################################################################
#DON'T TOUCH BELOW THIS LINE
#####################################################################
if [ ! -d $backuppath ]
then
mkdir -p $backuppath
chmod 700 $backuppath
fi

touch $logfile
chmod 600 $logfile
timestamp=`date +%Y%m%d-%H%M%S`

touch $errorlogfile
chmod 600 $errorlogfile

fullbackuppath=$backuppath/$fileprefix$timestamp.sql
mkdir $fullbackuppath
chmod 700  $fullbackuppath

dblist=$(mysql -u$intranet_user -p$intranet_passwd -Bse "show databases like '$dbprefix%'")

if [ "$dblist" = "" ]
then
logtime=`date +%d/%m/%Y:%H:%M:%S`
echo "$logtime No Database Selected!" >> $logfile
exit 1
fi


# create restore_db.sh for easier db restoration, it includes db create, and import data

echo "#Please replace the db prefix as you want in nano or vi first" > "$fullbackuppath/clone_db.sh"
echo "#Importnat: Please replace the db prefix in clone_new_db.sql too!" >> "$fullbackuppath/clone_db.sh"
echo "#Please replace the db prefix as you want in nano or vi first" > "$fullbackuppath/clone_new_db.sql"

chmod 600 "$fullbackuppath/clone_new_db.sql"

echo "mysql -uroot -pdbpassword < create_db.sql" > "$fullbackuppath/restore_db.sh"
echo "mysql -uroot -pdbpassword < clone_new_db.sql" >> "$fullbackuppath/clone_db.sh"

chmod 700 $fullbackuppath/restore_db.sh
chmod 700 $fullbackuppath/clone_db.sh
errorsignal=0

        for db in $dblist
        do
		if [ "$db" = "information_schema" ]
		then
		continue
		fi

                mysqldump -u$intranet_user -p$intranet_passwd --complete-insert --extended-insert=FALSE --single-transaction --quick --lock-tables=false --opt $db > "$fullbackuppath/$db.sql" 2>> $errorlogfile
                # complete "INSERT"
                # mysqldump -u$intranet_user -p$intranet_passwd --complete-insert --extended-insert=FALSE --single-transaction --lock-tables=false  $db > "$fullbackuppath/$db.sql"
                mysqldumpstatus=$?


                tail  "$fullbackuppath/$db.sql" -n1 |grep "Dump completed" > /dev/null
                mysqltailstatus=$?                 

                chmod 600 "$fullbackuppath/$db.sql"

                if [ $mysqldumpstatus == 0 ] && [ $mysqltailstatus == 0 ]
                then
                        logtime=`date +%d/%m/%Y:%H:%M:%S`
                        echo "$logtime Database Backup: $db [OK] $fullbackuppath/$db.sql" >> $logfile
                        
                        #create database sql
                        echo "CREATE DATABASE $db ;" >> "$fullbackuppath/create_db.sql"
                        echo "CREATE DATABASE newprefix_$db ;" >> "$fullbackuppath/clone_new_db.sql"

                        chmod 600 "$fullbackuppath/create_db.sql"
                        echo "mysql -uroot -pdbpassword $db < $db.sql" >> "$fullbackuppath/restore_db.sh"
                        echo "mysql -uroot -pdbpassword newprefix_$db < $db.sql" >> "$fullbackuppath/clone_db.sh"

#                        let "errorsignal = $errorsignal + 1" # testing purpose, can comment after test

                else
                        logtime=`date +%d/%m/%Y:%H:%M:%S`
                        echo "$logtime Database Backup: $db [FAIL] $fullbackuppath/$db.sql" >> $logfile
                        echo "$logtime Database Backup: $db [FAIL] $fullbackuppath/$db.sql" >> $errorlogfile
                        let "errorsignal = $errorsignal + 1"

                fi
        done

# Email alert for mysql backup
dbhost=`hostname`
if [ $errorsignal -gt 0 ]
then
#echo `hostname`": Mysql backup fail at" `date`" by "$0 | mail -s "MySQL Backup Error from $dbhost" $alertemailto  &> /dev/null
echo `hostname`": Mysql backup fail at" `date`" by "$0 | mail -s "MySQL Backup Error from $dbhost for db prefix $dbprefix" $alertemailto  
fi

#gzip the folder if need

if [ "$compressfolder" = "yes" ]
then
#echo "Compress copy created!"
tar czf $fullbackuppath.tar.gz $fullbackuppath 2> /dev/null
tarstatus=$?
  if [ $tarstatus == 0 ]
  then
  logtime=`date +%d/%m/%Y:%H:%M:%S`
  echo "$logtime Mysql backup .tar.gz creation success [OK]" >> $logfile
  
  needle='.sql'
  
  if [[ "$fullbackuppath" == *"$needle"* ]]; then
#  echo "'$fullbackuppath' contains needle '$needle'"
  rm $fullbackuppath -rf
  fi
  
  else
  echo `hostname`": Mysql backup .tar.gz creation fail at" `date`" by "$0 | mail -s "Mysql backup .tar.gz creation fail from $dbhost for db prefix $dbprefix" $alertemailto
  fi

fi

