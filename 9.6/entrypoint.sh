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

if [ ! -f /etc/bacula/bacula-fd.conf ];then
	echo "==> Creating File daemon config..."
	cp -rp /opt/bacula/bacula-fd.conf /etc/bacula/bacula-fd.conf
	chmod g+w /etc/bacula/bacula-fd.conf
fi
cp -rup /opt/bacula/scripts /etc/bacula/

for c in ${CONFIG_VARS[@]}; do
  sed -i "s,@${c}@,$(eval echo \$$c)," /etc/bacula/bacula-fd.conf
done

chown bacula:tape /var/lib/bacula
chown bacula:tape /var/log/bacula

echo "==> Starting..."
echo "==> .......File Daemon..."
/usr/sbin/bacula-fd -c /etc/bacula/bacula-fd.conf -f
