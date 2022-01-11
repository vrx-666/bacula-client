#!/bin/bash
: ${FD_Password:="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c24)"}
: ${FD_Mon:="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c24)"}
: ${FD_Name:="bacula-fd"}
: ${DIR_Name:=""}
: ${FD_Port:="9102"}

if [ -z ${DIR_Name} ];then
	echo "==> DIR_Host must be set, exiting"
	exit 1
fi

CONFIG_VARS=(
  FD_Password
  FD_Mon
  FD_Name
  DIR_Name
  FD_Port
)

if [ ! -f /opt/bacula/etc/bacula-fd.conf ];then
	echo "==> Creating File daemon config..."
	cp -rp /home/bacula/etc/bacula-fd.conf /opt/bacula/etc/bacula-fd.conf
	cp -rp /home/bacula/working /opt/bacula/
	chown bacula:bacula /opt/bacula/etc/bacula-fd.conf
	chmod g+w /opt/bacula/etc/bacula-fd.conf
fi
cp -rup /home/bacula/scripts /opt/bacula/

for c in ${CONFIG_VARS[@]}; do
  sed -i "s,@${c}@,$(eval echo \$$c)," /opt/bacula/etc/bacula-fd.conf
done

chown -R bacula:bacula /opt/bacula/working
chown bacula:tape /opt/bacula/log

echo "==> Starting..."
echo "==> .......File Daemon..."
/opt/bacula/bin/bacula-fd -c /opt/bacula/etc/bacula-fd.conf -f
