public class JavaAPICallOutNoOfDays {
    
    public static void sendListOfOpportunity( set<string> setOfOppId){
        system.debug('dddddddddd'+setOfOppId);
        list<Portal_Integration_Response_Code__c > lstOfExceptions = new list< Portal_Integration_Response_Code__c >();
        List<Opportunity> updateOppList = new List<Opportunity>();                     
        list<JSON2ApexListOfOpportunityResponse > ListresponseData = new list<JSON2ApexListOfOpportunityResponse >();
        MainWrapper objWrapper = new  MainWrapper();
        List<noOfDaysWrapper>  listOfDaysWrapper = new List<noOfDaysWrapper>();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        string endPointURL = System.Label.JavaPortalEndPointUrl;
        req.setEndpoint(endPointURL);
        string userName =  System.Label.JavaPortalUserName;
        string password = System.Label.JavaPortalPassword;
        req.setBody('{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}');
        string strReqBody = '{"username": "'+ System.Label.JavaPortalUserName+'","secure": "'+ System.Label.JavaPortalPassword+'"}';
        string accessToken = '';
        Http http = new Http();
        HTTPResponse response = new HttpResponse();
        response = http.send(req);
         
        
        
         if (response.getStatusCode() == 200 ) {
            JSONParser parser = JSON.createParser(response.getBody()); 
            while(parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='accessToken' ) && !Test.isRunningtest()){
                    parser.nextToken();
                    accessToken= parser.getText();
                }
                if(Test.isRunningtest())
                    accessToken='test';
                
            }
        }
        Portal_Integration_Response_Code__c  Portalobj = new  Portal_Integration_Response_Code__c ();
        Portalobj.Request__c = strReqBody;
        Portalobj.Response__c = response.getBody();
        Portalobj.Success_Error_Code__c = String.valueOf(response.getStatusCode());
        lstOfExceptions.add(Portalobj);
        // get all opportunities
        List<Opportunity> listOfOpportunity  =[Select Id,BusinessId__c, StageName, of_Days_in_Sales_Review__c, 
                                                of_Days_in_PreQual_Out__c, of_Days_in_Processing_Sub__c, of_Days_in_UW_Sub__c, 
                                                of_days_in_CON_APP_OUT__c, of_Days_in_Packaging__c, of_Days_in_UW__c, of_days_in_Sub_for_Review__c, 
                                                of_Days_in_Sub_for_Approval__c, of_Days_in_CL_Out__c, of_Days_in_Docs_Out__c, 
                                                of_Days_in_Pending_for_Closing__c, of_days_in_Suspended__c, of_days_in_Missed_Opp__c  
                                                From Opportunity where id in : setOfOppId];
         // create body here
         if(listOfOpportunity !=null && listOfOpportunity.size()>0){
             for(Opportunity eachOpp : listOfOpportunity){            
                 noOfDaysWrapper obj = new noOfDaysWrapper();
                 obj.opportunityId = eachOpp.id;
                 obj.businessId = eachOpp.BusinessId__c;                 
                 obj.stageName = eachOpp.stageName;
                 
                 if( eachOpp.stageName == 'Sales Review'){           
                     obj.daysInStage= eachOpp.of_Days_in_Sales_Review__c;                  
                 }
                 
                 if( eachOpp.stageName == 'PreQual Out'){                  
                     obj.daysInStage= eachOpp.of_Days_in_PreQual_Out__c;                   
                 }
                 if( eachOpp.stageName == 'Processing Sub'){                   
                     obj.daysInStage= eachOpp.of_Days_in_Processing_Sub__c;
                 }
                 if( eachOpp.stageName == 'UW Sub'){
                    obj.daysInStage= eachOpp.of_Days_in_UW_Sub__c;                   
                 }
                 if( eachOpp.stageName == 'CON APP OUT'){                  
                     obj.daysInStage= eachOpp.of_days_in_CON_APP_OUT__c;
                 }
                 if( eachOpp.stageName == 'Packaging'){                   
                     obj.daysInStage= eachOpp.of_Days_in_Packaging__c;                 
                 }
                 if( eachOpp.stageName== 'UW'){
                    obj.daysInStage= eachOpp.of_Days_in_UW__c;                  
                 }                    
                 if(eachOpp.stageName == 'Sub for Review'){
                    obj.daysInStage= eachOpp.of_days_in_Sub_for_Review__c;              
                 }
                 if( eachOpp.stageName == 'Sub for Approval'){
                      obj.daysInStage= eachOpp.of_Days_in_Sub_for_Approval__c;                  
                 }
                 if( eachOpp.stageName == 'CL Out'){
                     obj.daysInStage= eachOpp.of_Days_in_CL_Out__c;
                 }
                 if( eachOpp.stageName == 'Docs Out'){                   
                     obj.daysInStage= eachOpp.of_Days_in_Docs_Out__c;               
                 }
                 if( eachOpp.stageName== 'Pending for Closing'){                   
                    obj.daysInStage= eachOpp.of_Days_in_Pending_for_Closing__c;               
                 }
                 if( eachOpp.stageName == 'Suspended'){                   
                     obj.daysInStage= eachOpp.of_days_in_Suspended__c;                
                  }
                  if(eachOpp.stageName == 'Missed Opp'){                   
                     obj.daysInStage= eachOpp.of_days_in_Missed_Opp__c  ;                    
                  }
                 
                  /*if( mapOfOpp.get(eachOpp.Id) == 'Funded'){                   
                    obj.daysInStage= eachOpp.of_Days_in_Sales_Review__c;                   
                  }*/
                  objWrapper.listOfData.add( obj);
         }
        system.debug('Rewuesttttt'+JSON.serialize(objWrapper));
           if( accessToken != null && accessToken != '' ){
                Http http1 = new Http();
                HttpRequest request1 = new HttpRequest();
                request1.setHeader('Authorization', accessToken);
                request1.setHeader('Content-Type', 'application/json');
                string endPointURL1 = System.Label.JavaPortalLeadApiNoOfDays;
                request1.setEndpoint(endPointURL1);
                request1.setTimeout(120000);
                request1.setMethod('POST');  
                request1.setBody( JSON.serialize(objWrapper) );
                HttpResponse response1 = http1.send(request1);
                
                Portal_Integration_Response_Code__c  Portalobj1 = new  Portal_Integration_Response_Code__c ();
                Portalobj1.Request__c = JSON.serialize(string.valueof(setOfOppId));  
                Portalobj1.Response__c = response1.getBody();
                Portalobj1.Success_Error_Code__c = String.valueOf(response1.getStatusCode());
                lstOfExceptions.add(Portalobj1);
                if (response1.getStatusCode() != 201 ) {
                    system.debug('response1.getBody()response1.getBody()'+response1.getBody());
                    
                    if(!Test.isRunningTest())
                        ListresponseData = JSON2ApexListOfOpportunityResponse.parse(response1.getBody());
                    
                      system.debug('ListresponseDataListresponseData '+ListresponseData ); 
                     if( ListresponseData != null && ListresponseData.size() > 0){
                         for(JSON2ApexListOfOpportunityResponse  eachRes  : ListresponseData ){
                             system.debug('counterr'+eachRes);
                              if(eachRes.opportunityId!= '' && eachRes.isUpdated){
                                  Opportunity objOpp = new Opportunity(id=eachRes.opportunityId);
                                  objOpp.isUpdateNo_OfDays__c = eachRes.isUpdated;
                                  updateOppList.add(objOpp);
                              }
                              // create error record here 
                               Portal_Integration_Response_Code__c  objPortalError = new  Portal_Integration_Response_Code__c ();
                               objPortalError.Opportunity_Id__c = eachRes.opportunityId;
                               objPortalError.Business_Id__c =eachRes.businessId;
                               lstOfExceptions.add(objPortalError);
                               
                         }
                      }                  
                }     
           }  
             
        } 
           if((updateOppList !=null && updateOppList .size()>0) )
             update updateOppList;         
           if(lstOfExceptions!=null && lstOfExceptions.size()>0)
             insert lstOfExceptions;            
    }
    
    
    
    // main wrapper
    public class MainWrapper{
        public List<noOfDaysWrapper> listOfData;
        public MainWrapper(){
            listOfData = new List<noOfDaysWrapper>();
        }
    }
    public class noOfDaysWrapper{
        public string opportunityId;
        public string businessId;
        public string stageName;
        public Decimal daysInStage;
    }
 }