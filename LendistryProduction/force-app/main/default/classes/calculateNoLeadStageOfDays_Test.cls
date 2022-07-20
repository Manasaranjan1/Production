@isTest(seeAlldata=true)
public class calculateNoLeadStageOfDays_Test {
    public static testMethod void method(){
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        Id leadRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Lendistry Default').getRecordTypeId();
        Lead objLead = new Lead();
        objLead.LastName ='Test';
        objLead.status = 'New';
        objLead.company ='RSI';
        objLead.of_Days_in_Pending_Follow_up__c = 89;
        objLead.recordTypeId = leadRecordTypeId;
        insert objLead ;
        // insert history
        Lead_History__c objHis = new Lead_History__c();
        objHis.Lead_Status__c ='New';
        objHis.Lead__c = objLead.Id;
        objHis.Lead_End_Date__c = Date.today();
        objHis.Status_Start_Date__c  = objHis.Lead_End_Date__c.addDays(-4);
        insert objHis;
        calculateNoLeadStageOfDays.updateNoOfDays(new List<Lead>{objLead });
        
    
    }
        

}