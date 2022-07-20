@RestResource(urlMapping='/SalesforceScorecardAPI/*')

global with sharing class SalesforceScorecardAPI{
    @HttpPatch 
    global static void PatchLeadData() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        JSON2ApexScoreCard  objJSONinfo = new JSON2ApexScoreCard ();
        list<ScoreCard__c> lstOfScoreCards = new list<ScoreCard__c>();
        list<Lead> lstlead = new list<lead> ();
        list<Opportunity> lstOpportunity = new list<Opportunity>();
        system.debug('+++Request body+++'+request.requestBody.toString());
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        try{
            system.debug('(request.requestBody.toString()--->'+request.requestBody.toString());
            
            objJSONinfo = JSON2ApexScoreCard.parse(request.requestBody.toString());
            if(objJSONinfo.LeadId !=null && objJSONinfo.LeadId != '' || ( objJSONinfo.opportunityId !=null || objJSONinfo.opportunityId !='') ){
                ScoreCard__c objScorecard = new ScoreCard__c();
                Lead objLead = new Lead();
                Opportunity objOpportunity = new Opportunity();
                if( objJSONinfo.LeadId != null ){
                    objScorecard.Lead__c =objJSONinfo.LeadId;
                }
                    
                if( objJSONinfo.LeadId != null && ( objJSONinfo.opportunityId ==null || objJSONinfo.opportunityId==''))
                    objScorecard.External_ID__c = objJSONinfo.LeadId;
                if( objJSONinfo.LeadId != null && ( objJSONinfo.opportunityId !=null && objJSONinfo.opportunityId !=''))
                {
                    objScorecard.External_ID__c =objJSONinfo.opportunityId;
                    objScorecard.Opportunity__c =objJSONinfo.opportunityId;
                    objScorecard.Lead__c =objJSONinfo.LeadId;
                }
                // check Score field values to be update
                if(objJSONinfo .Industry_retail_food_health_care_hai !=null)
                    objScorecard.Industry_retail_food_health_care__c= objJSONinfo.Industry_retail_food_health_care_hai;
                
                if(objJSONinfo.U_S_CDFI_Fund_Investment_Area_OR_Low_In!=null)
                    objScorecard.U_S_CDFI_Fund_Investment_Area_OR_Low_In__c = objJSONinfo.U_S_CDFI_Fund_Investment_Area_OR_Low_In;
                
                if(objJSONinfo.Degree_to_which_the_business_was_impacte!=null)
                    objScorecard.Degree_to_which_the_business_was_impact__c = objJSONinfo.Degree_to_which_the_business_was_impacte;
                
                if(objJSONinfo.Not_Prior_Receipt!=null)
                    objScorecard.Not_Prior_Receipt__c = objJSONinfo.Not_Prior_Receipt;
                
                if(objJSONinfo.Business_operates_in_a_designated!=null)
                    objScorecard.Business_operates_in_a_designated__c = objJSONinfo.Business_operates_in_a_designated;
                
                if(objJSONinfo.From_a_rural_county!=null)
                    objScorecard.From_a_rural_county__c = objJSONinfo.From_a_rural_county;
                
                if(objJSONinfo.County_Population_Loss!=null)
                    objScorecard.County_Population_Loss__c = objJSONinfo.County_Population_Loss;
                
                if(objJSONinfo.Woman_Owned!=null)
                    objScorecard.Woman_Owned__c = objJSONinfo.Woman_Owned;
                
                if(objJSONinfo.Low_Income_Owner!=null)
                    objScorecard.Low_Income_Owner__c = objJSONinfo.Low_Income_Owner;
                
                if(objJSONinfo.isApproved!=null)
                    objScorecard.isApproved__c = objJSONinfo.isApproved;
                if(objJSONinfo.Is_Owned_By_Woman_Veteran_Disabled_Approved_Score!=null)
                   objScorecard.Is_Owned_By_Woman_Veteran_Disabled_Appro__c = objJSONinfo.Is_Owned_By_Woman_Veteran_Disabled_Approved_Score;
                    
                if(objJSONinfo.Low_Mod_Borough_Approved_Score !=null)
                    objScorecard.York_County_designated_Low_mod_borough__c = objJSONinfo.Low_Mod_Borough_Approved_Score; 
                
                if(objJSONinfo.TotalScoreValue !=null ) {
                    objScorecard.Total_Score__c = objJSONinfo.TotalScoreValue;
                    if( objJSONinfo.LeadId != null && ( objJSONinfo.opportunityId ==null || objJSONinfo.opportunityId=='')){
                        objLead.Id = objJSONinfo.LeadId;
                        objLead.Total_Score__c = objJSONinfo.TotalScoreValue;
                        lstlead.add(objLead);
                    }
                    else if (objJSONinfo.LeadId != null && ( objJSONinfo.opportunityId !=null && objJSONinfo.opportunityId !='')){
                        objOpportunity.Id = objJSONinfo.opportunityId;
                        ObjOpportunity.Total_Score__c = objJSONinfo.TotalScoreValue;
                        lstOpportunity.add(objOpportunity);
                    }
                }
                    
                    
                if(objJSONinfo.NP_Low_Mod_Approved_Score!=null)
                    objScorecard.NP_Low_Mod_Approved_Score__c = objJSONinfo.NP_Low_Mod_Approved_Score; 
                    
                if(objJSONinfo.NP_Industry_Approved_Score!=null)
                    objScorecard.NP_Industry_Approved_Score__c = objJSONinfo.NP_Industry_Approved_Score; 
                    
                if(objJSONinfo.NP_Serves_Person_of_Color_Approved_Score!=null)
                    objScorecard.NP_Serves_Person_of_Color_Approved_Score__c= objJSONinfo.NP_Serves_Person_of_Color_Approved_Score; 
                
                if(objJSONinfo.Person_of_Color_Approved_Score!=null)
                    objScorecard.Person_of_Color_Approved_Score__c = objJSONinfo.Person_of_Color_Approved_Score;
                /*if(objJSONinfo.Not_In_Urbanized_Area_Or_Urbanized_Cluster_Approved_Score!=null)
                    objScorecard.Low_To_Moderate_Income_Area_Approved_Sco__c = objJSONinfo.Low_To_Moderate_Income_Area_Approved_Score;
                if(objJSONinfo.Low_To_Moderate_Income_Area_Approved_Score!=null)
                    objScorecard.Not_In_Urbanized_Area_Or_Urbanized_Clust__c = objJSONinfo.Not_In_Urbanized_Area_Or_Urbanized_Cluster_Approved_Score;*/
               
                if(objJSONinfo.Low_To_Moderate_Income_Area_Approved_Score !=null)
                    objScorecard.Low_To_Moderate_Income_Area_Approved_Sco__c = objJSONinfo.Low_To_Moderate_Income_Area_Approved_Score;
                if(objJSONinfo.Not_In_Urbanized_Area_Or_Urbanized_Cluster_Approved_Score !=null)
                    objScorecard.Not_In_Urbanized_Area_Or_Urbanized_Clust__c = objJSONinfo.Not_In_Urbanized_Area_Or_Urbanized_Cluster_Approved_Score;
               
                lstOfScoreCards.add(objScorecard);
                
                
                if( lstOfScoreCards != null && lstOfScoreCards.size() > 0 )
                {
                    Schema.SObjectField ftoken = ScoreCard__c.Fields.External_ID__c;
                    Database.UpsertResult[] srList = Database.upsert(lstOfScoreCards,ftoken,false);   
                }
                if(lstlead != null && lstlead.size() > 0){
                    Update lstlead;
                }
                if(lstOpportunity != null && lstOpportunity.size() > 0){
                    Update lstOpportunity;
                }
                
                
                jsonResponse = '{"status": true, "LeadId": "' + objJSONinfo.LeadId+ '", "errors":[]}';
                res.responseBody = blob.valueOf(jsonResponse);  
                objPortalExceptionHadling.Response__c = string.valueof(objJSONinfo);
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                objPortalExceptionHadling.Lead_Id__c = objJSONinfo.LeadId;                     
            }
            
            
            
            
        } Catch(Exception ex){
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.Business_Id__c = objJSONinfo.BusinessId;
            objPortalExceptionHadling.Application_Id__c = objJSONinfo.application_id;
            if(objJSONinfo.opportunityId!=null && objJSONinfo.opportunityId!='')
                objPortalExceptionHadling.Opportunity_Id__c = objJSONinfo.opportunityId;
            if(objJSONinfo.LeadId !=null && objJSONinfo.LeadId !='')
                objPortalExceptionHadling.Lead_Id__c = objJSONinfo.LeadId;
        } 
        insert objPortalExceptionHadling;
        return;
    }
}