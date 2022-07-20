@isTest
public class EntityTypeUpdateTest{
   @isTest
    public static void PatchEntityType1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Opportunity objOpp = new Opportunity();
        objOpp.name='test name';
        objOpp.StageName='New';
        objOpp.closeDate  = Date.today();
        insert objOpp;
        
        Lead objLead = new Lead();        
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objLead.Entity_Type__c = 'Corporation';
        
        insert objLead;
        
        String requestBodyString = '{"LeadId":"'+objLead.Id+'","OpportunityID":"'+objOpp.Id+'","BusinessType":"Corporation"}';
         RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/EntityTypeUpdate/*','PATCH');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        EntityTypeUpdate.PatchEntityType();
        Test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    }
     @isTest
    public static void PatchEntityType2(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Opportunity objOpp = new Opportunity();
        objOpp.name='test name';
        objOpp.StageName='New';
        objOpp.closeDate  = Date.today();
        insert objOpp;
        
        Lead objLead = new Lead();        
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objLead.Entity_Type__c = 'Corporation';
        
        insert objLead;
        
        String requestBodyString = '{"LeadId":"'+objLead.Id+'","BusinessType":"Corporation"}';
         RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/EntityTypeUpdate/*','PATCH');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        EntityTypeUpdate.PatchEntityType();
        Test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    }
    
     @isTest
    public static void PatchEntityType3(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Opportunity objOpp = new Opportunity();
        objOpp.name='test name';
        objOpp.StageName='New';
        objOpp.closeDate  = Date.today();
        insert objOpp;
        
        Lead objLead = new Lead();        
        objLead.Title = 'Mr.';
        objLead.FirstName = 'FirstName';
        objLead.LastName = 'test';
        objLead.Company = 'Test';
        objLead.Entity_Type__c = 'Corporation';
        
        insert objLead;
        
        String requestBodyString = '{"LeadId":"'+objOpp.Id+'","BusinessType":"Corporation"}';
         RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/EntityTypeUpdate/*','PATCH');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        EntityTypeUpdate.PatchEntityType();
        Test.stopTest();
        
        // System.AssertEquals(true,OppWrapperList.size()>0, 'OppWrapperList must have some value');
        
    }
    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType) {
        RestRequest req = new RestRequest();
        req.requestURI = url; 
        req.httpMethod = requestType;
        req.requestBody = Blob.valueof(requestBodyString);
        return req;
        
    }
    
    
}