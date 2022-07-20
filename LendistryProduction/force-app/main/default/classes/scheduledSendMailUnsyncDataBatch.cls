global class scheduledSendMailUnsyncDataBatch  implements Schedulable {
   global void execute(SchedulableContext sc) {
     
     String condition = 'IsSyncWithPortal__c=false AND IS_Batch_Picked__c=true AND Business_ID_SBAPPP__c=null AND Application_ID_SBAPPP__c=null';
     String query ='select id,Zip_Code_Owner_1__c,Postalcode,Owner_ID_Owner_1__c,name,Business_ID_SBAPPP__c,Is_Batch_Picked__c,IsSyncWithPortal__c,Business_EIN__c,Application_ID_SBAPPP__c,Loan_Type__c from Lead where ' + condition +  ' AND Status!=\'Unqualified\' AND Loan_Type__c=\'SBA-PPP\'';
     SendMailUnsyncDataBatch  sch = new SendMailUnsyncDataBatch(query ); 
     database.executebatch(sch,2000);
   }
}