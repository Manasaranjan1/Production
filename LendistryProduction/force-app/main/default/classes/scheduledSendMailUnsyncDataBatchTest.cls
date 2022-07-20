@isTest
    public class scheduledSendMailUnsyncDataBatchTest{
        public static testMethod void method1(){
            Test.startTest();
                Lead objLead = new Lead();  
                objLead.recordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get('SBA_PPP').getRecordTypeId();          
                objLead.LastName ='Name';
                objLead.Company = 'test ';
                objLead.Loan_Type__c ='SBA-PPP';
                objLead.Business_EIN__c ='12445';
                objLead.IS_Batch_Picked__c = true;
                objLead.Loan_Type__c = 'SBA-PPP';
                objLead.Status = 'new';
                insert objLead;
                scheduledSendMailUnsyncDataBatch abs= new scheduledSendMailUnsyncDataBatch();
                String cronExpr = '0 0 23 * * ?';
                String jobId = System.schedule('myJobTestJobName', cronExpr, abs);
                abs.execute(null);
            Test.stopTest();    
        }
        
    }