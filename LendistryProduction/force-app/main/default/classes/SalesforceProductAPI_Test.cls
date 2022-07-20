@isTest
public class SalesforceProductAPI_Test {
    
    public static testMethod  void method2(){
        String requestBodyString = '{"TenantId":5,"ProductId":8,"BusinessCategory":"Profit","ProductName":""}';
       // String requestBodyString = '{"TenantName":"testname","BusinessCategory":"Profit","ProductName":""}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceQuestionsApi/*','POST');
        RestContext.response = new RestResponse();
        
        Tenant_Details__c objtenant = new Tenant_Details__c();
        objtenant.Referral_Partner__c = 'testpartner';
        objtenant.Tenant_ID__c = 4;
        objtenant.Tenant_Name__c = 'testname';
        objtenant.Tenant_URL__c = 'kbjkb';
        insert objtenant;
        Test.startTest();
        try{
            SalesforceProductAPI.postProductdetail();
        }catch(exception ex){}
        Test.stopTest();
    }
    
      public static testMethod  void method1(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorQst ());
        String requestBodyString = '{"TenantName":"tgh","BusinessCategory":"Profit","ProductName":"testproduct"}';
          RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceQuestionsApi/*','POST');
        RestContext.response = new RestResponse();
        Test.startTest();
       
        SalesforceProductAPI.postProductdetail();
        
        Test.stopTest();
    }
    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType) 
    {
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
        // res.httpMethod = responseType;
        res.responseBody = Blob.valueof(responseBodyString);
        return res;
    }
}