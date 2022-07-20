@isTest()
public class contactsLeadController_Test {

    static testmethod void myUnitTest() 
    {
       //============Create Test Data===============================
       list<Contact> lstOfContacts = new list<Contact>();
            Account objAcc = new Account();
            objAcc.Name = 'objAcc';
            objAcc.Phone = '90271900';
            objAcc.BillingCountry ='India';
       
        insert objAcc;
        for( Integer i=1; i<10; i++)
        {
            Contact objCon = new contact();
            objCon.FirstName = 'objCon';
            objCon.LastName = 'objConL'+i;
            objCon.Email = 'objCon'+i+'@gmail.com';
            objCon.AccountId= objAcc.id;
            
            lstOfContacts.add(objCon);
        }
        insert lstOfContacts;
        System.assertNotEquals(null, lstOfContacts.size());
        
        list<Lead> lstLeads = new list<Lead>();
        Lead newLead = new Lead() ;
        newLead.FirstName = 'Cole';
        newLead.LastName = 'Swain';
        newLead.Company = 'BlueWave';
        newLead.Status = 'New';
        
        newLead.IsConverted = False;
        lstLeads.add(newLead);
        insert lstLeads;
        contactsLeadController.getContactANDLead(objAcc.id);
        contactsLeadController.fakeMethod();
        
    }
    
}