@isTest
public class UnderwriterUpdate_Test{
   @isTest
    public static void method1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Opportunity objOpp = new Opportunity();
        objOpp.name='test name';
        objOpp.StageName='New';
        objOpp.closeDate  = Date.today();
        insert objOpp;
        
        ID userid = UserInfo.getUserId();  
        String requestBodyString = '{"ApplicationID":"DIR12345","OpportunityID":"'+objOpp.Id+'","BusinessID":"1234","Underwriter":"'+userid+'"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/UnderwriterUpdate/*','PATCH');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        UnderwriterUpdate.UpdateUnderwriter();
        Test.stopTest();
    }
    
    @isTest
    public static void method2(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Opportunity objOpp = new Opportunity();
        objOpp.name='test name';
        objOpp.StageName='New';
        objOpp.closeDate  = Date.today();
        insert objOpp;
        
        String requestBodyString = '{"OpportunityID":"'+objOpp.Id+'","BusinessID":"1234"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/UnderwriterUpdate/*','PATCH');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        UnderwriterUpdate.UpdateUnderwriter();
        Test.stopTest();
    }
    
     @isTest
    public static void method3(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Opportunity objOpp = new Opportunity();
        objOpp.name='test name';
        objOpp.StageName='New';
        objOpp.closeDate  = Date.today();
        insert objOpp;
        
        String requestBodyString = '{"ApplicationID":"DIR12345","OpportunityID":"","BusinessID":"1234"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/UnderwriterUpdate/*','PATCH');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        UnderwriterUpdate.UpdateUnderwriter();
        
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