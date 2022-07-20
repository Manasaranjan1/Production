@isTest
public  class ApexBaseURl_Test {
    
    public static testMethod void getLeadNamesTest(){
        
        list<Lead> lstLeads = new list<Lead>();
        Lead ObjLead = new Lead();
        ObjLead.Company = 'Company';
        ObjLead.LastName = 'LastName';
        Objlead.Phone = '12345';
        Objlead.Base64CreatedDate__c = Date.today();
        Objlead.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRM0owMDAwMDE4eDdNVUFRfHwwMi4yOC4yMDIwIDE5OjAw';
        lstLeads.add(Objlead);
        Lead ObjLead1 = new Lead();
        ObjLead1.Company = 'Company';
        ObjLead1.LastName = 'LastName';
        Objlead1.Base64CreatedDate__c = Date.today();
        Objlead1.Base64_Encoded_Pardot_Url_Parameter__c = 'MDBRM0owMDAwMDE4eDdNVUFRfHwwMi4yOC4yMDIwIDE5OjAw';
        Objlead1.Phone = '12345';
        lstLeads.add(Objlead1);
        Insert lstLeads;
        
        List<Id> lstOfLeadids = new List<Id>{ Objlead1.Id };
            Test.startTest();
            //  ApexBaseURl apexbase = new ApexBaseURl();
            ApexBaseURl.getLeadNames(lstOfLeadids); 
           ApexBaseURl.renewBase64Code(Objlead1.Id );
        Test.stopTest();
    }  
}