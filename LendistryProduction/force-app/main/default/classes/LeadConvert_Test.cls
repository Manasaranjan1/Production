@isTest
public class LeadConvert_Test{
    @isTest
    public static void leadConversionUnitTest() {
      Test.startTest();
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        Trigger_ON_OFF_Setting__c objTri = new Trigger_ON_OFF_Setting__c();
        objTri.Name = 'LeadTrigger_Switch';
        objTri.Lead_NonSBA_Method_1__c = true;
        objTri.Lead_NonSBA_Method_2__c = true;
        objTri.Lead_NonSBA_Method_3__c = true;
        objTri.Lead_NonSBA_Method_4__c = true;
        objTri.Lead_NonSBA_Method_5__c = true;
        objTri.Lead_NonSBA_Method_6__c = true;
        objTri.Lead_SBA_Method_1__c = true;
        objTri.LeadSBAMethod2__c = true;
        objTri.LeadSBAMethod3__c = true;
        objTri.LeadSBAMethod4__c = true;
        objTri.LeadSBAMethod5__c = true;
        objTri.LeadSBAMethod6__c = true;
        objTri.LeadSBAMethod4__c = true;
        objTri.LeadTrigger_ON_OFF__c = true;
        insert objTri;
    
        ID GQRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('General Questions Contact Form').getRecordTypeId();
        ID PCRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Partnership Contact Form').getRecordTypeId();
        ID PPRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Prospective Proposal').getRecordTypeId();
        
        lead ldL = new lead();
        ldL.FirstName = 'test1';
        ldL.LastName ='demo';
        ldL.Company =' testdemo';
        ldL.LeadSource = 'web';
        ldL.RecordTypeId= GQRecordTypeID;
        insert ldL;
        
        
        lead ld1 = new lead();
        ld1.FirstName = 'test2';
        ld1.LastName ='demo';
        ld1.Company =' testdemo';
        ld1.LeadSource = 'web';
        ld1.RecordTypeId= PCRecordTypeID;  
        insert ld1;
        
        lead ld2 = new lead();
        ld2.FirstName = 'test3';
        ld2.LastName ='demo';
        ld2.Company =' testdemo';
        ld2.LeadSource = 'web';
        ld2.RecordTypeId= PPRecordTypeID;  
        insert ld2;
        //LeadConvert.LeadConvertPB([SELECT Id, FirstName, LastName, LeadSource, RecordTypeId FROM Lead]);
      Test.stopTest();
        
        
    }
    
}