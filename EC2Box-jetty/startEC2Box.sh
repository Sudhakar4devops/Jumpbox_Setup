#!/bin/bash
. /opt/EC2Box-jetty/jetty/etc/pki/cert_vars

cd jetty;

java -Xms2048m -Xmx6144m -jar start.jar -Djetty.sslContext.keyStorePath=etc/pki/keystore -Djetty.sslContext.keyStorePassword=$KEYSTORE_PASSWORD -Djetty.sslContext.keyManagerPassword=$KEYSTORE_PASSWORD -Djetty.sslContext.trustStorePath=etc/pki/keystore -Djetty.sslContext.trustStorePassword=$KEYSTORE_PASSWORD
