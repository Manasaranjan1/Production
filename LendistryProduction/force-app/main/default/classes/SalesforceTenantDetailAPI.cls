@RestResource(urlMapping='/SalesforceTenantDetailAPI/*')

global with sharing class SalesforceTenantDetailAPI{
    @HttpPatch
    global static String PatchTenantDetail() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        responseWrapper objResponseWrap = new responseWrapper();
        JSON2ApexTenantDetails objJSONinfo = new JSON2ApexTenantDetails();       
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
       
        try{
            system.debug('(request.requestBody.toString()--->'+request.requestBody.toString());
            
            objJSONinfo = JSON2ApexTenantDetails.parse(request.requestBody.toString());
            if(objJSONinfo !=null && objJSONinfo.Tenant_ID!=null ){
                  Tenant_Details__c objTenantDetail = new Tenant_Details__c();
                  objTenantDetail.Tenant_ID__c = objJSONinfo.Tenant_ID;
                  objTenantDetail.Tenant_Name__c =objJSONinfo.Tenant_Name;
                  objTenantDetail.Tenant_URL__c =objJSONinfo.Tenant_URL;
                  objTenantDetail.Referral_Partner__c =objJSONinfo.Referral_Partner; 
                  
                  Schema.SObjectField ftoken = Tenant_Details__c.Fields.Tenant_ID__c ;
                  Database.UpsertResult sr = Database.upsert(objTenantDetail,ftoken,false);
               // insert error logs here
                objPortalExceptionHadling.Response__c = string.valueof(objJSONinfo);
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                objPortalExceptionHadling.Tenant_Details__c = objTenantDetail.Id;
                // set response wrapper
                objResponseWrap.TenantId =   objJSONinfo.Tenant_ID; 
                objResponseWrap.TenantrecordId =   sr.Id;                
            }            
        } Catch(Exception ex){
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            //objPortalExceptionHadling.Tenant_Details__c = objTenantDetail.Id;        
           
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