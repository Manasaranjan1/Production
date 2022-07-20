@isTest
public class CreditReportCTRL_Test {
@isTest
    public static void CreditReportCTRL() {
     lead ldL = new lead();
        ldL.FirstName = 'test1';
        ldL.LastName ='demo';
        ldL.Company =' testdemo';
        ldL.Street = 'Test street';
        ldL.City = 'Hyderabad';
        ldL.State = 'Pune';
        ldL.Country = 'India';
        ldL.Postalcode = '56009';
        ldL.LeadSource = 'web';
        ldL.Email = 'test@gmail.com';
        insert ldL;
      CreditReportCTRL.CheckCreditField(ldL.id);      
    }

}