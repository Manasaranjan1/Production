@IsTest(seeAlldata=true)
// Cloud Maven
public with sharing class OpportunityTriggerHandlerTest {

    //Stage is Final Approval
    @IsTest
    public static void testStageisFinalApproval() {
        List<Contact> listContact = new List<Contact>();
        Contact oContact = new Contact();
        oContact.FirstName = 'Test';
        oContact.LastName = 'Test';
        oContact.Birthdate = System.today().addYears(-20);
        oContact.State__c = 'MO';
        oContact.Country__c = 'US';
        oContact.Street__c = 'Test Street';
        oContact.City__c = 'Anthill';
        oContact.Zip_Code__c = '07029';
        oContact.SSN1__c = '000000000';
        listContact.add(oContact);

        Contact oContact2 = new Contact();
        oContact2.FirstName = 'Test';
        oContact2.LastName = 'Test 2';
        oContact2.Birthdate = System.today().addYears(-20);
        oContact2.State__c = 'MO';
        oContact2.Country__c = 'US';
        oContact2.Street__c = 'Street';
        oContact2.City__c = 'Anthill';
        oContact2.Zip_Code__c = '07029';
        oContact2.SSN1__c = '000000001';
        listContact.add(oContact2);

        insert listContact;

        Opportunity op = new Opportunity();
        op.StageName = 'Sales Review';
        op.Owner__c = listContact[0].Id;
        op.Second_Owner__c = listContact[1].Id;
        op.Third_Owner__c = listContact[0].Id;
        op.Fourth_Owner__c = listContact[0].Id;
        op.Fifth_Owner__c = listContact[1].Id;
        op.Run_Owner1_Credit_Report__c = true;
        op.Name = 'Test';
        op.CloseDate = System.today();
        
         Lead  objLead = new Lead();
        objLead.lastName = 'test';
        objLead.Company = 'RSI';
        objLead.Status = 'New';
        objLead.email = 'test@test.com';
        insert objLead;
        
        
     // lead objLead = [ Select id, recordType.Name from Lead Where ConvertedOpportunityId=:Op.Id];
 Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        Test.startTest();
        insert op;
        op.Run_Owner2_Credit_Report__c = true;
        op.Run_Owner3_Credit_Report__c = true;
        op.Run_Owner4_Credit_Report__c = true;
        op.Run_Owner5_Credit_Report__c = true;
        update op;
        
        op.Run_Owner1_Credit_Report__c = false;
        op.Run_Owner2_Credit_Report__c = false;
        op.Run_Owner3_Credit_Report__c = false;
        op.Run_Owner4_Credit_Report__c = false;
        op.Run_Owner5_Credit_Report__c = false;
        update op;
        
        
        
        Test.stopTest();
    }

    //Update Stage
    @IsTest
    public static void testUWStageisUnderwritingReview() {
        List<Contact> listContact = new List<Contact>();
        Contact oContact = new Contact();
        oContact.FirstName = 'Test';
        oContact.LastName = 'Test';
        oContact.Birthdate = System.today().addYears(-20);
        oContact.State__c = 'MO';
        oContact.Country__c = 'US';
        oContact.Street__c = 'Test Street';
        oContact.City__c = 'Anthill';
        oContact.Zip_Code__c = '07029';
        oContact.SSN1__c = '000000000';
        listContact.add(oContact);

        Contact oContact2 = new Contact();
        oContact2.FirstName = 'Test';
        oContact2.LastName = 'Test 2';
        oContact2.Birthdate = System.today().addYears(-20);
        oContact2.State__c = 'MO';
        oContact2.Country__c = 'US';
        oContact2.Street__c = 'Street';
        oContact2.City__c = 'Anthill';
        oContact2.Zip_Code__c = '07029';
        oContact2.SSN1__c = '000000001';
        listContact.add(oContact2);
        insert listContact;

        Opportunity op = new Opportunity();
        op.StageName = 'Sales Review';
        op.Name = 'Test';
        op.Owner__c = listContact[0].Id;
        op.Second_Owner__c = listContact[1].Id;
        op.Run_Owner1_Credit_Report__c = true;
        op.CloseDate = System.today();
        insert op;
        op.StageName = 'Sales Review';
        
        Id CarlRecTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Lendistry Default').getRecordTypeId();
        Lead  objLead = new Lead();
        objLead.lastName = 'test';
        objLead.Company = 'RSI';
        objLead.Status = 'New';
        objLead.RecordTypeId=CarlRecTypeId;
        objLead.Email = 'test@test.com';
        objLead.AnnualRevenue = 40;
        objLead.Are_you_COD_30_60_90__c = 'test';
        objLead.Brief_History_on_the_business__c = 'test';
        insert objLead;
        
        database.leadConvert lc = new database.leadConvert();
       lc.setLeadId(objLead.id);

       leadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);

      // Database.LeadConvertResult lcr = Database.convertLead(lc);
       //System.assert(lcr.isSuccess());

       //lc.setOpportunityName('test');
      // opportunity opQuery = [SELECT name FROM opportunity WHERE name = 'test'];
       // Lead ConvertedLead = [select id,PortalAPIEndPoint__c,Business_EIN__c , 
           // Last_Year_s_Period__c,BusinessId__c,Application_ID__c, convertedOpportunityID  from Lead
             //where isConverted=true and convertedOpportunityID !=null  AND Last_Year_s_Period__c!=NULL limit 1];
        //lead objLead1 = [ Select id,ConvertedOpportunityId ,recordType.Name from Lead Where isConverted=true limit 1];
         Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());  

        Test.startTest();
        update op;
        
        op.Run_Owner1_Credit_Report__c = true;
        update op;
        
        op.Run_Owner1_Credit_Report__c = false;
        update op;
        OpportunityTriggerHandler1.updateOppRecordType(op.Id);
        Test.stopTest();
    }

}