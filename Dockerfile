FROM ubuntu:18.04

ARG SVN_REPO_NAME=source
ARG SVN_ROOT=/opt/svn
ARG REPO_PATH=${SVN_ROOT}/${SVN_REPO_NAME}
ARG SVN_ADMIN_USR=svnadm
ARG SVN_ADMIN_PWD=p@ssw0rd


RUN apt-get update && \
    apt-get install -y subversion apache2 apache2-utils libapache2-mod-svn libsvn-dev && \
    a2enmod dav && \
    a2enmod dav_svn && \
    a2enmod authz_svn && \
    a2dissite 000-default && \
    htpasswd -b -c /etc/apache2/dav_svn.passwd ${SVN_ADMIN_USR} ${SVN_ADMIN_PWD} && \
    mkdir -p ${SVN_ROOT} && \
    svnadmin create ${REPO_PATH} && \
    chown -R www-data:www-data ${REPO_PATH} && \
    chmod -R 775 ${REPO_PATH} && \
    apt clean

COPY dav_svn.conf /etc/apache2/sites-enabled/
COPY dav_svn.authz /etc/apache2/
COPY startup.sh /
RUN chmod +x /startup.sh


EXPOSE 80


CMD ["apachectl", "-D", "FOREGROUND"]
# CMD ["/startup.sh"]
# ENTRYPOINT ["/startup.sh"]

	


