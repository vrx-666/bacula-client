FROM debian:bullseye-slim

LABEL maintainer="developer@s.vrx.pl"
LABEL version="1.0"
LABEL description="Bacula Client 9.6"

ARG DEBIAN_FRONTEND=noninteractive

RUN echo "path-exclude /usr/share/doc/*" > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-include /usr/share/doc/*/copyright" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/man/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/groff/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/info/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/lintian/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/linda/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc&& \
    apt update && apt -y upgrade && apt install -y --no-install-recommends bacula-fd && \
    apt autoremove -y && \
    rm -rf /var/cache/apt/* && \
    apt clean && \
    mv /etc/bacula /opt/ && \
    mkdir -p /opt/lib && \
    mkdir /run/bacula 

COPY 9.6/bacula-fd.conf /opt/bacula/bacula-fd.conf
COPY 9.6/entrypoint.sh /usr/sbin/entrypoint.sh

RUN chgrp bacula /opt/bacula/bacula-fd.conf 
    
VOLUME ["/etc/bacula", "/var/lib/bacula", "/var/log/bacula"]

EXPOSE 9102/tcp

ENTRYPOINT ["entrypoint.sh"]
