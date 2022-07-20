@isTest
public class scoreCardOppCtrl_Test {
    public static testMethod void method1(){
        Opportunity objOpp = new Opportunity();
        objOpp.Name ='Test';
        // objOpp.Company = 'comp';
        objOpp.StageName = 'Picklist';
        objOpp.CloseDate = System.today();
        objOpp.Loan_Type__c = 'ARLOC';
        objOpp.LeadSource='Portal';
        insert objOpp;
        
        ScoreCard__c objscore = new ScoreCard__c();
        objscore.Total_Score__c = 9;
        objscore.Woman_Owned__c = 7;
        objscore.Loan_Type__c = 'PA Cares';
        objscore.Opportunity__c = objOpp.Id;
        insert objscore;
        
        ScoreCardSettings__c objset = new ScoreCardSettings__c();
        
        objset.Name = 'BERKS COUNTY';
        objset.Loan_Type__c = 'ARLOC';
        objset.FieldSetName__c = 'BERKS_COUNTY';
        insert objset;
        
        ApexPages.CurrentPage().getparameters().put('id', objOpp.id); 
        ApexPages.CurrentPage().getparameters().put('recordId', objscore.id); 
        
        Apexpages.StandardController sc = new Apexpages.StandardController(objscore);
        scoreCardOppCtrl  opp = new  scoreCardOppCtrl(sc);
        Test.startTest();
        scoreCardOppCtrl.fieldSetName = objset.FieldSetName__c;
        scoreCardOppCtrl.getfields();
        scoreCardOppCtrl.getScoreCard(objOpp.ID);
        Test.stopTest();
    }
}