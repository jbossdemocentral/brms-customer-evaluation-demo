brms-customer-evaluation-demo: BRMS Customer Evaluation Demo
============================================================
Author: Eric D. Schabell
Level: Intermediate
Technologies: BRMS, JBPM
Summary: Demonstrates the use of BRMS for a Customer Evaluation
Prerequisites: 
Target Product: BRMS
Source: <https://github.com/eschabell/brms-customer-evaluation-demo>

What is it?
-----------

This quickstart shows how to use BRMS to evaluate a customer based on his age and financial status. It uses a `BPMN2` process to analyze the potential customer. 

* If the customer does not meet the age requirements, the request is denied.
* If the age requirement is satified, a Drools rule is fired to evaluate the customer's financial status.
* If the customer meets the financial requirements, the request valid. If not, the request is denied.


Configure and Run the Quickstart
-------------------

This quickstart has more complex setup and configuration requirements than many of the other quickstarts. Please see the `Quick Start Guide` located in the `docs/` folder for complete instructions on how to configrre and run this quickstart. The file is provided in both PDF and ODT formats.

The following is a brief summary of the steps you will take to configure and run the quickstart. _Note: These steps are not meant to replace the complete instructions contained in the `docs/Quick Start Guide.odt` or `docs/Quick Start Guide.pdf` files!_

1. Download the following from the JBoss Customer Portal at <https://access.redhat.com/jbossnetwork/restricted/listSoftware.html> into the quickstart `installs/` directory:
    * BRMS (brms-p-5.3.1.GA-deployable-ee6.zip)	
    * EAP (jboss-eap-6.1.0.zip)
2. Run `init.sh` to install EAP 6 and deploy BRMS. Verify the output and make sure the command completes successfully.
3. Configure JBoss Developer Studio (JBDS).
    * Install the SOA tools.
    * Add the BRMS platform server runtime.
    * Import the project.
4. Run `mvn clean install` on the project to ensure it builds successfully.
5. Start the JBoss EAP server.
6. Login to JBoss BRMS at <http://localhost:8080/jboss-brms>.
7. Import the project repository `repository-export.zip` file from the `support/` directory.
8. Build and deploy project in BRM.
9. Login to BRMS Central at <http://localhost:8080/business-central>.
10. Start the process and view the JBoss EAP logs for results.

_Note: Windows users should see `support/windows/README` for installation procedures._


Supporting Articles
-------------------

Please see the following articles for additional information.

* [Customer Evaluation Demo Updated to EAP 6.1.0] (http://www.schabell.org/2013/05/jboss-brms-customer-eval-demo-eap-610.html)
* [Customer Evaluation Demo Updated to EAP 6.1.0.Beta] (http://www.schabell.org/2013/04/red-hat-jboss-brms-customer-evaluation.html)
* [Adding Declarative Model to Customer Evaluation Demo] (http://www.schabell.org/2013/03/jboss-brms-customer-eval-demo-declarative-model.html)
* [Customer Evaluation Demo Updated to EAP 6.0.0] (http://www.schabell.org/2013/01/jboss-brms-customer-evaluation-demo-update.html)
* [BPM made simple with Customer Evaluation Demo including video] (http://www.schabell.org/2012/06/jboss-enterprise-brms-bpm-made-simple.html)
* [How to setup SOA Tools in BRMS Example for JBoss Dev Studio 7] (http://www.schabell.org/2013/04/jboss-developer-studio-7-how-to-setup.html)
* [How to setup SOA Tools in BRMS Example for JBoss Dev Studio 6] (http://www.schabell.org/2013/04/jboss-developer-studio-6-how-to-setup.html)
* [How to setup SOA Tools in BRMS Example for JBoss Dev Studio 5] (http://www.schabell.org/2012/05/jboss-developer-studio-5-how-to-setup.html)
* [How to add Eclipse BPMN2 Modeller project to JBoss Dev Studio 5] (http://www.schabell.org/2013/01/jbds-bpmn2-modeler-howto-install.html)
* [Demo now available with Windows installation scripts] (http://www.schabell.org/2013/04/jboss-brms-demos-available-windows.html)

Brazilian language translation of demo documentation is availabe in the `support/Quick Start Guide (pt-BR).{odt|pdf}`


Released versions
-----------------

See the tagged releases for the following versions of the product:

* v2.0 is BRMS 5.3.1 deployable, JBDS 7.0.0.Beta1, running on JBoss EAP 6.1.0, includes pt-BR documentation translation.
* v1.9 is BRMS 5.3.1 deployable, running on JBoss EAP 6.1.0.
* v1.8 is BRMS 5.3.1 deployable, running on JBoss EAP 6.1.0.Beta.
* v1.7 demo project Mavenized.
* v1.6 has Windows installation scripts.
* v1.5 has patched designer that fixes removal of end-of-lines in code editor.
* v1.4 is BRMS 5.3.1 deployable, running on JBoss EAP 6, added a declarative model example (support/repository_export_declarative_model.zip)
* v1.3 is BRMS 5.3.1 deployable, running on JBoss EAP 6, cleaner logging, serialized object model fixes.
* v1.2 is BRMS 5.3.1 deployable, running on JBoss EAP 6.
* v1.0 is BRMS 5.3.0 standalone, running on JBoss EAP 5.



