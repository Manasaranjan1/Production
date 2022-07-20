global class Batch_IntegrationLog implements Database.Batchable<sObject>,Database.stateful{
    global Map<String, Portal_Integration_Response_Code__c> mapOfPortalCode = new Map<String, Portal_Integration_Response_Code__c>();
    //start
    global Database.QueryLocator start(Database.BatchableContext BC){
        Integer customLabelValue = Integer.valueOf(System.Label.BigObjectBatchSize);
        String query = 'Select API_Name__c, Application_ID__c, Business_Id__c, Credit_Report_ID__c, exception__c, IsSyncWithPortal__c, Lead_Id__c, Method_Name__c, Opportunity_Id__c, Primary_Owner_Id__c, Product__c, Request__c, Response__c, Success_Error_Code__c, Tenant_Details__c,CreatedDate from Portal_Integration_Response_Code__c limit '+customLabelValue ;
        system.debug('customLabelValuecustomLabelValue '+query  );
        return Database.getQueryLocator(query);
    }
    //execute
    global void execute(Database.BatchableContext BC, List<Portal_Integration_Response_Code__c> scope){
        list<Integration_Log__b> BigO = new list<Integration_Log__b>();
        if(scope !=null && scope.size()>0){
            for(Portal_Integration_Response_Code__c pai : scope){
               
                Integration_Log__b BigO1 = new Integration_Log__b();
                if(pai.API_Name__c != null && pai.API_Name__c != '')
                    BigO1.API_Name__c= pai.API_Name__c;
                if((pai.Application_ID__c == null && pai.Application_ID__c == '') && (pai.Lead_Id__c !=null && pai.Lead_Id__c!='')){
                    BigO1.Application_ID_Email__c  = pai.Lead_Id__c;
                    BigO1.SObject_RecordID__c=  pai.Lead_Id__c  ;
                 }
                else{
                    BigO1.Application_ID_Email__c  = pai.Application_ID__c;
                    BigO1.SObject_RecordID__c      = pai.Lead_Id__c  ;
                }   
                if(pai.Business_Id__c != null && pai.Business_Id__c != '')
                    BigO1.Business_Id__c = pai.Business_Id__c;
                if(pai.Credit_Report_ID__c != null && pai.Credit_Report_ID__c != '')
                    BigO1.Credit_Report_ID__c = pai.Credit_Report_ID__c;
                if(pai.exception__c != null && pai.exception__c != '')
                    BigO1.exception__c = pai.exception__c;
                if(pai.IsSyncWithPortal__c != null)
                    BigO1.IsSyncWithPortal__c = String.valueOf(pai.IsSyncWithPortal__c);
                if(pai.Lead_Id__c != null && pai.Lead_Id__c != '')
                    BigO1.Lead_Id__c = pai.Lead_Id__c;
                BigO1.Custom_Created_Date__c = pai.CreatedDate;
                if(pai.Method_Name__c != null && pai.Method_Name__c != '')
                    BigO1.Method_Name__c = pai.Method_Name__c;
                if(pai.Opportunity_Id__c != null && pai.Opportunity_Id__c != '')
                    BigO1.Opportunity_Id__c = pai.Opportunity_Id__c;
                if(pai.Primary_Owner_Id__c != null && pai.Primary_Owner_Id__c != '')
                    BigO1.Primary_Owner_Id__c = pai.Primary_Owner_Id__c;
                if(pai.Product__c != null && pai.Product__c != '')
                    BigO1.Product__c = pai.Product__c;
                if(pai.Request__c != null && pai.Request__c != '')
                    BigO1.Request__c = pai.Request__c;
                if(pai.Response__c != null && pai.Response__c != '')
                    BigO1.Response__c = pai.Response__c;
                if(pai.Success_Error_Code__c != null && pai.Success_Error_Code__c != '')
                    BigO1.Success_Error_Code__c = pai.Success_Error_Code__c;
                if(pai.Tenant_Details__c != null )
                    BigO1.Tenant_Details__c = pai.Tenant_Details__c;
                System.debug('BigO1----->'+BigO1);
                BigO.add(BigO1);
                System.debug('BigO----->'+BigO);
                mapOfPortalCode.put(pai.Id, pai);
            }
        }
        if(BigO !=null && BigO.size()>0 && !Test.isRunningTest())
        {
            System.enqueueJob(new sendlistOFIntegrationLOgs (BigO ));  
            System.debug('BigO--2--->'+BigO);
           
        }
    }
    //finish
    global void finish(Database.BatchableContext BC) {
       if(mapOfPortalCode !=null && mapOfPortalCode.size()>0)
           delete mapOfPortalCode.values();
    }
}