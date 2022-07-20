public without sharing class lendistryController {
    //Property
    public lead objLead {get;set;}  
    public Boolean isCaptcha{get;set;}
    public Boolean isDuplicateLead{get;set;}
    public String referalName;
    public string OrgId {get;set;}  
    public Boolean verified { get; private set; }
    public String response  { 
        get {
            return ApexPages.currentPage().getParameters().get('g-recaptcha-response');
        }
    }
    public String publicKey {get;set;}
    //Constructor 
    public lendistryController(){ 
        referalName = ApexPages.currentPage().getParameters().get('ReferralPartnerName') ;
        Id recordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName()
            .get('SBA_PPP').getRecordTypeId();
        //Instances        
        objLead = new Lead(RecordTypeId = recordTypeId);
        isCaptcha = true;
        isDuplicateLead = false;
        system.debug('---recordTypeId ------->>'+recordTypeId );
        // reCAPTCHA ===
        this.publicKey = system.label.Lendistry_reCAPTCHA;// '6Lcu1OYUAAAAAKC7uPuKB36-KZ2kpo1AfLed4Kss'; //Google Site Key or Public Key
        this.OrgId = system.label.LendistryOrgId;
        this.verified = false;
    }
    
    public void enableBtnMethod(){
        isCaptcha= false;
    }
    //Save Method 
    public PageReference SaveMethod(){
        
        try{
            
            objLead.Country = 'USA';
            objLead.Country_Owner_1__c = 'USA';
            objLead.SBA_PPP_2021__c =true;
            if(referalName !=null && referalName !='')
                objLead.Referral_Partner1__c =referalName ;
            else
                objLead.Referral_Partner1__c = 'WEBFORM';
            
            objLead.Run_Credit_Report__c = true; 
            objLead.LeadSource = 'Website';
            system.debug('---objLead------->>'+objLead);
            
            // Lead de-duplication check
            list<lead> oldLeadData = [ select id, Email,SSN1__c,Business_EIN__c from lead where Email=:objLead.Email AND IsConverted=false];
            String BaseURL = system.URL.getSalesforceBaseUrl().toExternalForm();
            
            if( (oldLeadData !=null && oldLeadData.size()>0 && oldLeadData[0].Email != null && oldLeadData[0].Business_EIN__c != null )&& (oldLeadData[0].Email ==  objLead.Email) && (oldLeadData[0].Business_EIN__c ==  objLead.Business_EIN__c))
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING, 'Oops! It seems there is already an application in our system with the same email address / Business EIN. Please login to your account with the email address at www.mylendistry.com or use a different email address.'));
                
                isDuplicateLead = true;
            }
            else
            {
                insert objLead; 
                isDuplicateLead = false;
            }
            PageReference   objPagePage = new PageReference(BaseURL+'/Lendistry_Lead_FileUpload');
            objPagePage.setRedirect(true);
            
            if( isDuplicateLead == false)
                return objPagePage;
            else
                return null;
            
        }catch(exception ex){
            pagereference p = apexpages.Currentpage();
            apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            apexpages.addmessage(msg);
            return p; 
        }
            
        
    }
   
   
    
}