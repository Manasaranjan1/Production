@isTest
public class DISCLOSUREOppCtrl_Test {
     public static testMethod void method1(){
        Opportunity objOpp = new Opportunity();
        objOpp.Name ='Test';
       // objOpp.Company = 'comp';
        objOpp.StageName = 'Picklist';
        objOpp.CloseDate = System.today();
        objOpp.LeadSource='Portal';
        insert objOpp;
        
        // insert question
        Lead_Questions__c objqst = new Lead_Questions__c();
        objqst.Question_Type__c = 'picklist';
        objqst.Question__c = 'what is your name';
        objqst.Answer__c ='raaj';
       // objqst.Lead__c = objOpp.Id;
        insert objqst;
        
        ApexPages.CurrentPage().getparameters().put('id', objOpp.id); 
         ApexPages.CurrentPage().getparameters().put('recordId', objqst.id);     
         
        Apexpages.StandardController sc = new Apexpages.StandardController(objqst);
        DISCLOSURESOppCtrl  ext = new DISCLOSURESOppCtrl(sc); 
        ext.quickUpdat();
        ext.updateQuestion();
    }
}