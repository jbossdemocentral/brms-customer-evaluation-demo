#!/bin/sh 
DEMO="Customer Evaluation Demo"
AUTHORS="Eric D. Schabell"
PROJECT="git@github.com:eschabell/brms-customer-evaluation-demo.git"
JBOSS_HOME=./target/jboss-eap-6.1
SERVER_DIR=$JBOSS_HOME/standalone/deployments/
SERVER_CONF=$JBOSS_HOME/standalone/configuration/
SRC_DIR=./installs
PRJ_DIR=./projects/brms-customer-evaluation-demo
EAP=jboss-eap-6.1.0.zip
BRMS=jboss-bpms-6.0.0-redhat-3-deployable.zip
VERSION=6.0.0.Beta
#MAVENIZE_VERSION=5.3.1.BRMS

# wipe screen.
clear 

##
# Installation mavanization functions.
##
#installPom() {
#		mvn -q install:install-file -Dfile=../support/$2-$MAVENIZE_VERSION.pom.xml -DgroupId=$1 -DartifactId=$2 -Dversion=$MAVENIZE_VERSION -Dpackaging=pom;
#}
#
#	installBinary() {
#			unzip -q $2-$MAVENIZE_VERSION.jar META-INF/maven/$1/$2/pom.xml;
#			mvn -q install:install-file -DpomFile=./META-INF/maven/$1/$2/pom.xml -Dfile=$2-$MAVENIZE_VERSION.jar -DgroupId=$1 -DartifactId=$2 -Dversion=$MAVENIZE_VERSION -Dpackaging=jar;
#}

echo
echo "#################################################################"
echo "##                                                             ##"   
echo "##  Setting up the ${DEMO}                    ##"
echo "##                                                             ##"   
echo "##                                                             ##"   
echo "##     ####  ####   #   #      ### #   # ##### ##### #####     ##"
echo "##     #   # #   # # # # #    #    #   #   #     #   #         ##"
echo "##     ####  ####  #  #  #     ##  #   #   #     #   ###       ##"
echo "##     #   # #     #     #       # #   #   #     #   #         ##"
echo "##     ####  #     #     #    ###  ##### #####   #   #####     ##"
echo "##                                                             ##"   
echo "##                                                             ##"   
echo "##  brought to you by,                                         ##"   
echo "##             ${AUTHORS}                                ##"
echo "##                                                             ##"   
echo "##  ${PROJECT} ##"
echo "##                                                             ##"   
echo "#################################################################"
echo

command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

# make some checks first before proceeding.	
if [[ -r $SRC_DIR/$EAP || -L $SRC_DIR/$EAP ]]; then
		echo EAP sources are present...
		echo
else
		echo Need to download $EAP package from the Customer Support Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

# Create the target directory if it does not already exist.
if [ ! -x target ]; then
		echo "  - creating the target directory..."
		echo
		mkdir target
else
		echo "  - detected target directory, moving on..."
		echo
fi

# Move the old JBoss instance, if it exists, to the OLD position.
if [ -x $JBOSS_HOME ]; then
		echo "  - existing JBoss Enterprise EAP 6 detected..."
		echo
		echo "  - moving existing JBoss Enterprise EAP 6 aside..."
		echo
		rm -rf $JBOSS_HOME.OLD
		mv $JBOSS_HOME $JBOSS_HOME.OLD

		# Unzip the JBoss EAP instance.
		echo Unpacking JBoss Enterprise EAP 6...
		echo
		unzip -q -d target $SRC_DIR/$EAP
else
		# Unzip the JBoss EAP instance.
		echo Unpacking new JBoss Enterprise EAP 6...
		echo
		unzip -q -d target $SRC_DIR/$EAP
fi

exit

# Unzip the required files from JBoss BRMS Deployable
echo Unpacking JBoss Enterprise BRMS $VERSION...
echo
cd installs
unzip -q $BRMS

echo "  - deploying JBoss Enterprise BRMS Manager WAR..."
echo
unzip -q -d ../$SERVER_DIR jboss-brms-manager-ee6.zip
rm jboss-brms-manager-ee6.zip 

echo "  - deploying jBPM Console WARs..."
echo
unzip -q -d ../$SERVER_DIR jboss-jbpm-console-ee6.zip
rm jboss-jbpm-console-ee6.zip

unzip -q jboss-jbpm-engine.zip 
echo "  - copying jBPM client JARs..."
echo
unzip -q -d ../$SERVER_DIR jboss-jbpm-engine.zip lib/netty.jar
rm jboss-jbpm-engine.zip
rm -rf *.jar modeshape.zip *.RSA lib
rm jboss-brms-engine.zip

echo Rounding up, setting permissions and copying support files...
echo
cd ../

echo "  - enabling demo accounts logins in brms-users.properties file..."
echo
cp support/brms-users.properties $SERVER_CONF

echo "  - enabling demo accounts role setup in brms-roles.properties file..."
echo
cp support/brms-roles.properties $SERVER_CONF

echo "  - adding dodeploy files to deploy all brms components..."
echo 
touch $SERVER_DIR/business-central-server.war.dodeploy
touch $SERVER_DIR/business-central.war.dodeploy
touch $SERVER_DIR/designer.war.dodeploy
touch $SERVER_DIR/jboss-brms.war.dodeploy
touch $SERVER_DIR/jbpm-human-task.war.dodeploy

echo "  - configuring deployment timeout extention and added security domain brms in standalone.xml..."
echo
cp support/standalone.xml $SERVER_CONF

# Add execute permissions to the standalone.sh script.
echo "  - making sure standalone.sh for server is executable..."
echo
chmod u+x $JBOSS_HOME/bin/standalone.sh

echo "JBoss Enterprise BRMS ${VERSION} ${DEMO} Setup Complete."
echo

