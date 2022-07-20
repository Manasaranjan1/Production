@isTest
public class scoreCardLeadCtrl_Test {
    public static testMethod void method1(){
        Lead objLead = new Lead();
        objLead.Lastname ='Test';
        objLead.Company = 'comp';
        objLead.Loan_Type__c = 'ARLOC';
        objLead.LeadSource='Portal';
        insert objLead;
        
        ScoreCard__c objscore = new ScoreCard__c();
        objscore.Total_Score__c = 9;
        objscore.Woman_Owned__c = 7;
        objscore.Loan_Type__c = 'PA Cares';
        objscore.Lead__c = objLead.Id;
        insert objscore;
        
        ScoreCardSettings__c objset = new ScoreCardSettings__c();
       
        objset.Name = 'BERKS COUNTY';
        objset.Loan_Type__c = 'ARLOC';
        objset.FieldSetName__c = 'BERKS_COUNTY';
        insert objset;
        
        ApexPages.CurrentPage().getparameters().put('id', objLead.id); 
        ApexPages.CurrentPage().getparameters().put('recordId', objscore.id); 
        
        Apexpages.StandardController sc = new Apexpages.StandardController(objscore);
        scoreCardLeadCtrl  ext = new scoreCardLeadCtrl(sc);
        
        Test.startTest();
        scoreCardLeadCtrl.fieldSetName = objset.FieldSetName__c;
        scoreCardLeadCtrl.getfields();
        scoreCardLeadCtrl.getScoreCard(objLead.ID);
        Test.stopTest();
    }
}