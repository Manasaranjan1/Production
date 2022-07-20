@isTest
public class ChatterController_Test {
    
    public static testmethod void Chatter(){
        
        PageReference pageRef = Page.chatterpage;
    Test.setCurrentPageReference(pageRef);

        //create contact
        Account cont = new Account(name ='bob');
        insert cont;

        ApexPages.CurrentPage().getparameters().put('pid', cont.id);
        ApexPages.StandardController sc = new ApexPages.standardController(cont);
        ChatterController sic = new ChatterController(sc);
        ApexPages.currentPage().getParameters();
        ChatterController sic1 = new ChatterController();
       // System.assertEquals('something here');
    }
        

}