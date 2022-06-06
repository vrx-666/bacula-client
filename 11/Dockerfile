FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="developer@s.vrx.pl"
LABEL version="1.0"
LABEL description="Bacula Client 11"

COPY Bacula.asc /root/Bacula.asc
RUN echo "path-exclude /usr/share/doc/*" > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-include /usr/share/doc/*/copyright" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/man/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/groff/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/info/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/lintian/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/linda/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc&& \
    apt update && apt install -y gnupg2 curl && \
    echo "deb http://www.bacula.org/packages/614321e9d6b75/debs/11.0.5/buster/amd64 buster main" > /etc/apt/sources.list.d/bacula.list && \
    cat /root/Bacula.asc | apt-key add - && \
    apt update && apt -y upgrade && apt install -y --no-install-recommends bacula-client && \
    apt --purge remove -y curl gnupg2 && \
    apt autoremove -y && \
    rm -rf /var/cache/apt/* && \
    apt clean && \
    mkdir /home/bacula && \
    mv /opt/bacula/scripts /home/bacula/ && \
    mv /opt/bacula/etc /home/bacula/ && \
    mv /opt/bacula/working /home/bacula/

COPY 11/bacula-fd.conf /home/bacula/etc/bacula-fd.conf
COPY 11/entrypoint.sh /usr/sbin/entrypoint.sh

RUN chgrp bacula /home/bacula/etc/bacula-fd.conf 
    
VOLUME ["/opt/bacula/etc", "/opt/bacula/working", "/opt/bacula/log" ]

EXPOSE 9102/tcp

ENTRYPOINT ["entrypoint.sh"]
