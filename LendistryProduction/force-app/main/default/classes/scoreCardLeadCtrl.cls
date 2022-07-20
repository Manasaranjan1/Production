public class scoreCardLeadCtrl {
    
    public ScoreCard__c objScoreCard { get; set; }
    
    public Lead objLead;
    public string strRecordId;
    public ScoreCardSettings__c objCustomSetting;
    public static string fieldSetName ;
    public static string objectName = 'ScoreCard__c';
    
    public scoreCardLeadCtrl( ApexPages.StandardController controller ) {
        strRecordId = ApexPages.currentPage().getParameters().get('id');
        if( strRecordId != null && strRecordId != '')
        {
            try{
            objLead = [ Select id, Loan_Type__c from Lead Where id=:strRecordId];
            if(objLead.Loan_Type__c != null )
                this.objCustomSetting  = ScoreCardSettings__c.getValues(objLead.Loan_Type__c);   
            fieldSetName = string.valueof(objCustomSetting.FieldSetName__c);
                if( fieldSetName != null || fieldSetName != '')
            objScoreCard =  getScoreCard(strRecordId);
            
        }
        
        catch(Exception e){
                //Handle exception here
            }
        }
        
    }
    
public static List<Schema.FieldSetMember> getfields(){
    if( objectName != null && objectName != '' && fieldSetName != null && fieldSetName != '')
    {
            Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
        return fieldSetObj.getFields();
    }
    else
    {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'ScoreCard table has not been enabled for this loan type.')); 
        return null;
        
    }
}
    
@TestVisible    
    private static ScoreCard__c getScoreCard( string recordID ) {
        String query = 'SELECT ';
        for(Schema.FieldSetMember f : getFields()) {
            query += f.getFieldPath() + ', ';
        }
        query += ' id  FROM ScoreCard__c Where ( Lead__c='+'\''+ recordID +'\'' + 'OR Opportunity__c='+'\''+ recordID +'\''+')'+' limit 1'  ;
        
        list<ScoreCard__c> objResult =  Database.query(query);
        System.debug('--objResult------->>'+Database.query(query));
        if( objResult != null && objResult.size() > 0 )
            return objResult[0];
        else
            return null;
        
        
    }
}