@isTest
//Cloud Maven Test
public class TestDataService {

     public static Account createAccount() {
        
        // Create the Account
        Account acc = new Account (
            Name = 'Test'
        );
        
        insert acc;
        
        return acc;
        
    }

    
    public static Contact createContact( Id accId ) {
        
        // Create the Contact record
        Contact con = new Contact (
            FirstName = 'Test',
            LastName = 'Contact',
            AccountId = accId
            
        );
        
        insert con;
        
        return con;
        
    }
    
    public static List<Contact> createContacts( Id accId, Integer size) {
        
        List<Contact> lstContacts = new List<Contact>();
        
        for( Integer i = 1; i <= size; i++ ) {
            // Create the Contact record
            Contact con = new Contact (
                
                FirstName = 'Test ' + i,
                LastName = 'Contact',
                AccountId = accId
                
            );
            
            lstContacts.add( con );
        
        }
        
        insert lstContacts;
        
        return lstContacts; 
    
    }
    
    
    public static Opportunity createOpportunity( Id accId, Id conId ) {
        
        Opportunity oppty = new Opportunity(
            
            Name = 'Test',
            CloseDate = System.today(),
            StageName = 'Sales Review',
            Owner__c = conId
        );
        
        insert oppty; 
        
        return oppty;
        
    }
    
    
    public static creditchecker__Credit_Report__c createCreditReport( Contact con, Id opptyId ) {
    
        creditchecker__Credit_Report__c creditReport = new creditchecker__Credit_Report__c (
            creditchecker__Applicants_SSN__c = 'TEST123',
            creditchecker__Applicants_First_Name__c = con.FirstName,
            creditchecker__Applicants_Last_Name__c = con.LastName,
            creditchecker__Current_Line__c = 'Test',
            creditchecker__Current_City__c = 'City',
            creditchecker__Current_Country__c = 'Canada',
            creditchecker__Current_StateCode__c = 'NS',
            creditchecker__Current_Zip_Code__c = 'ZIPCODE',
            creditchecker__Applicants_Residency_Type__c = 'Own',
            creditchecker__Average_Score__c = 5,
            creditchecker__Opportunity__c = opptyId
        );
        
        insert creditReport;
        
        return creditReport;
        
    }
    
    
    
}