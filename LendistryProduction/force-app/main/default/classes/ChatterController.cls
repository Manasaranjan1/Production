public with sharing class ChatterController {

    public string oppRecordId{ get ; set ; }
    public ChatterController(ApexPages.StandardController controller) {
        oppRecordId= ApexPages.CurrentPage().getparameters().get('id');
       string strid= ApexPages.currentPage().getHeaders().get('id');
        String MyParameter = ApexPages.currentPage().getParameters().get('id');
        system.debug('****MyParameter ***'+MyParameter );
        system.debug('****oppRecordId***'+oppRecordId);
    }
    
    public ChatterController() {
  
         oppRecordId= ApexPages.CurrentPage().getparameters().get('id');
        string strid= ApexPages.currentPage().getHeaders().get('id');
        String MyParameter = ApexPages.currentPage().getParameters().get('id');
        system.debug('****MyParameter ***'+MyParameter );
        system.debug('****oppRecordId***'+oppRecordId);
 
    }


}