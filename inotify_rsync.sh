# vim inotify_rsync.sh
#!/bin/sh
#date:2013-1-11
#function:rysnc 10.10.10.20  to  10.10.10.21
if [ ! -f /etc/backserver.pas ];then
        echo "123456">/etc/backserver.pas
        /bin/chmod 600 /etc/backserver.pas
fi
log=/var/log/rsync.log
src="/home/duanhongru/nginx-1.9.6/"
host="61.8.173.158"
module="nginx-1.9.6"
 
/usr/bin/inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' -e close_write,modify,delete,create,attrib $src |  while read DATE TIME DIR FILE; do
 
       FILECHANGE=${DIR}${FILE}
 
       /usr/bin/rsync -avH --delete  --progress --password-file=/home/duanhongru/backserver.pas --exclude="objs" $src  duanhongru@$host::$module &
       echo "At ${TIME} on ${DATE}, file $FILECHANGE was backed up via rsync" >> $log
done

