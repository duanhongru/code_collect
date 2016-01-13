# vim inotify_rsync.sh
#!/bin/sh
#date:2013-1-11
#function:rysnc 10.10.10.20  to  10.10.10.21
if [ ! -f /etc/21.pas ];then
        echo "123456">/etc/21.pas
        /bin/chmod 600 /etc/1.pas
fi
log=/usr/local/inotify/logs/rsync.log
src="/home/httpd/20dir/"
host="10.10.10.21"
module="21dir"
 
/usr/local/inotify/bin/inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' -e close_write,modify,delete,create,attrib $src |  while read DATE TIME DIR FILE; do
 
       FILECHANGE=${DIR}${FILE}
 
       /usr/bin/rsync -avH --delete  --progress --password-file=/etc/21.pas $src  --exclude-from="/usr/local/inotify/logs/rules.txt" rsyncuser@$host::$module &
       echo "At ${TIME} on ${DATE}, file $FILECHANGE was backed up via rsync" >> $log
done
