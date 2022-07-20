@RestResource(urlMapping='/SalesforceProductAPI/*')

global with sharing class SalesforceProductAPI{
    @HttpPost
    global static String postProductdetail() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        Product__c objProduct;
        responseWrapper objResponseWrap = new responseWrapper();
        JSON2ApexProductDetails  objJSONinfo = new JSON2ApexProductDetails();       
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
       
       try{
            system.debug('(request.requestBody.toString()--->'+request.requestBody.toString());
            
            objJSONinfo = JSON2ApexProductDetails.parse(request.requestBody.toString());
            if(objJSONinfo !=null && objJSONinfo.ProductName!=null ){
                if(objJSONinfo.ProductRecordId!=null && objJSONinfo.ProductRecordId!='')
                    objProduct = new Product__c(id=objJSONinfo.ProductRecordId);
                else
                     objProduct = new Product__c();
                 objProduct.Name = objJSONinfo.ProductName;
                 objProduct.Business_Type__c = objJSONinfo.BusinessType;
                 objProduct.Product_Id__c = objJSONinfo.ProductId;
                 objProduct.Business_Category__c =objJSONinfo.BusinessCategory;
                 objProduct.Is_Grant__c=objJSONinfo.IsGrant;
                 if(objJSONinfo.TenantId!=null){
                    String tenantId = [select id from Tenant_Details__c where Tenant_ID__c=:objJSONinfo.TenantId].Id;
                    objProduct.Tenant__c = tenantId;
                 }
               upsert  objProduct;  
               
               // insert error logs here
                objPortalExceptionHadling.Response__c = string.valueof(objJSONinfo);
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                objPortalExceptionHadling.Product__c= objProduct.Id;
                // set response wrapper
                return objProduct.Id;               
            }            
        } Catch(Exception ex){
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            //objPortalExceptionHadling.Product__c= sr.Id;        
           
        }
        insert objPortalExceptionHadling;
       return  JSON.serialize(objResponseWrap);
    }
    
    // response wrapper
    public class responseWrapper{
        public Integer TenantId;
        public String TenantrecordId;
    }
    
}