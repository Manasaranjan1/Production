public class  counselloeListViewController{
        
    // class
    public class LeadWrapper{
        @AuraEnabled
        public String LeadId;
        @AuraEnabled
        public List<String> listOfDetails;
        @AuraEnabled
        public List<String> listClientData;
        @AuraEnabled
        public List<String> listBusinessInformation;
        @AuraEnabled
        public List<String> listSalesInformation;
        @AuraEnabled
        public List<String> listOneonOneConsulting;
        @AuraEnabled
        public List<String> listOnlinecourses;
        @AuraEnabled
        public List<String> listAdditionalInformation;
        public LeadWrapper(){
            listOfDetails = new List<String>();
            listClientData = new List<String>();
            listBusinessInformation = new List<String>();
            listSalesInformation = new List<String>();
            listOneonOneConsulting = new List<String>();
            listOnlinecourses = new List<String>();
            listAdditionalInformation= new List<String>();
            
        }
        
    }
    
     @AuraEnabled
     public static Boolean saveTimeTracking(String timeWithDate, String sessionId){
     system.debug('timeWithDatetimeWithDate'+timeWithDate);
         Counseling_Session__c sessionobject = new Counseling_Session__c(id=sessionId);
         //sessionobject.Time_Tracker__c  = Date.today()+'::'+ timeWithDate;
         //update sessionobject;
         return true;
     }
    
    // get all the Counselling Session Attachments
    @AuraEnabled
    public static List<ContentVersion> getFiles(String CounsellingSessionId){
        List<ContentDocumentLink> contentDocumentList=[select ContentDocumentId,LinkedEntityId from ContentDocumentLink where LinkedEntityId=:CounsellingSessionId];
        Set<Id> contentDocumentId = new Set<Id>();
        for(ContentDocumentLink cd1 : contentDocumentList){
            contentDocumentId.add(cd1.ContentDocumentId);
        }
        List<ContentVersion> contentVersionList =[SELECT id,VersionData, FileType,Title,FileExtension,ContentDocumentId,ContentDocument.FileType ,ContentDocument.ContentSize from ContentVersion where ContentDocumentId in : contentDocumentId];
        //return JSON.seralize(contentVersionList)
        return contentVersionList;    
        
    }
    
    // delete file
    @AuraEnabled
    public static Boolean deleteSalesforceFile(String ContentDocumentId){
        system.debug(':::::::::::::'+ContentDocumentId);
        delete [select id from ContentDocument where id =:ContentDocumentId];
        return true;
    }
    
    @AuraEnabled
    public static LeadWrapper getLeadField(String Csid){
                
        
        LeadWrapper objWrap = new LeadWrapper();
        List<String> listOfField = new List<String>();
        
        List<Schema.FieldSetMember> fieldsetAdd =  SObjectType.Lead.FieldSets.Additional_Information.getFields();
        for(Schema.FieldSetMember f : fieldsetAdd) {
            objWrap.listAdditionalInformation.add(f.getFieldPath());
        }
        
        List<Schema.FieldSetMember> fieldsetonline =  SObjectType.Lead.FieldSets.Online_courses.getFields();
        for(Schema.FieldSetMember f : fieldsetonline ) {
            objWrap.listOnlinecourses.add(f.getFieldPath());
        }
        List<Schema.FieldSetMember> fieldsetConsu =  SObjectType.Lead.FieldSets.One_on_One_Consulting.getFields();
        for(Schema.FieldSetMember f : fieldsetConsu ) {
            objWrap.listOneonOneConsulting.add(f.getFieldPath());
        }
        List<Schema.FieldSetMember> fieldset =  SObjectType.Lead.FieldSets.Lead_Fields.getFields();
        for(Schema.FieldSetMember f : fieldset) {
            objWrap.listOfDetails.add(f.getFieldPath());
        }
        //2
        List<Schema.FieldSetMember> fieldsetclient =  SObjectType.Lead.FieldSets.Client_Data.getFields();
        for(Schema.FieldSetMember f : fieldsetclient) {
            objWrap.listClientData.add(f.getFieldPath());
        }
        //3 
        List<Schema.FieldSetMember> fieldsetbusiness =  SObjectType.Lead.FieldSets.Business_Information.getFields();
        for(Schema.FieldSetMember f : fieldsetbusiness) {
            objWrap.listBusinessInformation.add(f.getFieldPath());
        }
        //4
        List<Schema.FieldSetMember> fieldsetSales =  SObjectType.Lead.FieldSets.Sales_Information.getFields();
        for(Schema.FieldSetMember f : fieldsetSales ) {
            objWrap.listSalesInformation.add(f.getFieldPath());
        }
        system.debug('objWrap.listOfDetails'+objWrap.listOfDetails);
        Counseling_Session__c CSRecord = [Select Lead__r.Id, id from Counseling_Session__c where id =: Csid limit 1];
        objWrap.LeadId = CSRecord.Lead__c;
        return objWrap;
    }
    
    // intilize component
    @AuraEnabled
    public static fieldsClass getConfigurationData(){
        fieldsClass objClassWrap = new fieldsClass();    
        Schema.DescribeSObjectResult objectDescribe = Counseling_Session__c.getSObjectType().getDescribe();
        
        Map<String, Schema.SObjectField> fields = objectDescribe.fields.getMap();
        Map<String, Object> result = new Map<String, Object>();  
         
        for(String fieldName : fields.keySet()) {
            Schema.SObjectField field = fields.get(fieldName);
             
            Schema.DescribeFieldResult fieldDescribe = field.getDescribe();//!fieldDescribe.getLabel().contains('Last') 
             system.debug('fields.keySet'+fieldDescribe.getName());
            if( !fieldDescribe.getLabel().contains('System') && fieldDescribe.getLabel()!='72 Hours Sessions' && 
               fieldDescribe.getLabel()!='owner id' && fieldDescribe.getLabel()!='record Id' && fieldDescribe.getLabel()!='Created by Id' && fieldDescribe.getLabel()!='Last Activity Date' && fieldDescribe.getLabel()!='Subject' && fieldDescribe.getLabel()!='Last Viewed Date' && fieldDescribe.getLabel()!='Last Referenced Date' && fieldDescribe.getLabel()!='Last Modified By ID' && fieldDescribe.getLabel()!='Deleted' &&
               fieldDescribe.getLabel()!='Created Date Formula' && fieldDescribe.getLabel()!='CREATED DATE' && fieldDescribe.getLabel()!='Counselor' && fieldDescribe.getLabel()!='Created Date Formula'&& fieldDescribe.getLabel()!='CS Hours' && fieldDescribe.getLabel()!='CS Minutes' && fieldDescribe.getLabel()!='Cumulative Time' && fieldDescribe.getLabel()!='Note' && fieldDescribe.getLabel()!='SessionStart' && fieldDescribe.getLabel()!='SessionStop' && fieldDescribe.getLabel()!='LASTMODIFIEDBYFORMULA' ){
                   fieldWrapper objWrap = new fieldWrapper();             
                   objWrap.apiName      =  fieldDescribe.getName(); 
                   objWrap.label        =  fieldDescribe.getLabel(); 
                   objWrap.type         =  String.valueOf(fieldDescribe.getType()); 
                   if(objWrap.type=='PICKLIST') {
                       objWrap.listOfOption =  getPickListValuesCommon('Counseling_Session__c',objWrap.apiName);
                       system.debug('???????????'+objWrap.listOfOption);
                   }
                   if( objWrap.apiName!='Lead__c'){
                       objClassWrap.listOfField.add(objWrap.label);
                       
                   }
                   objClassWrap.mapOfFiewldNameWithWrapper.put(objWrap.label,objWrap);                
               }   
        } 
        system.debug('objClassWrap.mapOfFiewldNameWithWrapper'+objClassWrap.mapOfFiewldNameWithWrapper+'objClassWrap.listOfField'+objClassWrap.listOfField);
        String finalString='';
        String fieldName='';
        
        List<Schema.FieldSetMember> fieldset =  SObjectType.Counseling_Session__c.FieldSets.Column_Component.getFields();
        for(Schema.FieldSetMember f : fieldset) {
            fieldQueryWrapper fwrap = new fieldQueryWrapper(); 
            fwrap.flabel = f.getLabel();
            fwrap.fapi  = f.getFieldPath();
            fwrap.type = String.valueOf(f.getType());
            fieldName= fieldName+f.getFieldPath()+',';
            objClassWrap.fieldquerylist.add(fwrap);
            objClassWrap.mapForDualList.put(fwrap.flabel,fwrap.flabel);
        }
        system.debug(' '+objClassWrap.mapForDualList);
        finalString =    fieldName.removeEnd(','); 
        String userId = UserInfo.getUserId();
        objClassWrap.finalString = finalString ;
        objClassWrap.sortOrder ='desc';                 
        objClassWrap.orderby = 'Name';
        objClassWrap.currentUserId = userId;
        //List<User> listOfPartner = [select id ,name from User where contactId!=null];
        String  soql = ''
            + ' SELECT ' + finalString
            + ' FROM Counseling_Session__c WITH SECURITY_ENFORCED order by Name desc';
        //Counsellor1__c=\''+ userId+'\'
            system.debug('soqlsoqlsoqlsoql'+soql);
        objClassWrap.query = soql;               
        objClassWrap.listOfRecord = getData(soql );          
               system.debug('objClassWrap.listOfRecord'+objClassWrap.listOfRecord);

        return objClassWrap;
    }
     @AuraEnabled
    public static List<Counseling_Session__c> getCounselingsession() {
        return [SELECT Id, Name, Note__c, Counsellor1__c,Counsellor_Name__c,Lead_Business_Name__c,LeadFormula__c,Lead__c, LastModifiedDate, is_intrested_in_financing__c, Subject__c FROM Counseling_Session__c ORDER BY createdDate ASC];
    }    
    @AuraEnabled
    public static List<Counseling_Session__c> findByName(String searchKey) {
        String name =  + searchKey + '%';
        return [SELECT Id, Name, Note__c, Counsellor1__c,Counsellor_Name__c,Lead_Business_Name__c,LeadFormula__c,Lead__c, LastModifiedDate, is_intrested_in_financing__c, Subject__c FROM Counseling_Session__c WHERE name LIKE :name];
    }
    
    @AuraEnabled 
    public static List<Sobject> getData(String soql){
        system.debug('soqlsoqlsoql'+soql);
        return  Database.query(soql);
        
    }
    @AuraEnabled
    public static String getDateFilter(String strDate){
        String[] strSplitDate = strDate.split('-');
        Integer myIntDate = integer.valueOf(strSplitDate [2]);
        Integer myIntMonth = integer.valueOf(strSplitDate [1]);
        Integer myIntYear = integer.valueOf(strSplitDate [0]);
        Date endDate = Date.newInstance(myIntYear, myIntMonth, myIntDate);
        String endStrDate = DateTime.newInstance(endDate.year(),endDate.month(),endDate.day()).format('yyyy-MM-dd'); //.format('YYYY-MM-dd')                
        return endStrDate;
    }
    // piclikst schema
    public class picklistFieldsWrapper {
        
        @AuraEnabled public String label;
        @AuraEnabled public String value;
        
    }
    // Method for getting picklist schemas
    public static list<picklistFieldsWrapper> getPickListValuesCommon(String sObjectName, String fieldName){
        
        list<picklistFieldsWrapper> Options = new list<picklistFieldsWrapper>();   
        Schema.SObjectType t = Schema.getGlobalDescribe().get(sObjectName);        
        Schema.DescribeSObjectResult r = t.getDescribe();  
        Schema.DescribeFieldResult fieldResult = r.fields.getMap().get(fieldName).getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            picklistFieldsWrapper option = new picklistFieldsWrapper();
            option.label = p.getLabel();
            option.value = p.getValue();            
            Options.add(option);
        }
        return Options;
    }
    
    
     @AuraEnabled 
    public static boolean sessionStopTime (string LogInUserID ){
                system.debug('--sessionStopTime--->>');

        DateTime StopTime = system.now();
        
        System.debug('Inside Session Stop time');
        list<Counselor_Login_Hours__c> EndTime= [select id from Counselor_Login_Hours__c 
                                                 where Start_Time__c != null AND End_Time__c = null AND Counselor__c=:LogInUserID
                                                 order By Createddate desc LIMIT 1 ] ;
        system.debug('Value of EndTime: '+EndTime);
        if( EndTime != null && EndTime.size() > 0){
        
            Counselor_Login_Hours__c objCounselorLoginHours = new Counselor_Login_Hours__c (Id = EndTime[0].id);
            objCounselorLoginHours.End_Time__c = StopTime;
                    
            Update objCounselorLoginHours; 
        }
        return true;
    }
    
    
    // wrapper class
    public class fieldsClass{
        @AuraEnabled
        public String currentUserId;
        @AuraEnabled
        public String finalString;
        @AuraEnabled
        public String query;
        @AuraEnabled
        public String sortOrder;
        @AuraEnabled
        public String orderby;
        @AuraEnabled
        public Map<String,fieldWrapper> mapOfFiewldNameWithWrapper;
        @AuraEnabled
        public List<String> listOfField;
        @AuraEnabled
        public List<Sobject> listOfRecord;
        @AuraEnabled
        public List<fieldQueryWrapper> fieldquerylist;
        @AuraEnabled
        public Map<String,String> mapForDualList;
        //@AuraEnabled
       // public Map<String,String> mapForPartnerUser;
        public fieldsClass(){
            mapOfFiewldNameWithWrapper = new Map<String,fieldWrapper>();
            listOfField = new List<String>();
            listOfRecord = new List<Sobject>();
            fieldquerylist = new List<fieldQueryWrapper>();
            mapForDualList = new Map<String,String>();
            //mapForPartnerUser = new Map<String,String>();
        }
    }
    //
    public class fieldQueryWrapper{
        @AuraEnabled
        public String flabel;
        @AuraEnabled
        public String fapi;
        @AuraEnabled
        public String type;
    }
    public class fieldWrapper{
        @AuraEnabled
        public String apiName;
        @AuraEnabled
        public String type;
        @AuraEnabled
        public String value;
        @AuraEnabled
        public String label;
        
        @AuraEnabled
        public List<String> operatorlist;
        @AuraEnabled
        public list<picklistFieldsWrapper> listOfOption;
        public fieldWrapper(){
            listOfOption= new list<picklistFieldsWrapper>();
            operatorlist = new List<String>();
            
        }
    }
    
    // Attachment wrapper class
    public class AttachmentWrapper{
        @AuraEnabled
        public String fName;
        @AuraEnabled
        public String fType;
        @AuraEnabled
        public Integer fsize;
        @Auraenabled
        public String recordId;
        @AuraEnabled
        public Blob fbody;
    }    
}