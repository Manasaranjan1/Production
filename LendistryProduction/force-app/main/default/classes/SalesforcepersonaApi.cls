@RestResource(urlMapping = '/SalesforcePersonaApi/*')

global with sharing class SalesforcepersonaApi{


    @HttpPost
    global static void updatepersona() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        list<Lead_Questions__c> lstOfQuestions = new list<Lead_Questions__c>();
        String jsonResponse = '';
        JSON2Apexpersona objepersonaStatusLead = JSON2Apexpersona.parse(request.requestBody.toString());
        system.debug('+++Request body+++' + request.requestBody.toString());
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
         Opportunity objOpp = new Opportunity();
         Lead objLead = new Lead();
        try {
          
            
            system.debug('---objepersonaStatusLead --->>'+objepersonaStatusLead );
            if (objepersonaStatusLead != null && objepersonaStatusLead.LeadId != null && objepersonaStatusLead.LeadId != '' ) {
               
                   objLead = [ Select Id,ConvertedOpportunityId, IsConverted from Lead Where id=:objepersonaStatusLead.LeadId ];
                   if( objLead != null && objLead.IsConverted ==false )
                   {
                       objLead.persona__c = objepersonaStatusLead.personaStatus;
                       
                        update objLead ;
                 }
                 if( objLead.ConvertedOpportunityId != null && objLead.IsConverted ==True)
                 {
                      objOpp = new Opportunity(id=objLead.ConvertedOpportunityId );
                      objOpp.persona__c = objepersonaStatusLead.personaStatus;
                      
                      update objOpp;
                 }
            }

            
           
            
            jsonResponse = '{"status": true, "LeadID": "' + objepersonaStatusLead.LeadId + '", "errors":[]}';
            res.responseBody = blob.valueOf(jsonResponse);
            objPortalExceptionHadling.Response__c = string.valueof(jsonResponse);
            objPortalExceptionHadling.Success_Error_Code__c = '200';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            if(objLead.ConvertedOpportunityId != null && objLead.IsConverted ==True)
            objPortalExceptionHadling.Opportunity_Id__c = objLead.ConvertedOpportunityId;
            objPortalExceptionHadling.exception__c = null;
            //return objmainWrapper;
        }Catch(Exception ex) {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse);
            system.debug('*****Exception *******>>' + ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            if(objLead.ConvertedOpportunityId != null && objLead.IsConverted ==True)
            objPortalExceptionHadling.Opportunity_Id__c = objLead.ConvertedOpportunityId;
            
            objPortalExceptionHadling.Request__c = 'test'; //request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);

        }
        insert objPortalExceptionHadling;
        //return jsonResponse;


    }


}