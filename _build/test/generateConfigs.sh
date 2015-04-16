#!/bin/bash

DBNAME="revo_test"
CWD=`pwd`
BUILDDIR=${TRAVIS_BUILD_DIR:=`echo $(dirname $(dirname "$CWD"))"/"`}

echo "create database"
mysql -e "drop database if exists "$DBNAME
mysql -e "create database "$DBNAME

echo "create properties.inc.php"
sed "s/mysql_string_username']= '';/mysql_string_username']= 'root';/g" properties.sample.inc.php | \
    sed "s/config_key'] = 'test';/config_key'] = 'config';/g" > properties.inc.php

echo "build config"

# improve this

CONFIG=`cat revo_install.sample.xml`
CONFIG="${CONFIG/\{\$dbName\}/$DBNAME}"
CONFIG="${CONFIG/\{\$dbUser\}/root}"
CONFIG="${CONFIG/\{\$dbPass\}/}"
CONFIG="${CONFIG/\{\$host\}/unit.modx.com}"
CONFIG="${CONFIG/\{\$language\}/en}"
CONFIG="${CONFIG/\{\$managerUser\}/admin}"
CONFIG="${CONFIG/\{\$managerPass\}/admin}"
CONFIG="${CONFIG/\{\$managerEmail\}/admin@modx.com}"
CONFIG="${CONFIG/\{\$directory\}/$BUILDDIR}"
CONFIG="${CONFIG/\{\$directory\}/$BUILDDIR}"
CONFIG="${CONFIG/\{\$directory\}/$BUILDDIR}"
CONFIG="${CONFIG/\{\$directory\}/$BUILDDIR}"
CONFIG="${CONFIG/\{\$directory\}/$BUILDDIR}"
CONFIG="${CONFIG/\{\$directory\}/$BUILDDIR}"
CONFIG="${CONFIG/\{\$directory\}/$BUILDDIR}"

CONFIG="${CONFIG/\{\$baseUrl\}//}"
CONFIG="${CONFIG/\{\$baseUrl\}//}"
CONFIG="${CONFIG/\{\$baseUrl\}//}"
CONFIG="${CONFIG/\{\$baseUrl\}//}"
CONFIG="${CONFIG/\{\$baseUrl\}//}"
CONFIG="${CONFIG/\{\$baseUrl\}//}"
CONFIG="${CONFIG/\{\$baseUrl\}//}"

echo $CONFIG > ../../setup/config.xml

echo "make core/cache and change permissions"
mkdir ../../core/cache
chmod 777 -R ../../
chmod 777 -R ../../manager/
chmod 777 -R ../../connectors/

echo $CONFIG

echo "Run MODX setup"
php ../../setup/index.php --installmode=new --config=../../setup/config.xml