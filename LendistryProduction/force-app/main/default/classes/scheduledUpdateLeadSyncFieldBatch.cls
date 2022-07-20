/**
 * @File Name          : scheduledUpdateLeadSyncFieldBatch.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 4/24/2020, 12:41:51 PM
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    4/24/2020   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
global class scheduledUpdateLeadSyncFieldBatch implements Schedulable {
   global void execute(SchedulableContext sc) {
     
      String  strbatchsize = BatchConfigurationData__c.getValues('Batch Time').Batch_Size__c;
      String loanType='SBA-PPP';
      String condition = System.Label.BatchWhereQueryCondition;
      
      String query ='select id,RecordTypeId,name,PortalAPIEndPoint__c,IsSyncWithPortal__c,Business_EIN__c,Loan_Type__c from Lead where ' + condition +  ' AND Status!=\'Unqualified\' AND Loan_Type__c=\'SBA-PPP\' limit '+strbatchsize;
     system.debug('query---------->>'+query);
     
      UpdateLeadSyncFieldBatch sch = new UpdateLeadSyncFieldBatch(query ); 
      database.executebatch(sch);
   }
}