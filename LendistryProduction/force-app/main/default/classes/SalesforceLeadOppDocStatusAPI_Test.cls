@isTest
public class SalesforceLeadOppDocStatusAPI_Test{
    public static testMethod void testPostCallout() {
        Test.setMock(HttpCalloutMock.class, new LeadOppDocStatusHttpCalloutMock ());
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
        
        String requestBodyString = '{"LeadId":"'+objLead.Id+'","OpportunityID":"'+objOpp.Id+'"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadOppDocumentStatusAPI/*','POST');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        SalesforceLeadOppDocumentStatusAPI.updateLeadOpportuntyDocumentStatus();
        Test.stopTest();
    }
    public static testMethod void testPostCallout2() {
        Test.setMock(HttpCalloutMock.class, new LeadOppDocStatusHttpCalloutMock ());
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
        
        String requestBodyString = '';//'{"LeadId":"'+objLead.Id+'","OpportunityID":"'+objOpp.Id+'"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceLeadOppDocumentStatusAPI/*','POST');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        SalesforceLeadOppDocumentStatusAPI.updateLeadOpportuntyDocumentStatus();
        Test.stopTest();
    }
    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType) {
        RestRequest req = new RestRequest();
        req.requestURI = url; 
        req.httpMethod = requestType;
        req.requestBody = Blob.valueof(requestBodyString);
        return req;
        
    }
}