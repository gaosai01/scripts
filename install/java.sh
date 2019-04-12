#!/bin/bash
# hint: this script will install jdk8.0_201 and maven3.6

function installJdk() {
    rm -rf jdk1.8.0_201
    rm -f jdk-8u201-linux-x64.tar.gz
    wget https://github.com/gaosai01/scripts/raw/master/install/java/jdk-8u201-linux-x64.tar.gz
    tar -zxf jdk-8u201-linux-x64.tar.gz
    mv -f jdk1.8.0_201 /usr/local/jdk1.8.0_201
    rm -f jdk-8u201-linux-x64.tar.gz
    echo "export JAVA_HOME=/usr/local/jdk1.8.0_201" >> ~/.bash_profile
    echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bash_profile
    echo "export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> ~/.bash_profile
}

function installMaven() {
    rm -rf apache-maven-3.6.0
    rm -f apache-maven-3.6.0-bin.tar.gz
    wget https://github.com/gaosai01/scripts/raw/master/install/java/apache-maven-3.6.0-bin.tar.gz
    tar -zxf apache-maven-3.6.0-bin.tar.gz
    mv -f apache-maven-3.6.0 /usr/local/apache-maven-3.6.0
    rm -f apache-maven-3.6.0-bin.tar.gz
    echo "export MAVEN_HOME=/usr/local/apache-maven-3.6.0" >> ~/.bash_profile
    echo "export PATH=\$MAVEN_HOME/bin:\$PATH" >> ~/.bash_profile
}

# install jdk
java_version=`java -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3 }'|awk -F '.' '{print $2}'`
if [ "$java_version" != "8" ];then
    installJdk
    echo 'jdk1.8 install successfully'
else
    echo 'jdk1.8 exists'    
fi

# install maven
maven_line=`which mvn | wc -l`
if [ $maven_line == 0 ];then
    installMaven
    echo 'mvn3.6 install successfully'
else 
    echo 'mvn3.6 exists'
fi

source ~/.bash_profile
# Maven Aliyun Mirror
mdkir ~/.m2
mv ~/.m2/settings.xml ~/.m2/settings.xml.default
curl -s -S -L https://raw.githubusercontent.com/gaosai01/scripts/master/install/java/settings.xml > ~/.m2/settings.xml
echo 'set aliyun mirror'

