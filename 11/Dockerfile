FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="developer@s.vrx.pl"
LABEL version="2.0"
LABEL description="Bacula Client 11"

COPY bacula_src/bacula_src /opt/bacula_src
COPY 11/bacula-fd.conf /home/bacula-fd.conf
COPY 11/entrypoint.sh /usr/sbin/entrypoint.sh

RUN echo "path-exclude /usr/share/doc/*" > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-include /usr/share/doc/*/copyright" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/man/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/groff/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/info/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/lintian/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/linda/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc&& \
    apt update && apt -y upgrade && apt install -y --no-install-recommends g++ make && \
    cd /opt/bacula_src && CFLAGS="-g -O2"    ./configure --sbindir=/opt/bacula/bin --sysconfdir=/opt/bacula/etc --with-pid-dir=/opt/bacula/working --with-subsys-dir=/opt/bacula/working --enable-smartalloc --enable-client-only --with-working-dir=/opt/bacula/working --disable-ipv6 && \
    make && \
    make install && \
    apt --purge remove -y g++ make && \
    apt autoremove -y && \
    rm -rf /var/cache/apt/* && \
    apt clean && \
    mkdir /home/bacula && \
    mv /opt/bacula/etc /home/bacula/ && \
    mv /opt/bacula/working /home/bacula/ && \
    mv /home/bacula-fd.conf /home/bacula/etc/bacula-fd.conf && \
    rm -rf /opt/bacula_src
    
VOLUME ["/opt/bacula/etc", "/opt/bacula/working", "/opt/bacula/log" ]

EXPOSE 9102/tcp

ENTRYPOINT ["entrypoint.sh"]
