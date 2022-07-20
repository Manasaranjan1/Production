@isTest
public class DISCLOSURESCtrl_Test {
    public static testMethod void method1(){
        Lead objLead = new Lead();
        objLead.Lastname ='Test';
        objLead.Company = 'comp';
        objLead.LeadSource='Portal';
        insert objLead;
        
        // insert question
        Lead_Questions__c objqst = new Lead_Questions__c();
        objqst.Question_Type__c = 'picklist';
        objqst.Question__c = 'what is your name';
        objqst.Answer__c ='raaj';
        objqst.Lead__c = objLead.Id;
        insert objqst;
        
        ApexPages.CurrentPage().getparameters().put('id', objLead.id); 
         ApexPages.CurrentPage().getparameters().put('recordId', objqst.id);     
         
        Apexpages.StandardController sc = new Apexpages.StandardController(objqst);
        DISCLOSURESCtrl  ext = new DISCLOSURESCtrl(sc); 
        ext.quickUpdat();
        ext.updateQuestion();
    }
}