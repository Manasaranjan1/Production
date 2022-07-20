@isTest(SeeAllData=true)
public class insertLeadHistory_Test {
    static testMethod void method(){
         Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());      
        Lead objLead = new Lead();
        objLead.LastName = 'TestName';
        objLead.Company = 'Testcompany';
        objLead.Status = 'Pending Follow up';
        insert objLead;
        Lead_History__c objHistory = new Lead_History__c();
        objHistory.Lead__c = objLead.Id;
        objHistory.Lead_Status__c = objLead.Status;
        objHistory.Status_Start_Date__c = Date.today();
        objHistory.Lead_End_Date__c = Date.today();
        insert objHistory;
        Test.startTest();
        List<Lead> listOfLead = new List<Lead>();
        insertLeadHistory.createHistory(listOfLead);
        insertLeadHistory.updateAndInsertHistory(listOfLead);
        Test.stopTest();
        
    }
}