@isTest(seeAlldata=true)
public class SalesforceTenantDetailAPI_Test {
    public static testMethod void method2(){
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        Tenant_Details__c tenantobj = new Tenant_Details__c();
        tenantobj.Referral_Partner__c = 'test';
        tenantobj.Tenant_ID__c = 98;
        tenantobj.Tenant_Name__c = 'testname';
        tenantobj.Tenant_URL__c = 'testurl1';
        insert tenantobj;
        
        String requestBodyString = '{"Tenant_ID":7,"Referral_Partner":"testreferral","Tenant_Name":"Testname","Tenant_URL":"Testurl","Tenant_recordId":null}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceTenantDetailAPI/*','PATCH');
        RestContext.response = new RestResponse();
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceTenantDetailAPI/*','PATCH');
        RestContext.response = new RestResponse(); 
        Test.startTest();
        SalesforceTenantDetailAPI.PatchTenantDetail();
        
        Test.stopTest();
        
        JSON2ApexTenantDetails objwrap = new JSON2ApexTenantDetails();
        
        objwrap.Tenant_ID = 7;
        objwrap.Referral_Partner = 'testreferral';
        objwrap.Tenant_Name = 'testname';
        objwrap.Tenant_recordId = '';
        objwrap.Tenant_URL = 'testurl';
    }
    public static testMethod void method(){
        String requestBodyString = '{"Tenant_ID":7896541,"Referral_Partner":"","Tenant_Name":"","Tenant_URL":"Testurl","Tenant_recordId":null}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceTenantDetailAPI/*','PATCH');
        RestContext.response = new RestResponse(); 
        
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceTenantDetailAPI/*','PATCH');
        RestContext.response = new RestResponse();  
        Test.startTest();
        SalesforceTenantDetailAPI.PatchTenantDetail();
        
        Test.stopTest();
    }
    public static testMethod void method3(){
   
        String requestBodyString = '{"Tenant_ID":7,"Referral_Partner":"","Tenant_Name":"","Tenant_URL":"Testurl","Tenant_recordId":"jikk"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceTenantDetailAPI/*','PATCH');
        RestContext.response = new RestResponse(); 
        
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceTenantDetailAPI/*','PATCH');
        RestContext.response = new RestResponse();  
        Test.startTest();
         try{
        SalesforceTenantDetailAPI.PatchTenantDetail();
        }catch(Exception ex){}
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
        res.statusCode = 200;
        //res.responseURI = url; 
        // res.httpMethod = responseType;
        res.responseBody = Blob.valueof(responseBodyString);
        return res;
    }
    
}