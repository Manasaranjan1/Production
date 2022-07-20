@isTest (seeAllData=true)
public class centerCompCls_Test {
    static testMethod void testMethod1() {
 
       /* Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        UserRole r = [SELECT Id FROM UserRole WHERE Name='COO'];
        User futureUser = new User(firstname = 'Future', lastname = 'User',
            alias = 'future', defaultgroupnotificationfrequency = 'N',
            digestfrequency = 'N', email = 'test@test.org',
            emailencodingkey = 'UTF-8', languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, 
            timezonesidkey = 'America/Los_Angeles',
            username = 'futureuser@test.org',
            userpermissionsmarketinguser = false,
            userpermissionsofflineuser = false, userroleid = r.Id);
        insert(futureUser); */
        
          Lead ObjLead = new Lead();
         objLead.LastName = 'TestName';
        objLead.Email = 'test12334@yopmail.com';
        objLead.Company = 'Testcompany';
        objLead.Status = 'Pending Follow up';
        objLead.Use_of_Funds__c = 'Acquire Another Business';
        objLead.Referral_Partner1__c = 'Center Intake Form';
        objLead.NumberOfEmployees = 25;
       // insert objLead;
        
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
       // centerCompCls.createLead(objLead, 'Consolidate Debt', 'Hire New Staff', 'Open a New Location', 'Working Capital', 'Advertising /Marketing', 'Develop a New Product', 'Tenant Improvement','Leasehold Improvement','Remodel Current Location','Inventory Purchase', 'Equipment Purchase','Develop a New Product', 'test', 45);
        centerCompCls.createLead(objLead, 45); 
        centerCompCls.getPiklistValues();
        centerCompCls.getDependentMap(objLead, 'status', 'Unqualified_Reason__c');
        centerCompCls.decimalToBinary(45);
        centerCompCls.base64ToBits('validFor');  
        
    }
}