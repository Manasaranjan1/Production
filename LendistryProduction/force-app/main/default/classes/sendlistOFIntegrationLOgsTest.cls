@isTest
public class sendlistOFIntegrationLOgsTest{
    public static testmethod void method1(){
         Integration_Log__b BigO1 = new Integration_Log__b();
         BigO1.API_Name__c = 'Test API';
         BigO1.Application_ID_Email__c  ='sa@it.com';
         BigO1.SObject_RecordID__c ='123456789';
         sendlistOFIntegrationLOgs obj = new sendlistOFIntegrationLOgs(new List<Integration_Log__b>{BigO1});
         System.enqueueJob(obj );
    }
}