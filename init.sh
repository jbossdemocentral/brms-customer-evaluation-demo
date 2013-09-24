#!/bin/sh 
DEMO="Customer Evaluation Demo"
AUTHORS="Eric D. Schabell"
PROJECT="git@github.com:eschabell/brms-customer-evaluation-demo.git"
PRODUCT="JBoss BPM Suite"
JBOSS_HOME=./target/jboss-eap-6.1
SERVER_DIR=$JBOSS_HOME/standalone/deployments/
SERVER_CONF=$JBOSS_HOME/standalone/configuration/
SERVER_BIN=$JBOSS_HOME/bin/
SRC_DIR=./installs
SUPPORT_DIR=./support
PRJ_DIR=./projects/brms-customer-evaluation-demo
EAP=jboss-eap-6.1.0.zip
BPMS=jboss-bpms-6.0.0-redhat-3-deployable.zip
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

# Unzip the required files from JBoss product deployable.
echo Unpacking $PRODUCT $VERSION...
echo
unzip -q $SRC_DIR/$BPMS

echo Installing $PRODUCT Manager components, business-central and dashbuilder WARs...
echo
unzip -q -d $SERVER_DIR jboss-bpms-manager.zip
rm jboss-bpms-manager.zip 

#echo "  - deploying $PRODUCT Engine..."
#echo
#unzip -q -d $JBOSS_HOME/standalone/lib/ext jboss-bpms-engine.zip
rm jboss-bpms-engine.zip

echo "  - adding BPM Suite modules..."
echo
cp $SUPPORT_DIR/layers.conf  $JBOSS_HOME/modules
unzip -q -d $JBOSS_HOME/modules/system/layers $SUPPORT_DIR/layers-bpms.zip

echo "  - enabling demo accounts logins in application-users.properties file..."
echo
cp $SUPPORT_DIR/application-users.properties $SERVER_CONF

echo "  - enabling demo accounts role setup in application-roles.properties file..."
echo
cp $SUPPORT_DIR/application-roles.properties $SERVER_CONF

echo "  - configuring product.conf..."
echo
cp $SUPPORT_DIR/product.conf $SERVER_BIN

echo "  - configuring standalone.xml files..."
echo
cp $SUPPORT_DIR/standalone.xml $SERVER_CONF
cp $SUPPORT_DIR/standalone-osgi.xml $SERVER_CONF
cp $SUPPORT_DIR/standalone-full.xml $SERVER_CONF
cp $SUPPORT_DIR/standalone-full-ha.xml $SERVER_CONF
cp $SUPPORT_DIR/standalone-ha.xml $SERVER_CONF

# Add execute permissions to the standalone.sh script.
echo "  - making sure standalone.sh for server is executable..."
echo
chmod u+x $JBOSS_HOME/bin/standalone.sh

echo "  - adding dodeploy files..."
echo
touch ${SERVER_DIR}business-central.war.dodeploy
touch ${SERVER_DIR}dashbuilder.war.dodeploy

echo "You can now start the $PRODUCT with ${SERVER_BIN}standalone.sh"
echo

echo "$PRODUCT $VERSION $DEMO Setup Complete."
echo

