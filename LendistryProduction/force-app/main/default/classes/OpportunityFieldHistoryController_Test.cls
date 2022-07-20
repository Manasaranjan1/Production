@isTest 
public class OpportunityFieldHistoryController_Test {
    
    static testMethod void testMethod1() 
    {
        
        Account ObjAccount = new Account();
        ObjAccount.Name='Test Account record' ;
        insert ObjAccount;
        Contact objContact = new Contact();
        objContact.LastName = 'ContactLastName';
        objContact.AccountId =ObjAccount.Id;
        
        insert objContact;
        
        Opportunity ObjOpp = new Opportunity();
        objOpp.Name= 'TestOpp';
        objOpp.StageName = 'Sales Review';
        ObjOpp.AccountId = ObjAccount.id;
        ObjOpp.CloseDate = system.today()+5;
        ObjOpp.Days_in_UW_Sub__c = 0;
        ObjOpp.Projected_Close_Date__c = system.today() +10;
        insert objOpp;
        
        Opportunity ObjOpp1 = new Opportunity();
        ObjOpp1.Name= 'TestOpp';
        ObjOpp1.StageName = 'Sub for Review';
        ObjOpp1.AccountId = ObjAccount.id;
        ObjOpp1.CloseDate = system.today()+5;
        ObjOpp1.Days_in_UW_Sub__c = 0;
        ObjOpp1.Projected_Close_Date__c = system.today() +10;
        insert ObjOpp1;
        
        Opportunity_Field_History__c ObjOppHistry = new Opportunity_Field_History__c();
        ObjOppHistry.Stage_New__c = 'Sales Review';
        ObjOppHistry.Opportunity__c = ObjOpp.Id;
        ObjOppHistry.Stage_Start_Date__c = system.today();
        ObjOppHistry.Stage_Close_Date__c = system.today() +10;
        insert ObjOppHistry;
        Opportunity_Field_History__c ObjOppHistry1 = new Opportunity_Field_History__c();
        ObjOppHistry1.Stage_New__c = 'UW Sub';
        ObjOppHistry1.Opportunity__c = ObjOpp.Id;
        ObjOppHistry1.Stage_Start_Date__c = system.today();
        ObjOppHistry1.Stage_Close_Date__c = system.today() +10;
        
        insert ObjOppHistry1;
        ObjOppHistry1.Stage_New__c = 'CL Out';
        update ObjOppHistry1;
        ObjOppHistry1.Stage_New__c = 'PreQual Out';
        update ObjOppHistry1;
        
        Opportunity_Field_History__c ObjOppHistry5 = new Opportunity_Field_History__c();
        ObjOppHistry5.Stage_New__c = 'Processing Sub';
        ObjOppHistry5.Opportunity__c = ObjOpp.Id;
        ObjOppHistry5.Stage_Start_Date__c = system.today();
        ObjOppHistry5.Stage_Close_Date__c = system.today() +1;
        insert ObjOppHistry5;
        
        Opportunity_Field_History__c ObjOppHistry6 = new Opportunity_Field_History__c();
        ObjOppHistry6.Stage_New__c = 'Packaging';
        ObjOppHistry6.Opportunity__c = ObjOpp.Id;
        ObjOppHistry6.Stage_Start_Date__c = system.today()+1;
        ObjOppHistry6.Stage_Close_Date__c = system.today() +2;
        insert ObjOppHistry6;
        Opportunity_Field_History__c ObjOppHistry8 = new Opportunity_Field_History__c();
        ObjOppHistry8.Stage_New__c = 'Sub for Review';
        ObjOppHistry8.Opportunity__c = ObjOpp1.Id;
        ObjOppHistry8.Stage_Start_Date__c = system.today()+2;
        ObjOppHistry8.Stage_Close_Date__c = system.today() +3;
        insert ObjOppHistry8;
        
        Opportunity_Field_History__c ObjOppHistry14 = new Opportunity_Field_History__c();
        ObjOppHistry14.Stage_New__c = 'Funded';
        ObjOppHistry14.Opportunity__c = ObjOpp.Id;
        ObjOppHistry14.Stage_Start_Date__c = system.today()+3;
        ObjOppHistry14.Stage_Close_Date__c = system.today() +4;
        insert ObjOppHistry14;
        
        Opportunity_Field_History__c ObjOppHistry13 = new Opportunity_Field_History__c();
        ObjOppHistry13.Stage_New__c = 'Missed Opp';
        ObjOppHistry13.Opportunity__c = ObjOpp.Id;
        ObjOppHistry13.Stage_Start_Date__c = system.today()+4;
        ObjOppHistry13.Stage_Close_Date__c = system.today() +5;
        insert ObjOppHistry13;
        Opportunity_Field_History__c ObjOppHistry12 = new Opportunity_Field_History__c();
        ObjOppHistry12.Stage_New__c = 'Suspended';
        ObjOppHistry12.Opportunity__c = ObjOpp.Id;
        ObjOppHistry12.Stage_Start_Date__c = system.today()+5;
        ObjOppHistry12.Stage_Close_Date__c = system.today() +6;
        insert ObjOppHistry12;
        
        Test.StartTest(); 
        	OpportunityFieldHistoryController.fetchOpportunityHistoryData(objOpp.id); 
        Batch_update_duration_on_Opp obj = new Batch_update_duration_on_Opp();
        DataBase.executeBatch(obj); 
        Test.StopTest();
    }
    
}