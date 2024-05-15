# Install Java
amazon-linux-extras enable java-openjdk11
yum clean metadata
yum install java-11-openjdk -y

update-alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.22.0.7-1.amzn2.0.1.x86_64/bin/java
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.22.0.7-1.amzn2.0.1.x86_64/
export PATH=$JAVA_HOME/bin:$PATH

# Install maven
wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
yum install -y apache-maven
export MAVEN_OPTS="-Xmx1024m -XX:MetaspaceSize=512m"

# Install Apache-Tomcat
cd /opt/
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.88/bin/apache-tomcat-9.0.88.tar.gz -P /opt/
tar -zxvf apache-tomcat-9.0.88.tar.gz --transform 's/apache-tomcat-9.0.88/apache-tomcat/' -C /opt/
rm -rf /opt/apache-tomcat-9.0.88.tar.gz
/opt/apache-tomcat/bin
chmod +x startup.sh && chmod +x shutdown.sh
ln -s /opt/apache-tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/apache-tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown

# Download the EC2Box package
wget https://github.com/bastillion-io/Bastillion-EC2/archive/refs/tags/v0.35.01.tar.gz -P /opt/
tar -xvf v0.35.01.tar.gz
rm -rf v0.35.01.tar.gz && rm -rf /opt/Bastillion-EC2-0.35.01/pom.xml && rm -rf /opt/Bastillion-EC2-0.35.01/src/mai/resources/EC2BoxConfig.properties
mvn package

# Deploy the .war file into apache-tomcat
cp /opt/Bastillion-EC2-0.35.01/target/ec2box-0.35.01.war /opt/apache-tomcat/webapps/ec2box.war
cd /opt/apache-tomcat/bin
