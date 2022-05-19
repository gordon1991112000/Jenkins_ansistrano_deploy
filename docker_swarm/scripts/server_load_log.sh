# Server load log creation script v.4 (20140425)
# Please save the script in /root/scripts/server_load_log.sh
# edit /etc/crontab, add the line
# * * * * * root /root/scripts/server_load_log.sh >> /var/log/server_load.log
# run command `/etc/init.d/crond reload`


no_httpd=`ps aux|grep httpd |wc -l`
no_httpd=`expr $no_httpd - 1`

SwapFree=`grep SwapFree /proc/meminfo | awk '{print $2}'`
SwapTotal=`grep SwapTotal /proc/meminfo | awk '{print $2}'`
SwapUsed=`expr $SwapTotal - $SwapFree`

echo -n `date +%F` ; w |grep "load average"
echo `date '+%F %R:%S'` "no_of_httpd" $no_httpd;
echo -n `date '+%F %R:%S'` "port 80 connection EST ";netstat -n |grep EST |grep ':80'|wc -l
echo `date '+%F %R:%S'` "SwapTotal "$SwapTotal "SwapFree "$SwapFree "SwapUsed "$SwapUsed
echo -n `date '+%F %R:%S'` "%iowait "; /usr/bin/iostat -c |grep avg-cpu -A1 | tail -n 1 |awk '{print $4}'
echo -n `date '+%F %R:%S'` "mpstat ";/usr/bin/mpstat |grep CPU
echo -n `date '+%F %R:%S'` "mpstat ";/usr/bin/mpstat |grep all
