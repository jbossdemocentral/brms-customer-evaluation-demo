brms-customer-evaluation-demo: BRMS Customer Evaluation Demo
============================================================
Author: Eric D. Schabell
Level: Beginner
Technologies: BRMS, JBPM
Summary: Demonstrates the use of BRMS for a Customer Evaluation
Prerequisites: 
Target Product: BRMS
Source: <https://github.com/eschabell/brms-customer-evaluation-demo>

What is it?
-----------

This quickstart shows how to use BRMS to evaluate a Customer based on his agen and the ammount of his funds.

It will use a BPMN2 process to analyze a potential customer. The customer will have his request denied if he is underaged.

If the customer is an adult then a Drools rule is fired to determine if the Customer financial situation to determine if the request still valid or not.

System requirements
-------------------

All you need to build this project is Java 6.0 (Java SDK 1.6) or better, Maven 3.0 or better.

The application this project produces is designed to be run on BRMS 5.3.1 and JBoss EAP 6.1

Configure your environment
--------------------------

- Acccess <https://access.redhat.com/jbossnetwork/restricted/listSoftware.html>
- Download BRMS Platform
  1. Under JBoss Enterprise Platforms, select the BRMS Platform product.
  2. Select version 5.3.1 in the Version field.
  3. Download JBoss BRMS 5.3.1 Deployable for EAP 6 (Please note that this is the deployable distribution, not the standalone one.)
  4. Now copy brms-p-5.3.1.GA-deployable-ee6.zip, to the brms-customer-evaluation-demo's installs folder. 
  5. Ensure that this file is executable by running:

        $ chmod +x <path-to-project>/installs/brms-p-5.3.1.GA-deployableee6.zip
  
- Download EAP 6 Platform:
  1. Under JBoss Enterprise Platforms, select the Application Platform product.
  2. Select version 6.1.0.Beta in the Version field.
  3. Download JBoss Aplication Platform 6.1.0.
  4. Now copy jboss-eap-6.1.0.zip, to the brms-rewards-demo's installs folder. 
  5. Ensure that this file is executable by running:

        $ chmod +x <path-to-project>/installs/jboss-eap-6.1.0.zip

- Lastly, from the brms-rewards-demo folder, run the init.sh script:

        $ ./init.sh
  

Build and Run the Quickstart
----------------------------

_NOTE: The following build command assumes you have configured your Environment._

1. Open a command line and navigate to the root directory of this quickstart (<repo_root>/projects/brms-customer-evaluation-demo).
2. Type this command to build and runt the tests:

        mvn clean test 

Investigate the Console Output
------------------------------

### Maven

Maven prints summary of performed tests into the console:

    -------------------------------------------------------
     T E S T S
    -------------------------------------------------------
    Running org.jbpm.evaluation.customer.CustomerEvaluationTest
    
    =========================================
    = Starting Process Underaged Test Case. =
    =========================================
    Entering Initialize Node
    Leaving Initialize Node
    Gateway: Qualify Age
    Gateway: Qualify Age
    Entering Underaged Node
    Detected and reporting invalid request.
    Set validRequest to: false
    Leaving Underaged Node
    Process ended in End Minor Node.
    
    ==========================================
    = Starting Process Poor Adult Test Case. =
    ==========================================
    Entering Initialize Node
    Leaving Initialize Node
    Gateway: Qualify Age
    Gateway: Qualify Age
    Entering Adult Customer Node
    Detected and reporting valid request
    Set validRequest to: true
    Leaving Adult Customer Node
    Entering Finance Rules Node
    Under funded customer
    Set Request invalid comment to: Poor customer.
    Customer request= org.jbpm.evaluation.customer.Request@31
    Leaving Finance Rules Node.
    Gateway: Decide Financial Status
    Determined request is NOT valid, heading to Poor Customer Node
    Request validity reason is: Poor customer
    Leaving Finance Rules Node.
    Gateway: Decide Financial Status
    Detected  request is invalid, heading to Poor Customer Node
    Request not valid reason is: Poor customer
    Entering Poor Customer Node
    Customer has amount: 2 in the bank.
    Leaving Poor Customer Node
    Process ended in End Poor Customer Node.
    
    ==========================================
    = Starting Process Rich Adult Test Case. =
    ==========================================
    Entering Initialize Node
    Leaving Initialize Node
    Gateway: Qualify Age
    Gateway: Qualify Age
    Entering Adult Customer Node
    Detected and reporting valid request
    Set validRequest to: true
    Leaving Adult Customer Node
    Entering Finance Rules Node
    Leaving Finance Rules Node.
    Gateway: Decide Financial Status
    Determined request is valid, heading to Rich Customer Node
    Entering Rich Customer Node
    Detected and reporting valid request
    Customer has amount: 2000 in the bank.
    Leaving Rich Customer Node
    Process ended in End Rich Customer Node.
    
    =============================================
    = Starting Process Empty Request Test Case. =
    =============================================
    Entering Initialize Node
    There as no evaluation objects defined, adding default ones for demo purposes.
    Leaving Initialize Node
    Gateway: Qualify Age
    Gateway: Qualify Age
    Entering Underaged Node
    Detected and reporting invalid request.
    Set validRequest to: false
    Leaving Underaged Node
    Process ended in End Minor Node.
    Tests run: 4, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 8.175 sec
    
    Results :
    
    Tests run: 4, Failures: 0, Errors: 0, Skipped: 0
    
