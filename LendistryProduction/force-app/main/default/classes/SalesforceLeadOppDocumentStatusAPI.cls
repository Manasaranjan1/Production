@RestResource(urlMapping = '/SalesforceLeadOppDocumentStatusAPI/*')

global with sharing class SalesforceLeadOppDocumentStatusAPI {
    
    @HttpPost
    global static void updateLeadOpportuntyDocumentStatus() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        //String leadId = request.params.get('id'); comment by saurabh
        String jsonResponse = '';
        set < string > setofOpp = new set < string > ();
        Opportunity objOpp = new Opportunity();
        Lead objLead = new lead();
        list < Opportunity > lstNewUpdatedOpp = new list < Opportunity > ();
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        try {
            JSON2ApexLeadOpportunityDocument ObjJSON= JSON2ApexLeadOpportunityDocument.parse(request.requestBody.toString());
            if (ObjJSON != null && ObjJSON.OpportunityID != null && ObjJSON.OpportunityID != '') {
                objOpp = new Opportunity(Id = ObjJSON.OpportunityID);
                if (objOpp != null && ObjJSON.DocumentPercentage!= null)
                    objOpp.Of_Documents__c= Integer.valueof(ObjJSON.DocumentPercentage); 
                update objOpp; 
            }
            if (ObjJSON != null && ObjJSON.LeadID!= null && ObjJSON.LeadID!= '' && ( ObjJSON.OpportunityID == null || ObjJSON.OpportunityID == '' )) {
                objLead = new Lead(Id = ObjJSON.LeadID);
                if (objOpp != null && ObjJSON.DocumentPercentage!= null)
                    objLead.Of_Documents__c= Integer.valueof(ObjJSON.DocumentPercentage); 
                update objLead;
            }
            
            jsonResponse = '{"status": true, "OpportunityID": "' + ObjJSON.OpportunityID + '", "LeadId": "' + ObjJSON.LeadId+ '", "errors":[]}';
            res.responseBody = blob.valueOf(jsonResponse);
            objPortalExceptionHadling.Response__c = string.valueof(objOpp);
            objPortalExceptionHadling.Success_Error_Code__c = '200';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = null;
            //return objmainWrapper;
        }
        Catch(Exception ex) {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse);
        
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = 'test'; //request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);
        }
        insert objPortalExceptionHadling;
        //return jsonResponse;
    }
}