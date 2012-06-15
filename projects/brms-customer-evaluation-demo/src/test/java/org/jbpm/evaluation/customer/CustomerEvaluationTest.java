package org.jbpm.evaluation.customer;

import java.util.HashMap;
import java.util.Map;

import org.drools.KnowledgeBase;
import org.drools.builder.KnowledgeBuilder;
import org.drools.builder.KnowledgeBuilderFactory;
import org.drools.builder.ResourceType;
import org.drools.io.ResourceFactory;
import org.drools.logger.KnowledgeRuntimeLogger;
import org.drools.logger.KnowledgeRuntimeLoggerFactory;
import org.drools.runtime.StatefulKnowledgeSession;
import org.drools.runtime.process.WorkflowProcessInstance;
import org.jbpm.test.JbpmJUnitTestCase;
import org.junit.Test;

/**
 * This is a sample file to launch a process.
 */
public class CustomerEvaluationTest extends JbpmJUnitTestCase {

	private static Integer underAged    = 11;
	private static Integer adultAged    = 25;
	private static Integer richCustomer = 2000; // greater than 999.
	private static Integer poorCutomer  = 2;
	
	public CustomerEvaluationTest() {
		super(true);
	}

	@Test
	public void underagedCustomerEvaluationTest() {

		// setup.
		KnowledgeBase kbase = getNewKnowledgeBase();
		StatefulKnowledgeSession ksession = kbase.newStatefulKnowledgeSession(); 

		// optional: setup logging.
		KnowledgeRuntimeLogger logger = KnowledgeRuntimeLoggerFactory.newThreadedFileLogger(ksession, "CustomerEvaluationUnderaged", 1000);
	
		// setup of a Person and Request.
		Person underagedEval = getUnderagedCustomer();
		Request richEval = getRichCustomer();
		ksession.insert(underagedEval);

		// Map to be passed to the startProcess.
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("person", underagedEval);
		params.put("request", richEval);
		
		// Fire it up!
		System.out.println("=========================================");
		System.out.println("= Starting Process Underaged Test Case. =");
		System.out.println("=========================================");

		WorkflowProcessInstance processInstance = (WorkflowProcessInstance) ksession.startProcess("org.jbpm.customer-evaluation", params);
		ksession.insert(processInstance);
		ksession.fireAllRules();
				
		// Finished, clean up the logger.
		assertProcessInstanceCompleted(processInstance.getId(), ksession);
		logger.close();
		
		assertProcessInstanceCompleted(processInstance.getId(), ksession);
		ksession.dispose();
	}

	@Test
	public void adultCustomerEvaluationTest() {

		// setup.
		KnowledgeBase kbase = getNewKnowledgeBase();
		StatefulKnowledgeSession ksession = kbase.newStatefulKnowledgeSession(); 

		// optional: setup logging.
		KnowledgeRuntimeLogger logger = KnowledgeRuntimeLoggerFactory.newThreadedFileLogger(ksession, "CustomerEvaluationPoorAdult", 1000);
	
		// setup of a Person and Request.
		Person adultEval = getAdultCustomer();
		Request poorEval = getPoorCustomer();
		ksession.insert(adultEval);

		// Map to be passed to the startProcess.
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("person", adultEval);
		params.put("request", poorEval);
		
		// Fire it up!
		System.out.println("==========================================");
		System.out.println("= Starting Process Poor Adult Test Case. =");
		System.out.println("==========================================");

		WorkflowProcessInstance processInstance = (WorkflowProcessInstance) ksession.startProcess("org.jbpm.customer-evaluation", params);
		ksession.insert(processInstance);
		ksession.fireAllRules();
				
		// Finished, clean up the logger.
		assertProcessInstanceCompleted(processInstance.getId(), ksession);
		logger.close();
		
		assertProcessInstanceCompleted(processInstance.getId(), ksession);
		ksession.dispose();
	}

	@Test
	public void richCustomerEvaluationTest() {

		// setup.
		KnowledgeBase kbase = getNewKnowledgeBase();
		StatefulKnowledgeSession ksession = kbase.newStatefulKnowledgeSession(); 

		// optional: setup logging.
		KnowledgeRuntimeLogger logger = KnowledgeRuntimeLoggerFactory.newThreadedFileLogger(ksession, "CustomerEvaluationRichAdult", 1000);
	
		// setup of a Person and Request.
		Person adultEval = getAdultCustomer();
		Request richEval = getRichCustomer();
		ksession.insert(adultEval);

		// Map to be passed to the startProcess.
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("person", adultEval);
		params.put("request", richEval);
		
		// Fire it up!
		System.out.println("==========================================");
		System.out.println("= Starting Process Rich Adult Test Case. =");
		System.out.println("==========================================");
		WorkflowProcessInstance processInstance = (WorkflowProcessInstance) ksession.startProcess("org.jbpm.customer-evaluation", params);
		ksession.insert(processInstance);
		ksession.fireAllRules();
				
		// Finished, clean up the logger.
		assertProcessInstanceCompleted(processInstance.getId(), ksession);
		logger.close();
		
		assertProcessInstanceCompleted(processInstance.getId(), ksession);
		ksession.dispose();
	}

	
	@Test
	public void emptyRequestCustomerEvaluationTest() {

		// setup.
		KnowledgeBase kbase = getNewKnowledgeBase();
		StatefulKnowledgeSession ksession = kbase.newStatefulKnowledgeSession(); 

		// optional: setup logging.
		KnowledgeRuntimeLogger logger = KnowledgeRuntimeLoggerFactory.newThreadedFileLogger(ksession, "CustomerEvaluationEmptyRequest", 1000);
	

		// Map to be passed to the startProcess is intentionally empty.
		Map<String, Object> params = new HashMap<String, Object>();
		
		// Fire it up!
		System.out.println("=============================================");
		System.out.println("= Starting Process Empty Request Test Case. =");
		System.out.println("=============================================");
		WorkflowProcessInstance processInstance = (WorkflowProcessInstance) ksession.startProcess("org.jbpm.customer-evaluation", params);
		ksession.insert(processInstance);
		ksession.fireAllRules();
				
		// Finished, clean up the logger.
		assertProcessInstanceCompleted(processInstance.getId(), ksession);
		logger.close();
		
		assertProcessInstanceCompleted(processInstance.getId(), ksession);
		ksession.dispose();
	}

	private KnowledgeBase getNewKnowledgeBase() {
		KnowledgeBuilder kbuilder = KnowledgeBuilderFactory.newKnowledgeBuilder();
		kbuilder.add(ResourceFactory.newClassPathResource("customereval.bpmn2"), ResourceType.BPMN2);
		kbuilder.add(ResourceFactory.newClassPathResource("financerules.drl"), ResourceType.DRL);		
		KnowledgeBase kbase = kbuilder.newKnowledgeBase();
		return kbase;
	}
	/**
	 * Provide an under aged person.
	 * 
	 * @return org.jbpm.evaluation.customer.Person
	 */
	private Person getUnderagedCustomer() {
		Person person = new Person("erics", "Eric D. Schabell");
		person.setAge(underAged);
		return person;
	}

	
	/**
	 * Provide an of aged person.
	 * 
	 * @return org.jbpm.evaluation.customer.Person
	 */
	private Person getAdultCustomer() {
		Person person = new Person("erics", "Eric D. Schabell");
		person.setAge(adultAged);
		return person;
	}

	/**
	 * Provide a poor person in the request.
	 * 
	 * @return org.jbpm.evaluation.customer.Request
	 */
	private Request getPoorCustomer() {
		Request request = new Request("1");
		request.setPersonId("erics");
		request.setAmount(poorCutomer);
		return request;
	}

	/**
	 * Provide a rich person in the request.
	 * 
	 * @return org.jbpm.evaluation.customer.Request
	 */
	private Request getRichCustomer() {
		Request request = new Request("1");
		request.setPersonId("erics");
		request.setAmount(richCustomer);
		return request;
	}
}