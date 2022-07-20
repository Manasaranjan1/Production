global class schedulednoOfDaysFieldBatch implements Schedulable {
   global void execute(SchedulableContext sc) {
     
     Integer strbatchsize = Integer.valueOf(BatchConfigurationData__c.getValues('NoOfDaysBatchSize').Batch_Size__c);
     String condition = 'isUpdateNo_OfDays__c=false';      
     String query ='Select Id,BusinessId__c, StageName, of_Days_in_Sales_Review__c, of_Days_in_PreQual_Out__c, of_Days_in_Processing_Sub__c, of_Days_in_UW_Sub__c, of_days_in_CON_APP_OUT__c, of_Days_in_Packaging__c, of_Days_in_UW__c, of_days_in_Sub_for_Review__c, of_Days_in_Sub_for_Approval__c, of_Days_in_CL_Out__c, of_Days_in_Docs_Out__c, of_Days_in_Pending_for_Closing__c, of_days_in_Suspended__c, of_days_in_Missed_Opp__c  From Opportunity where  Stagename!=\'New\' and stageName !=\'Funded\'';
     system.debug('query---------->>'+query);//or id=\'0066w000002QGzzAAG\' or id=\'0066w000002LN7gAAG\' or id=\'0066w000002LU1lAAG\' or id=\'0066w000002LBuxAAG\' or id=\'0066w000002LTXWAA4\' or id=\'0066w000002LAhFAAW\' or id=\'0066w000002LUtvAAG\' or id=\'0066w000002LVTyAAO\' 
     UpdateoppNoOFDaysBatch  sch = new UpdateoppNoOFDaysBatch (query ); 
     if(!Test.isRunningtest()){
          Database.executebatch(sch,strbatchsize );
     }
   }
}