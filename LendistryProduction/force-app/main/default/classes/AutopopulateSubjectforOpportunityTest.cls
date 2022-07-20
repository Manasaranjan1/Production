@isTest
public class AutopopulateSubjectforOpportunityTest {
	@isTest
    public static void testMethod1(){
        String oppRecId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Lendistry Lending').getRecordTypeId();
        System.debug('oppRecId:::'+oppRecId);
        Opportunity op = new Opportunity();
        op.StageName = 'Sales Review';
        op.RecordTypeId = oppRecId;
        op.Name = 'Test';
        op.CloseDate = System.today();
        insert op;
        
        Event e = new Event();
        e.WhatId=op.id;
        e.Event_Type__c = 'Lendistry Review';
        e.StartDateTime=system.today();
        e.EndDateTime=system.today()+5;
        
        Test.startTest();  
			try{
				insert  e;
            }
			catch(Exception ex){
                System.debug('ex::'+ex.getMessage());
            }
		Test.stopTest();  
    }
}