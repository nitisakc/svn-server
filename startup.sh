#!/bin/sh
mkdir -p /opt/svn
svnadmin create /opt/svn/source
chown -R www-data:www-data /opt/svn/source
chmod -R 775 /opt/svn/source