@isTest
public class createActRecordOnLead_OpportunityTest{
    public static testMethod void  test1(){        
         
        Contact oContact2 = new Contact();
        oContact2.FirstName = 'Test';
        oContact2.LastName = 'Test 2';
        oContact2.Birthdate = System.today().addYears(-20);
        oContact2.State__c = 'MO';
        oContact2.Country__c = 'US';
        oContact2.Street__c = 'Street';
        oContact2.City__c = 'Anthill';
        oContact2.Zip_Code__c = '07029';
        oContact2.SSN1__c = '000000001';
        insert oContact2;
        
        Opportunity op = new Opportunity();
        op.StageName = 'Sales Review';
        op.Owner__c = oContact2.Id;
        op.Name = 'Test';
        op.CloseDate = System.today();
        insert op;
               
         // insert SMS History record
         tdc_tsw__Message__c objMesage = new tdc_tsw__Message__c();
         objMesage.tdc_tsw__Opportunity__c= op.Id;
         insert objMesage ;
         
         
     }
}