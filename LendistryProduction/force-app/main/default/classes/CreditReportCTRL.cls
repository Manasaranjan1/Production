public class CreditReportCTRL {
	@AuraEnabled
    public static Map<String,Boolean> CheckCreditField(String LeadId){
        
        List<String> Fields = new List<String>();
        Fields.add(String.valueOf('FirstName').toLowerCase());
        Fields.add(String.valueOf('LastName').toLowerCase());
        Fields.add(String.valueOf('SSN1__c').toLowerCase());
        Fields.add(String.valueOf('Street').toLowerCase());
        Fields.add(String.valueOf('City').toLowerCase());
        Fields.add(String.valueOf('State').toLowerCase());
        Fields.add(String.valueOf('Country').toLowerCase());
        Fields.add(String.valueOf('Postalcode').toLowerCase());
        
        //Use Schema for get Lead Field API with Lable Name
        Map<String,String> fieldAPILabel = new Map<String,String>();
        Map<String,SObjectField> fList = schema.getGlobalDescribe().get('Lead').getDescribe().fields.getMap();
        for(String FieldApi: fList.keySet()){
           String FieldApiName = FieldApi.toLowerCase();
           if(Fields.contains(FieldApiName))
                fieldAPILabel.put(FieldApiName, fList.get(FieldApi).getDescribe().getLabel());            
        }
        System.debug('$$$fieldAPILabel$$$$$$$$$$ '+fieldAPILabel);
        Map<String,Boolean> objLeadLabelValue = new Map<String,Boolean>();
        String query = ' SELECT ' + String.join(Fields,', ') + ' FROM Lead WHERE id = :LeadId';
        List<SObject> records = Database.query( query ); //Query Lead Records
        System.debug('$$$$$$$$$$records$$$$$$ '+records);
        for(SObject obj: records) {
            for(String LeadField : Fields){
                Boolean isNull = false;
                String fieldValue = String.valueOf(obj.get(LeadField));
                if(String.isBlank(fieldValue)){
                    isNull = true;
                }
                System.debug('$$$$$$$$$44 '+fieldAPILabel.get(LeadField)+' ######### '+fieldValue+' ######### '+isNull);
                objLeadLabelValue.put(fieldAPILabel.get(LeadField),isNull);
            }
        }
        return objLeadLabelValue;
    }
}