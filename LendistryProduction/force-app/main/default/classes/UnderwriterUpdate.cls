@RestResource(urlMapping='/UnderwriterUpdate/*')

global with sharing class UnderwriterUpdate {
    @HttpPatch 
    global static void UpdateUnderwriter(){
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        JSON2ApexUnderwriterUpdate leadinfo = new JSON2ApexUnderwriterUpdate();
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        
        try{
            leadinfo = JSON2ApexUnderwriterUpdate.parse(request.requestBody.toString());
            
            if(leadinfo.OpportunityID !=null && leadinfo.OpportunityID != ''  )
            {
                User user = null;
                List<User> users = new List<User> ();
                Opportunity objOpportunity = new Opportunity(id=leadinfo.OpportunityID);
                if(leadinfo.Underwriter != null && leadinfo.Underwriter != '')
                users = [SELECT Id,name,email from user where id = :leadinfo.Underwriter LIMIT 1];
                
                if(!users.isEmpty()){
                user = users[0];
                }
                if (user != null){
                    objOpportunity.Assigned_Underwriter__c = user.id;
                    
                }
                else{
                    objOpportunity.Assigned_Underwriter__c = null;
                }
                update objOpportunity;
            }
            
            jsonResponse = '{"status": true, "Underwriter": "' + leadinfo.Underwriter+ '","Opportunityid": "' + leadinfo.OpportunityID+ '", "errors":[]}';
            res.responseBody = blob.valueOf(jsonResponse);                
            
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '200';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = null;
            objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessID;
            objPortalExceptionHadling.Application_Id__c = leadinfo.ApplicationID;
            objPortalExceptionHadling.Opportunity_Id__c = leadinfo.OpportunityID;
            //objPortalExceptionHadling.Lead_Id__c = leadinfo.LeadID;
        }
        
        Catch(Exception ex)   
        {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex) ;
            //objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessID;
            //objPortalExceptionHadling.Application_Id__c = leadinfo.ApplicationID;
            objPortalExceptionHadling.Opportunity_Id__c = leadinfo.OpportunityID;
        } 
        insert objPortalExceptionHadling;
        return;   
    }
}