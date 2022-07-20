public with sharing class centerCompCls {
    @AuraEnabled
    public static string  createLead( lead objLeadData ,integer noOfEmployees)
    {
        list<lead> lstOfLeads = new list<lead>();
        list<lead> lstOfLeads1 = new list<lead>();
        string returnStr;
        Id recordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get('Center_Leads').getRecordTypeId();
       
        objLeadData.RecordTypeId = recordTypeId;
         if( noOfEmployees != null )
           objLeadData.NumberOfEmployees=  noOfEmployees;
                
        
        
        system.debug('objLeadData.Email---'+objLeadData.Email);
             lstOfLeads = [ select id,Email,Referral_Partner1__c from lead where Email=:objLeadData.Email AND IsConverted=false AND RecordTypeId=:recordTypeId AND  ( Referral_Partner1__c=:objLeadData.Referral_Partner1__c)];
             lstOfLeads1 = [ select id,Email,Referral_Partner1__c from lead where Email=:objLeadData.Email AND IsConverted=false AND RecordTypeId=:recordTypeId AND  ( Referral_Partner1__c='Center Intake Form')];
             system.debug('lstOfLeads--Size-->'+lstOfLeads.size());
             system.debug('lstOfLeads1--Size-->'+lstOfLeads1.size());
           
            if( (lstOfLeads !=null && lstOfLeads.size()>0 && lstOfLeads[0].Email != null && lstOfLeads[0].Referral_Partner1__c != null )&& (lstOfLeads[0].Email ==  objLeadData.Email) && (lstOfLeads[0].Referral_Partner1__c == objLeadData.Referral_Partner1__c))
            {
                returnStr='Your email address is duplicate. Please apply with unique email';
            }
           else if( (lstOfLeads ==null|| lstOfLeads.size() <= 0) &&  objLeadData.Referral_Partner1__c!= 'Center Intake Form')
            {
                returnStr= 'Your application has been submitted successfully.';
                insert objLeadData;
            }
            if( (lstOfLeads1 !=null && lstOfLeads1.size()>0 && lstOfLeads1[0].Email != null && lstOfLeads1[0].Referral_Partner1__c != null )&& (lstOfLeads1[0].Email ==  objLeadData.Email) && (lstOfLeads1[0].Referral_Partner1__c == 'Center Intake Form') && objLeadData.Referral_Partner1__c == 'Center Intake Form')
            {
                returnStr='Your email address is duplicate. Please apply with unique email';
            }
            else if( (lstOfLeads1 == null || lstOfLeads1.size() <= 0) &&  objLeadData.Referral_Partner1__c== 'Center Intake Form' )
            {
                returnStr= 'Your application has been submitted successfully.';
                insert objLeadData;
            }
/*
        if( objLeadData.Email != null )
        {
            
            lstOfLeads =[ Select Id, Email from lead where email=:objLeadData.Email AND RecordTypeId=:RecordTypeId ]; //AND RecordType.Name='Center Leads'
            if( lstOfLeads != null && lstOfLeads.size() > 0 )
                returnStr='This email address is duplicate. Please apply with unique email';
        }   
        else //if(lstOfLeads == null || lstOfLeads.size() <= 0 )
        {
            insert objLeadData;
            returnStr= 'Your application has been submitted successfully.';
            
        }
*/
        
        system.debug('-RecordTypeId--------->'+RecordTypeId);
        system.debug('-lstOfLeads--------->'+lstOfLeads+'-----lstOfLeads.size---->'+lstOfLeads.size());
        system.debug('-returnStr--------->'+returnStr);
        return returnStr;
        
    }
       
    
    /* Rahul */
    /*  objDetail ==> leadObject  */
    @AuraEnabled 
    public static Map<String, List<String>> getDependentMap(sObject leadObject, string contrfieldApiName, string depfieldApiName) {
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        
        Schema.sObjectType objType = leadObject.getSObjectType(); //Extracting Lead
        if (objType==null){
            return objResults;
        }
        
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            return objResults;     
        }
        
        Schema.SObjectField theField = objFieldMap.get(dependentField);
        Schema.SObjectField ctrlField = objFieldMap.get(controllingField);
        
        List<Schema.PicklistEntry> contrEntries = ctrlField.getDescribe().getPicklistValues();
        List<PicklistEntryWrapper> depEntries = wrapPicklistEntries(theField.getDescribe().getPicklistValues());
        List<String> controllingValues = new List<String>();
        
        for (Schema.PicklistEntry ple : contrEntries) {
            String label = ple.getLabel();
            objResults.put(label, new List<String>());
            controllingValues.add(label);
        }
        
        for (PicklistEntryWrapper plew : depEntries) {
            String label = plew.label;
            String validForBits = base64ToBits(plew.validFor);
            for (Integer i = 0; i < validForBits.length(); i++) {
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    objResults.get(controllingValues.get(i)).add(label);
                }
            }
        }
        return objResults;
    }
    
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }
    
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';
        
        String validForBits = '';
        
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }
        
        return validForBits;
    }
    
    private static final String base64Chars = '' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        'abcdefghijklmnopqrstuvwxyz' +
        '0123456789+/';
    
    
    private static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<PicklistEntryWrapper>.class);
    }
    @AuraEnabled
    public static List <String> getPiklistValues() {
        List<String> plValues = new List<String>();
         
        //Get the object type from object name. Here I've used custom object Book.
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Lead');
         
        //Describe the sObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
         
        //Get the specific field information from field name. Here I've used custom field Genre__c of Book object.
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get('Use_of_Funds__c').getDescribe();
         
        //Get the picklist field values.
        List<Schema.PicklistEntry> picklistvalues = objFieldInfo.getPicklistValues();
         
        //Add the picklist values to list.
        for(Schema.PicklistEntry plv: picklistvalues) {
            plValues.add(plv.getValue());
        }
        plValues.sort();
        return plValues;
    }
    
    /* Fetching Custom Setting Data */
    @AuraEnabled
    public static Map<String, String> getCMD(){
        List<Zip_Code_County__c>  csList = Zip_Code_County__c.getAll().values();
         
        //Map<id, Zip_Code_County__c> csMap = new Map<id, Zip_Code_County__c>(csList);
        
        Map<String, String> csMap = new Map<String, String>();
        for(integer i=0; i<csList.size(); i++){
            csMap.put(csList[i].Zip_Code__c,csList[i].County__c);
        }
        
        return csMap;        
    }
   
    public class PicklistEntryWrapper{
        public String active {get;set;}
        public String defaultValue {get;set;}
        public String label {get;set;}
        public String value {get;set;}
        public String validFor {get;set;}
        public PicklistEntryWrapper(){            
        }
        
    }
    
    /*To Insert Data into the database */
    
    
}