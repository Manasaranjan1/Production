@isTest(seeALLData = true) 
 
public class UpdateLeadSyncFieldBatchBatchJobTest{
    static testMethod void testMethod1() {
         Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        //Id recordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get('SBA - PPP').getRecordTypeId();
        Id devRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
        system.debug('recordtype name'+devRecordTypeId);
        //Instances       
       // objLead = new Lead(RecordTypeId = recordTypeId);
       
       // Added by Raju
       Tenant_Details__c v = new Tenant_Details__c();
       v.PortalAPIEndPoint__c = System.Label.ProductionEndPoint1;
       Insert v;
       
        List<Lead> lstLead = new List<Lead>();
         set<string> setOfLeads = new set<string>();
        for(Integer i=0 ;i <20;i++){
            Lead objLead = new Lead();
            
            objLead.LastName ='Name'+i;
            objLead.Company = 'test ';
            objLead.Leadsource='portal';
            objLead.Loan_Type__c ='SBA-PPP';
            objLead.Business_EIN__c ='12445';
            objLead.Tenant_Details__c = v.Id;
            objLead.RecordTypeId = devRecordTypeId;
            //objLead.PortalAPIEndPoint__c = 'testport';
            lstLead.add(objLead);
        }
        
       
        insert lstLead;
        /* Amazon_AWS_S3__c  objAmazon = new Amazon_AWS_S3__c();
        objAmazon.Lead__c = lstLead[0].Id;
        objAmazon.AWS_File1__c = 'https://mmc-application-stage.s3-us-west-2.amazonaws.com/salesforceupload';
        objAmazon.AWS_File2__c = 'https://mmc-application-stage.s3-us-west-2.amazonaws.com/salesforceupload';
        objAmazon.AWS_File3__c = 'https://mmc-application-stage.s3-us-west-2.amazonaws.com/salesforceupload';
        objAmazon.AWS_File4__c = 'https://mmc-application-stage.s3-us-west-2.amazonaws.com/salesforceupload';
        insert objAmazon;
        setOfLeads.add(lstLead[0].id);*/
        Test.startTest();
         //String  strbatchsize = BatchConfigurationData__c.getValues('Batch Time').Batch_Size__c;
         String loanType='SBA-PPP';
         String query ='select id,name,RecordTypeId,PortalAPIEndPoint__c,IsSyncWithPortal__c,Loan_Type__c,Business_EIN__c from Lead where IsSyncWithPortal__c=false and Loan_Type__c=\'SBA-PPP\'  and recordtype.name = \'grant\' limit 10';
            UpdateLeadSyncFieldBatch obj = new UpdateLeadSyncFieldBatch(query);
            DataBase.executeBatch(obj);
            
          
            
        Test.stopTest();
    }
    
    static testMethod void testMethod2() {
         Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        //Id recordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get('SBA - PPP').getRecordTypeId();
        Id devRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
        system.debug('recordtype name'+devRecordTypeId);
        //Instances       
       // objLead = new Lead(RecordTypeId = recordTypeId);
       
       // Added by Raju
       Tenant_Details__c v = new Tenant_Details__c();
       v.PortalAPIEndPoint__c = System.Label.ProductionEndPoint2;
       // v.PortalAPIEndPoint__c = System.Label.ProductionEndPoint3;
        //v.PortalAPIEndPoint__c = System.Label.ProductionEndPoint4;
       // v.PortalAPIEndPoint__c = System.Label.ProductionEndPoint5;
       Insert v;
       
        List<Lead> lstLead = new List<Lead>();
         set<string> setOfLeads = new set<string>();
        for(Integer i=0 ;i <20;i++){
            Lead objLead = new Lead();
            
            objLead.LastName ='Name'+i;
            objLead.Company = 'test ';
            objLead.Leadsource='portal';
            objLead.Loan_Type__c ='SBA-PPP';
            objLead.Business_EIN__c ='12445';
            objLead.Tenant_Details__c = v.Id;
            objLead.RecordTypeId = devRecordTypeId;
            //objLead.PortalAPIEndPoint__c = 'testport';
            lstLead.add(objLead);
        }
        
       
        insert lstLead;
        
        /* Amazon_AWS_S3__c  objAmazon = new Amazon_AWS_S3__c();
        objAmazon.Lead__c = lstLead[0].Id;
        objAmazon.AWS_File1__c = 'https://mmc-application-stage.s3-us-west-2.amazonaws.com/salesforceupload';
        objAmazon.AWS_File2__c = 'https://mmc-application-stage.s3-us-west-2.amazonaws.com/salesforceupload';
        objAmazon.AWS_File3__c = 'https://mmc-application-stage.s3-us-west-2.amazonaws.com/salesforceupload';
        objAmazon.AWS_File4__c = 'https://mmc-application-stage.s3-us-west-2.amazonaws.com/salesforceupload';
        insert objAmazon;
        setOfLeads.add(lstLead[0].id);*/
        Test.startTest();
         //String  strbatchsize = BatchConfigurationData__c.getValues('Batch Time').Batch_Size__c;
         String loanType='SBA-PPP';
         String query ='select id,name,RecordTypeId,PortalAPIEndPoint__c,IsSyncWithPortal__c,Loan_Type__c,Business_EIN__c from Lead where IsSyncWithPortal__c=false and Loan_Type__c=\'SBA-PPP\'  and recordtype.name = \'grant\' limit 10';
            UpdateLeadSyncFieldBatch obj = new UpdateLeadSyncFieldBatch(query);
            DataBase.executeBatch(obj);
            
          
            
        Test.stopTest();
    }
    
    
    static testMethod void testMethod3() {
         Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        //Id recordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get('SBA - PPP').getRecordTypeId();
        Id devRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('GRANT').getRecordTypeId();
        system.debug('recordtype name'+devRecordTypeId);
        //Instances       
       // objLead = new Lead(RecordTypeId = recordTypeId);
       
       // Added by Raju
       Tenant_Details__c v = new Tenant_Details__c();
       v.PortalAPIEndPoint__c = System.Label.ProductionEndPoint3;
       // v.PortalAPIEndPoint__c = System.Label.ProductionEndPoint3;
        //v.PortalAPIEndPoint__c = System.Label.ProductionEndPoint4;
       // v.PortalAPIEndPoint__c = System.Label.ProductionEndPoint5;
       Insert v;
       
        List<Lead> lstLead = new List<Lead>();
         set<string> setOfLeads = new set<string>();
        for(Integer i=0 ;i <20;i++){
            Lead objLead = new Lead();
            
            objLead.LastName ='Name'+i;
            objLead.Company = 'test ';
            objLead.Leadsource='portal';
            objLead.Loan_Type__c ='SBA-PPP';
            objLead.Business_EIN__c ='12445';
            objLead.Tenant_Details__c = v.Id;
            objLead.RecordTypeId = devRecordTypeId;
            //objLead.PortalAPIEndPoint__c = 'testport';
            lstLead.add(objLead);
        }
        
       
        insert lstLead;
       
        Test.startTest();
         //String  strbatchsize = BatchConfigurationData__c.getValues('Batch Time').Batch_Size__c;
         String loanType='SBA-PPP';
         String query ='select id,name,RecordTypeId,PortalAPIEndPoint__c,IsSyncWithPortal__c,Loan_Type__c,Business_EIN__c from Lead where IsSyncWithPortal__c=false and Loan_Type__c=\'SBA-PPP\'  and recordtype.name = \'grant\' limit 10';
            UpdateLeadSyncFieldBatch obj = new UpdateLeadSyncFieldBatch(query);
            DataBase.executeBatch(obj);
            
          
            
        Test.stopTest();
    }

}