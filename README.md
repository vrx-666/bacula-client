# Bacula Client
Two version available: Bacula 9.6 or Bacula 11 <br>

# How to build
Pull this repository and run "build.sh"
```
./build.sh
```

# ENV
```
TZ - timezone
FD_Password - authentication password for Director (Bacula Server), 
              You can set it or will be generated automaticly, 
              after that You can check bacula-fd.conf or docker inspect
FD_Name - optional name	of backuped host, could be omitted because Bacula Server is using it's own names directives for clients.
DIR_Name - Bacula Director Name, needed for authenticating Director on Clients
FD_Port - (optionally) by default 9102
```
# Ports
```
9102 - Default Bacula FD Port
```
Could be changed at first run by FD_port variable<br>
# Mounts
version 11:
```
/opt/bacula/etc - bacula configuration files
/opt/bacula/working - bacula working directory (sqlite db, bacula db dump for backups)
/opt/bacula/log - bacula logs
```

version 9.6:
```
/etc/bacula - bacula configuration
/var/lib/bacula - bacula working directory
/var/log/bacula - bacula logs
```

commons:<br>
You can bind any directory from host to docker's /mnt and configure /mnt/directory as Include Directory in Bacula Server config.


# Exaple run command
```
docker run -d --name='Bacula Client' \
-e TZ="America/Los_Angeles" \
-e 'DIR_Name=bacula-dir' \
-e 'FD_Password=some_difficult_password' \
-p '9102:9102' \
-v '/:/mnt/root' \
-v '/mnt/docker/bacula-server/working':'/var/lib/bacula' \
-v '/mnt/docker/bacula-server/etc':'/etc/bacula' \
-v '/mnt/docker/bacula-server/log/bacula':'/var/log/bacula' \
pwa666/bacula-client:9.6-latest
```
