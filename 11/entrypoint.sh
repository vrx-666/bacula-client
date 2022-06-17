#!/bin/bash
: ${FD_Password:="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c24)"}
: ${FD_Mon:="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c24)"}
: ${FD_Name:="bacula-fd"}
: ${DIR_Name:=""}
: ${FD_Port:="9102"}

if [ -z ${DIR_Name} ];then
	echo "==> DIR_Name must be set, exiting"
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
fi

for c in ${CONFIG_VARS[@]}; do
  sed -i "s,@${c}@,$(eval echo \$$c)," /opt/bacula/etc/bacula-fd.conf
done

ln -sf /usr/lib /opt/bacula/plugins

echo "==> Starting..."
echo "==> .......File Daemon..."
/opt/bacula/bin/bacula-fd -c /opt/bacula/etc/bacula-fd.conf -f
