@isTest
//Cloud Maven Contact Trigger Handler Test Class
class ContactTriggerHandlerTest {
    
    @testSetup
    static void createTestData() {
      	Account acc = TestDataService.createAccount();  
        List<Contact> lstContacts = TestDataService.createContacts( acc.Id, 4 );
        Opportunity oppty = TestDataService.createOpportunity( acc.Id, lstContacts[0].Id ); 
        oppty.Owner__c = lstContacts[0].Id;
        oppty.Second_Owner__c = lstContacts[1].Id;
        oppty.Third_Owner__c = lstContacts[2].Id;
        oppty.Fourth_Owner__c = lstContacts[3].Id;
        update oppty;
        creditchecker__Credit_Report__c creditReport = TestDataService.createCreditReport( lstContacts[0], oppty.Id );
    }
    
    
    @isTest
    static void test_contact_update() {
        List<Contact> lstContacts = [SELECT Id FROM Contact LIMIT 100];
        for( Contact con : lstContacts ) {
            con.creditchecker__Average_Score__c = 600;
        } 
        update lstContacts;
        Opportunity oppty = [SELECT First_Owner_Credit_SCore__c FROM Opportunity LIMIT 1];
        System.assert( oppty.First_Owner_Credit_SCore__c == 600 );
    }
    
}