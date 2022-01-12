FROM ubuntu:18.04

ARG SVN_ROOT=/opt/svn
ARG SVN_ADMIN_USR=svnadm
ARG SVN_ADMIN_PWD=p@ssw0rd


RUN apt-get update && \
    apt-get install -y subversion apache2 apache2-utils libapache2-mod-svn libsvn-dev && \
    a2enmod dav && \
    a2enmod dav_svn && \
    a2enmod authz_svn && \
    a2dissite 000-default && \
    htpasswd -b -c /etc/apache2/dav_svn.passwd ${SVN_ADMIN_USR} ${SVN_ADMIN_PWD} && \
    mkdir -p /opt/svn && \
    mkdir -p /opt/conf && \
    mkdir -p /opt/backup && \
    apt clean

COPY dav_svn.conf /etc/apache2/sites-enabled/
COPY dav_svn.authz /etc/apache2/
# COPY startup.sh /
# RUN chmod +x /startup.sh

COPY addrepo adduser getconfig reconfig /usr/local/bin/
RUN chmod +x /usr/local/bin/addrepo /usr/local/bin/adduser /usr/local/bin/getconfig /usr/local/bin/reconfig


EXPOSE 80


CMD ["apachectl", "-D", "FOREGROUND"]
# CMD ["/startup.sh"]
# ENTRYPOINT ["/startup.sh"]

	


