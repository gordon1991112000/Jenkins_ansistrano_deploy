#!/bin/sh
# Shell script to monitor or watch the disk space
# It will send an email to $ADMIN, if the (free avilable) percentage
# of space is >= 90%
# -------------------------------------------------------------------------
# Copyright (c) 2005 nixCraft project <http://cyberciti.biz/fb/>
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------
# This script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# ----------------------------------------------------------------------
# Linux shell script to watch disk space (should work on other UNIX oses )
# SEE URL: http://www.cyberciti.biz/tips/shell-script-to-watch-the-disk-space.html
# set admin email so that you can get email
ADMIN="backup@broadlearning.com"
# set alert level 90% is default
ALERT=95
df -Pl  | grep "^/dev" | awk '{print $5, $6}' | sed "s/%//" | while read usep partition;
do
#  echo $usep
#  echo $partition

  if [ $usep -ge $ALERT ]; then
     echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" |
     mail -s "Alert: Almost out of disk space $usep percent in $(hostname) server" $ADMIN
  fi
done

