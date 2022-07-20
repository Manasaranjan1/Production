@RestResource(urlMapping='/EntityTypeUpdate/*')

global with sharing class EntityTypeUpdate {
    
    @HttpPatch 
    global static void PatchEntityType(){
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        String RecordId = '';
        JSON2ApexEntityType leadinfo = new JSON2ApexEntityType();
        //Lead objLead = new Lead();
        //Opportunity objOpportunity = new Opportunity();
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        
        try{
            leadinfo = JSON2ApexEntityType.parse(request.requestBody.toString());
            RecordId = leadinfo.LeadID;
            
            if(leadinfo.OpportunityID !=null && leadinfo.OpportunityID != '' ){
                Opportunity objOpportunity = new Opportunity(id=leadinfo.OpportunityID);
                //objOpportunity = [select Id, Entity_Type__c from Opportunity where Id=:leadinfo.OpportunityID];
                if( leadinfo.BusinessType != null && leadinfo.BusinessType != '')  
                objOpportunity.Entity_Type__c = leadinfo.BusinessType;
                
                update objOpportunity;
            }
            else if (leadinfo.LeadID !=null && leadinfo.LeadID != '' && (leadinfo.OpportunityID ==null || leadinfo.OpportunityID == '') ){
                Lead objLead = new Lead(Id=leadinfo.LeadID);
                //objLead = [select Id, Entity_Type__c from Lead where Id=:leadinfo.LeadID];
                if( leadinfo.BusinessType != null && leadinfo.BusinessType != '')  
                objLead.Entity_Type__c = leadinfo.BusinessType;
                
                update objLead;
            }
            
                jsonResponse = '{"status": true, "Leadid": "' + leadinfo.LeadID+ '","Opportunityid": "' + leadinfo.OpportunityID+ '", "errors":[]}';
                res.responseBody = blob.valueOf(jsonResponse);                
                 
                objPortalExceptionHadling.Response__c = jsonResponse;
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                //objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
                objPortalExceptionHadling.Application_Id__c = leadinfo.ApplicationID;
                objPortalExceptionHadling.Opportunity_Id__c = leadinfo.OpportunityID;
                objPortalExceptionHadling.Lead_Id__c = leadinfo.LeadID;
        }
        
        Catch(Exception ex)   
        {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex)+RecordId ;
            //objPortalExceptionHadling.Business_Id__c = leadinfo.BusinessId;
            objPortalExceptionHadling.Application_Id__c = leadinfo.ApplicationID;
            objPortalExceptionHadling.Opportunity_Id__c = leadinfo.OpportunityID;
            objPortalExceptionHadling.Lead_Id__c = leadinfo.LeadID;
        } 
        insert objPortalExceptionHadling;
        return;
        
    }

}