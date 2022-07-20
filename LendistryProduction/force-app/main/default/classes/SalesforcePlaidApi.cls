@RestResource(urlMapping = '/SalesforcePlaidApi/*')

global with sharing class SalesforcePlaidApi{


    @HttpPost
    global static void updatePlaid() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        list<Lead_Questions__c> lstOfQuestions = new list<Lead_Questions__c>();
        String jsonResponse = '';
       JSON2ApexPlaid objePliadLead = JSON2ApexPlaid.parse(request.requestBody.toString());
        system.debug('+++Request body+++' + request.requestBody.toString());
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
         Opportunity objOpp = new Opportunity();
         Lead objLead = new Lead();
        try {
          
            
            system.debug('---objePliadLead --->>'+objePliadLead );
            if (objePliadLead != null && objePliadLead.LeadId != null && objePliadLead.LeadId != '' ) {
               
                   objLead = [ Select Id,ConvertedOpportunityId, IsConverted from Lead Where id=:objePliadLead.LeadId ];
                   if( objLead != null && objLead.IsConverted ==false )
                   {
                       objLead.Plaid_Integration_Complete__c= objePliadLead.is_Plaid;
                       
                        update objLead ;
                 }
                 if( objLead.ConvertedOpportunityId != null && objLead.IsConverted ==True)
                 {
                      objOpp = new Opportunity(id=objLead.ConvertedOpportunityId );
                      objOpp.Plaid_Integration_Complete__c = objePliadLead.is_Plaid;
                      
                      update objOpp;
                 }
            }

            
           
            
            jsonResponse = '{"status": true, "LeadID": "' + objePliadLead.LeadId + '", "errors":[]}';
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