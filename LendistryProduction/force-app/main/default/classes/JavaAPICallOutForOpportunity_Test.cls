@isTest(SeeAllData=true)
public class JavaAPICallOutForOpportunity_Test {
    static testmethod void myUnitTest(){
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

        Opportunity ObjOpp = new Opportunity();
        objOpp.Owner__c = listContact[0].Id;
        objOpp.Second_Owner__c = listContact[1].Id;
        objOpp.Third_Owner__c = listContact[0].Id;
        objOpp.Fourth_Owner__c = listContact[0].Id;
        objOpp.Fifth_Owner__c = listContact[1].Id;
        objOpp.Run_Owner1_Credit_Report__c = true;
        objOpp.Name= 'TestOpp';
        objOpp.StageName = 'Sales Review';
        objOpp.BusinessId__c = '78965';
        objOpp.Application_ID__c = 'DIR30265237';
        objOpp.Network_Selection__c = 'Declined';
        ObjOpp.CloseDate = system.today()+5;
        ObjOpp.Days_in_UW_Sub__c = 0;
        ObjOpp.Projected_Close_Date__c = system.today() +10;
        insert objOpp;
        
         Lead  objLead = new Lead();
        objLead.lastName = 'test';
        objLead.Company = 'RSI';
        objLead.Status = 'New';
        insert objLead;
        
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        String requestBodyString = '{"applicationId":"DIR30265237","businessId":"78965","leadId":"00Q6w000002Dg7V","stageName":"Sales Review","opportunityId":"0066w000002xNgp","isOpportunity":true,"networkSelection":"Declined"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/JavaAPICallOutForOpportunity/*','POST');
        RestContext.response = new RestResponse();
        Test.startTest();
        //insert op;
        objOpp.Run_Owner2_Credit_Report__c = true;
        objOpp.Run_Owner3_Credit_Report__c = true;
        objOpp.Run_Owner4_Credit_Report__c = true;
        objOpp.Run_Owner5_Credit_Report__c = true;
        update Objopp;
        
        objOpp.Run_Owner1_Credit_Report__c = false;
        objOpp.Run_Owner2_Credit_Report__c = false;
        objOpp.Run_Owner3_Credit_Report__c = false;
        objOpp.Run_Owner4_Credit_Report__c = false;
        objOpp.Run_Owner5_Credit_Report__c = false;
        update objOpp;
        JavaAPICallOutForOpportunity.sendNetworkSelction('test', '78965', 'DIR30265237', 'Sales Review', 'Declined', true, objOpp.Id);
        Test.stopTest();
    }
    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType) {
        RestRequest req = new RestRequest();
        req.requestURI = url; 
        req.httpMethod = requestType;
        req.requestBody = Blob.valueof(requestBodyString);
        return req;
        
    }
    private static RestResponse setTestRestResponse(String responseBodyString, String url, String responseType) {
        RestResponse res = new RestResponse();
        res.statusCode = 500;
        //res.responseURI = url; 
        //res.httpMethod = responseType;
        res.responseBody = Blob.valueof(responseBodyString);
        return res;
    }
}