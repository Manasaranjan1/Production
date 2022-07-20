@istest
class LeadUpdateSchedulerTest{
    public static testMethod void testschedule() {
        Test.StartTest();
        BatchConfigurationData__c setting = new BatchConfigurationData__c();
        setting.Name = 'Batch Time';
        setting.Batch_Size__c= '5';
        insert setting;
       // insert test lead
       
        
        
        scheduledUpdateLeadSyncFieldBatch  testsche = new scheduledUpdateLeadSyncFieldBatch ();
        String sch = '0 0 23 * * ?';
        system.schedule('Test status Check', sch, testsche );
        Test.stopTest();
    }
}