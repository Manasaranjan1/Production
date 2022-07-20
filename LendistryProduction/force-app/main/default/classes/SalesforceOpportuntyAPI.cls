@RestResource(urlMapping='/SalesforceOpportuntyAPI/*')

global with sharing class SalesforceOpportuntyAPI{
    
    @HttpPost 
    global static list<wrapper> getStageDaysOnOpportunity() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String leadId = request.params.get('id');
        String jsonResponse = '';
        map<string, string> mapOfOpp = new map<string, string>();
        list<wrapper>  lstOfwrapper = new list<wrapper>();
        list<Opportunity> lstOpp = new list<Opportunity>();
        list<Opportunity> lstCallBackOpp = new list<Opportunity>();
       // system.debug('+++Request body+++'+request.requestBody.toString());
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        try
        {
            system.debug('++Enter try++'+leadId);
             system.debug('++request.requestBody++'+request.requestBody);
            List<JSON2ApexOpp> JsonlstOpp= JSON2ApexOpp.parse(request.requestBody.toString());
            if( JsonlstOpp != null && JsonlstOpp.size() > 0)
            {
                for(JSON2ApexOpp each :  JsonlstOpp)
                mapOfOpp.put(each.Opportunity_Id, each.StageName);
            }
            system.debug('-----mapOfOpp----->'+mapOfOpp);
            
            if(mapOfOpp !=null  ){
                lstOpp = [ Select Id,BusinessId__c, StageName, of_Days_in_Sales_Review__c, of_Days_in_PreQual_Out__c, of_Days_in_Processing_Sub__c, of_Days_in_UW_Sub__c, of_days_in_CON_APP_OUT__c, of_Days_in_Packaging__c, of_Days_in_UW__c, of_days_in_Sub_for_Review__c, of_Days_in_Sub_for_Approval__c, of_Days_in_CL_Out__c, of_Days_in_Docs_Out__c, of_Days_in_Pending_for_Closing__c, of_days_in_Suspended__c, of_days_in_Missed_Opp__c  From Opportunity Where Id IN:mapOfOpp.KeySet()];
                
                if(lstOpp != null && lstOpp.size() > 0 )
                {
                   for(Opportunity eachOpp :  lstOpp )
                   {
                   string opptstst = mapOfOpp.get(string.valueof(eachOpp.Id));
                   system.debug('----opptstst -----'+eachOpp.Id);
                       
                       if( mapOfOpp.get(eachOpp.Id) == 'Sales Review')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_Sales_Review__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'PreQual Out')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_PreQual_Out__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'Processing Sub')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_Processing_Sub__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'UW Sub')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_UW_Sub__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'CON APP OUT')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_days_in_CON_APP_OUT__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'Packaging')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_Packaging__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'UW')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_UW__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    
                    if( mapOfOpp.get(eachOpp.Id) == 'Sub for Review')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_days_in_Sub_for_Review__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'Sub for Approval')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_Sub_for_Approval__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'CL Out')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_CL_Out__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'Docs Out')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_Docs_Out__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'Pending for Closing')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_Days_in_Pending_for_Closing__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'Suspended')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.daysinStage= eachOpp.of_days_in_Suspended__c;
                    obj.stagename = eachOpp.StageName;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'Missed Opp')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    obj.daysinStage= eachOpp.of_days_in_Missed_Opp__c  ;
                    obj.stagename = eachOpp.StageName;
                    lstOfwrapper.add( obj);
                    }
                    if( mapOfOpp.get(eachOpp.Id) == 'Funded')
                    {
                    wrapper obj = new wrapper();
                    obj.Opportunity_Id = eachOpp.id;
                    obj.Sales_Business_Id = eachOpp.BusinessId__c;
                    obj.daysinStage= eachOpp.of_Days_in_Sales_Review__c;
                    obj.stagename = eachOpp.StageName;
                    lstOfwrapper.add( obj);
                    }
                       
                       
                   }
                  ///mapOfOpp.put(each.OpportunityId, each.StageName);
                    //system.debug('-----lstOpp ----->'+lstOpp );
                jsonResponse = '{"status": true, "id": "' + mapOfOpp + '", "errors":[]}';
                res.responseBody = blob.valueOf(jsonResponse);  
                objPortalExceptionHadling.Response__c = string.valueof(lstOpp);
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                //return objmainWrapper;
                
                
            }  
            }
            
        }
        Catch(Exception ex)   
        {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = 'test';//request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);
            
        } 
        insert objPortalExceptionHadling;
        return lstOfwrapper;
        
        
    }
    
    @HttpPatch
    global static string updateSalesScreenDatatoSF() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String leadId = request.params.get('id');
        String jsonResponse = '';
        set<string> setofOpp = new set<string>();
        list<WrapSalesScreenData>  lstOfwrapper = new list<WrapSalesScreenData>();
        Opportunity objOpp = new Opportunity();
        list<Opportunity> lstNewUpdatedOpp = new list<Opportunity>();
        system.debug('+++Request body+++'+request.requestBody.toString());
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        try
        {
            system.debug('++Enter try++'+leadId);
            JSON2ApexOpp JsonlstOpp= JSON2ApexOpp.parseObj(request.requestBody.toString());
            if( JsonlstOpp != null )
            {
                system.debug('-----setofOpp----->'+setofOpp);
                objOpp = [ Select Id,BusinessId__c, Sales_Decline__c,Processing_fee__c, Origination_Fee__c,Referral_Partner_Fee__c,Loan_Type__c,Loan__c,StageName,Interest_Type__c,Referral_Source__c  From Opportunity Where Id =:JsonlstOpp.Opportunity_Id];
                
                if(objOpp != null )
                {
                   
                            if( JsonlstOpp.Sales_Business_Id == objOpp.BusinessId__c )
                            {
                              objOpp.BusinessId__c = JsonlstOpp.Sales_Business_Id;
                              objOpp.Referral_Partner_Fee__c = Decimal.valueof(JsonlstOpp.referral_part_fee);
                              objOpp.processing_fee__c = Decimal.valueof(JsonlstOpp.processing_fee);
                              objOpp.Sales_Decline__c = JsonlstOpp.sales_decline_reason;
                              objOpp.Loan_Type__c = JsonlstOpp.loan_type;
                              objOpp.Referral_Source__c = JsonlstOpp.referral_source;
                              objOpp.Interest_Type__c = JsonlstOpp.interest_type;
                            
                              lstNewUpdatedOpp.add(objOpp);   
                            }
                       }
                   }
                  ///mapOfOpp.put(each.OpportunityId, each.StageName);
                    system.debug('-----lstNewUpdatedOpp ----->'+lstNewUpdatedOpp );
                update lstNewUpdatedOpp;
                jsonResponse = '{"status": true, "Opportunity_Id": "' + JsonlstOpp.Opportunity_Id + '", "errors":[]}';
                res.responseBody = blob.valueOf(jsonResponse);  
                objPortalExceptionHadling.Response__c = string.valueof(objOpp);
                objPortalExceptionHadling.Success_Error_Code__c = '200';
                objPortalExceptionHadling.Request__c = request.requestBody.toString();
                objPortalExceptionHadling.exception__c = null;
                //return objmainWrapper;
        }
        Catch(Exception ex)   
        {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse); 
            system.debug('*****Exception *******>>'+ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = 'test';//request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);
            
        } 
        insert objPortalExceptionHadling;
        return jsonResponse;
        
        
    }
        global class wrapper
        {
         public string Opportunity_Id;
         public string Sales_Business_Id;
         public string stagename;
         public Decimal daysinStage;
        
        }
        
        global class WrapSalesScreenData {
            public String Opportunity_Id;
            public String StageName;
            public string loan_number;
            public string Sales_Business_Id;
            public string interest_type;
            public string sales_decline_reason;
            public string loan_type;
            public string processing_fee;
            public string origination_fee;
            public string referral_part_fee;
            public string referral_source;
        }
       
}