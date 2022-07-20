@isTest
private class CreditReportTrigger_Test {
	@isTest
    static void checkInsertBehavior() {
		Lead oLead = new Lead();
		oLead.Company ='Cloud Maven';
		oLead.FirstName = 'MARISOL L';
		oLead.LastName = 'testcase';
		oLead.SSN1__c = '000000006';
		oLead.Street_Owner_1__c = '220 LOCUST AVE';
		oLead.City_Owner_1__c = 'ANTHILL';
		oLead.Zip_Code_Owner_1__c ='65488'; 
		oLead.State_Owner_1__c ='MO';
		oLead.Country_Owner_1__c='US';
		oLead.Run_Credit_Report__c = true;
		
		oLead.First_Name_2nd_Owner__c = 'MARISOL L';
		oLead.Last_Name_2nd_Owner__c = 'testcase';
		oLead.SSN2__c = '000000001';
		oLead.Street_Owner_2__c = '220 LOCUST AVE';
		oLead.City_Owner_2__c = 'ANTHILL';
		oLead.Zip_Code_Owner_2__c ='65488'; 
		oLead.State_Owner_2__c ='MO';
		oLead.Country_Owner_2__c='US';
		oLead.Run_Owner2_Credit_Report__c = true;
		
		oLead.First_Name_3rd_Owner__c = 'MARISOL L';
		oLead.Last_Name_3rd_Owner__c = 'testcase';
		oLead.SSN_3rd_Owner__c = '000000004';
		oLead.Street_Owner_3__c = '220 LOCUST AVE';
		oLead.City_Owner_3__c = 'ANTHILL';
		oLead.Zip_Code_Owner_3__c ='65488'; 
		oLead.State_Owner_3__c ='MO';
		oLead.Country_Owner_3__c='US';
		oLead.Run_Owner3_Credit_Report__c = true;
		
		Test.startTest();
		insert oLead;
		system.assert(oLead != null);
		List<creditchecker__Credit_Report__c> listCR = [Select Id from creditchecker__Credit_Report__c];
		system.assert(listCR != null);
		system.assert(!listCR.isEmpty());
		Test.stopTest();
	}
	
	@IsTest
    static void checkUpdateBehavior() {
		Lead oLead = new Lead();
		oLead.Company ='Cloud Maven';
		oLead.FirstName = 'MARISOL L';
		oLead.LastName = 'testcase';
		oLead.SSN1__c = '000000006';
		oLead.Street_Owner_1__c = '220 LOCUST AVE';
		oLead.City_Owner_1__c = 'ANTHILL';
		oLead.Zip_Code_Owner_1__c ='65488'; 
		oLead.State_Owner_1__c ='MO';
		oLead.Country_Owner_1__c='US';
		
		oLead.First_Name_2nd_Owner__c = 'MARISOL L';
		oLead.Last_Name_2nd_Owner__c = 'testcase';
		oLead.SSN2__c = '000000001';
		oLead.Street_Owner_2__c = '220 LOCUST AVE';
		oLead.City_Owner_2__c = 'ANTHILL';
		oLead.Zip_Code_Owner_2__c ='65488'; 
		oLead.State_Owner_2__c ='MO';
		oLead.Country_Owner_2__c='US';
		
		oLead.First_Name_3rd_Owner__c = 'MARISOL L';
		oLead.Last_Name_3rd_Owner__c = 'testcase';
		oLead.SSN_3rd_Owner__c = '000000004';
		oLead.Street_Owner_3__c = '220 LOCUST AVE';
		oLead.City_Owner_3__c = 'ANTHILL';
		oLead.Zip_Code_Owner_3__c ='65488'; 
		oLead.State_Owner_3__c ='MO';
		oLead.Country_Owner_3__c='US';
		
		Test.startTest();
		insert oLead;
		
		oLead.Run_Owner2_Credit_Report__c = true;
		oLead.Run_Credit_Report__c = true;
		oLead.Run_Owner3_Credit_Report__c = true;
		update oLead;
		
		system.assert(oLead != null);
		List<creditchecker__Credit_Report__c> listCR = [Select Id from creditchecker__Credit_Report__c];
		system.assert(listCR != null);
		system.assert(!listCR.isEmpty());
		Test.stopTest();
	}
	
	@IsTest
    static void checkCreditReport() {
		Lead oLead = new Lead();
		oLead.Company ='Cloud Maven';
		oLead.FirstName = 'MARISOL L';
		oLead.LastName = 'testcase';
		oLead.SSN1__c = '000000006';
		oLead.Street_Owner_1__c = '220 LOCUST AVE';
		oLead.City_Owner_1__c = 'ANTHILL';
		oLead.Zip_Code_Owner_1__c ='65488'; 
		oLead.State_Owner_1__c ='MO';
		oLead.Country_Owner_1__c='US';
		oLead.Run_Credit_Report__c = true;
		
		oLead.First_Name_2nd_Owner__c = 'MARISOL L';
		oLead.Last_Name_2nd_Owner__c = 'testcase';
		oLead.SSN2__c = '000000001';
		oLead.Street_Owner_2__c = '220 LOCUST AVE';
		oLead.City_Owner_2__c = 'ANTHILL';
		oLead.Zip_Code_Owner_2__c ='65488'; 
		oLead.State_Owner_2__c ='MO';
		oLead.Country_Owner_2__c='US';
		oLead.Run_Owner2_Credit_Report__c = true;
		
		oLead.First_Name_3rd_Owner__c = 'MARISOL L';
		oLead.Last_Name_3rd_Owner__c = 'testcase';
		oLead.SSN_3rd_Owner__c = '000000004';
		oLead.Street_Owner_3__c = '220 LOCUST AVE';
		oLead.City_Owner_3__c = 'ANTHILL';
		oLead.Zip_Code_Owner_3__c ='65488'; 
		oLead.State_Owner_3__c ='MO';
		oLead.Country_Owner_3__c='US';
		oLead.Run_Owner3_Credit_Report__c = true;
		
		Test.startTest();
		insert oLead;
		system.assert(oLead != null);
		List<creditchecker__Credit_Report__c> listCR = [Select Id,creditchecker__Status__c,Owner_Type__c from creditchecker__Credit_Report__c];
		for(creditchecker__Credit_Report__c oCR : listCR) {
			oCR.creditchecker__Status__c = 'Completed';
		}
		update listCR;
		system.assert(listCR != null);
		system.assert(!listCR.isEmpty());
		Test.stopTest();
	}
}