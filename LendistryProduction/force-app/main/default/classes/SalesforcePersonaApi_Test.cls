@isTest
public class SalesforcePersonaApi_Test {
    
    public static testmethod void updatePersona() {
        lead ldL = new lead();
        ldl.Status = 'Converted';
        ldL.FirstName = 'test1';
        ldL.LastName ='demo';
        ldL.Company =' testdemo';
        ldL.LeadSource = 'web';
        // ldl.Persona__c = 'Completed';
        insert ldL;
        
        Account ObjAccount = new Account();
        ObjAccount.Name='Test Account record' ;
        insert ObjAccount;
        
        Opportunity ObjOpp = new Opportunity();
        ObjOpp.Name= 'TestOpp';
        ObjOpp.StageName = 'Sub for Review';
        ObjOpp.AccountId = ObjAccount.id;
        ObjOpp.CloseDate = system.today()+5;
        ObjOpp.Days_in_UW_Sub__c = 0;
        ObjOpp.Projected_Close_Date__c = system.today() +10;
          //    ObjOpp.Id = ldL.ConvertedOpportunityId;
        insert ObjOpp;
       // ObjOpp.Persona__c = 'Completed';
      // ObjOpp.Id = ldL.ConvertedOpportunityId;
      // update ObjOpp;
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();             
        req.requestURI = '/SalesforcePersonaApi/';
        req.httpMethod = 'POST';
        String str = '{"Persona": "Completed","LeadId": "'+ldL.id+'"}';
        req.requestBody = Blob.valueof(str); 
        RestContext.request = req;
        RestContext.response= res;
        SalesforcePersonaApi.updatePersona();
        
    }
    
       public static testmethod void updatePersonaException() {
        lead ldL = new lead();
        ldl.Status = 'Converted';
        ldL.FirstName = 'test1';
        ldL.LastName ='demo';
        ldL.Company =' testdemo';
        ldL.LeadSource = 'web';
        // ldl.Persona__c = 'Completed';
        insert ldL;
        
        Account ObjAccount = new Account();
        ObjAccount.Name='Test Account record' ;
        insert ObjAccount;
        
        Opportunity ObjOpp = new Opportunity();
        ObjOpp.Name= 'TestOpp';
        ObjOpp.StageName = 'Sub for Review';
        ObjOpp.AccountId = ObjAccount.id;
        ObjOpp.CloseDate = system.today()+5;
        ObjOpp.Days_in_UW_Sub__c = 0;
        ObjOpp.Projected_Close_Date__c = system.today() +10;
         // ObjOpp.Id = ldL.ConvertedOpportunityId;
        insert ObjOpp;
      //  ObjOpp.Persona__c = 'Completed';
      // ObjOpp.Id = ldL.ConvertedOpportunityId;
      // update ObjOpp;
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();             
        req.requestURI = '/SalesforcePersonaApi/';
        req.httpMethod = 'POST';
        String str = '{"personaStatus": "Completed","LeadId": "'+ObjOpp.Id+'"}';
        req.requestBody = Blob.valueof(str); 
        RestContext.request = req;
        RestContext.response= res;
        SalesforcePersonaApi.updatePersona();
        
    }
}