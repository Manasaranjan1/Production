public class DISCLOSURESCtrl{
    
   
    public list<Lead_Questions__c> lstOfLeadQuestions { get; set; }
    
    public Lead_Questions__c objLeadQuestion { get; set; } 

    public DISCLOSURESCtrl(ApexPages.StandardController controller) {
    
        string strLeadId = ApexPages.currentPage().getParameters().get('id');
        // objLeadQuestion = [ Select id, Name, Question__c, Answer__c, Tenant_Id__c, Lead__c, Question_Id__c, Question_Type__c, Description__c from Lead_Questions__c limit 1];
        lstOfLeadQuestions = [ Select id, Name, Question__c, Answer__c, Tenant_Id__c, Lead__c, Question_Id__c, Question_Type__c, Description__c from Lead_Questions__c where Lead__r.id=:strLeadId  ];
      
      system.debug('---id-------------->>'+ApexPages.currentPage().getParameters().get('id') );
    }   
    public PageReference quickUpdat(){
        try{
            
            update objLeadQuestion;
            
            return ApexPages.CurrentPage();
        }
        catch(Exception e) {
            System.debug('@@@Error');
            return null;
        }
    }
        public void updateQuestion(){  
            
            String StrRecordId = Apexpages.currentpage().getParameters().get('recordId');  
            
            system.debug('------StrRecordId------------->>'+StrRecordId);
            if( StrRecordId != null && StrRecordId != '' )
            objLeadQuestion = [ Select id, Name, Question__c, Answer__c, Tenant_Id__c, Lead__c, Question_Id__c, Question_Type__c, Description__c from Lead_Questions__c where id=:StrRecordId];
            system.debug('------objLeadQuestion------------->>'+objLeadQuestion);
            
        } 
    
    public void getRecord(){  
            
            
        }
    }