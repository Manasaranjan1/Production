public with sharing class OffenseTriggerHandler {
    
    public static boolean isBeforeTriggerRan = false;
   
    public static Set<String> setOffensesToValidate {
                        get{
                            if(setOffensesToValidate ==null || (setOffensesToValidate != null && setOffensesToValidate.isEmpty())) {
                                setOffensesToValidate = new Set<String>();
                                List<Offence_to_Validate__c> ValidateDescription = [Select Id, Description__c, Type_Of_Program__c from Offence_to_Validate__c where isActive__c = true];
                                for(Offence_to_Validate__c oRecord : ValidateDescription) {
                                    setOffensesToValidate.add(oRecord.Description__c);
                                }
                            }
                            return setOffensesToValidate;
                        } 
                        private set;
    }
    
    public static void beforeTrigger(List<criminalreports__Offense__c> ListNewRecords) {
        validateOffenses(ListNewRecords);
    }

    private static void validateOffenses(List<criminalreports__Offense__c> ListNewRecords) {
        Date d3years = System.today().addYears(-3);
        for(criminalreports__Offense__c oRecord : ListNewRecords) {
            system.debug( 'oRecord.criminalreports__Description__c :::'+oRecord.criminalreports__Description__c);
            system.debug( 'oRecord.criminalreports__Offense_Date__c :::'+oRecord.criminalreports__Offense_Date__c);
        
            if( String.isNotBlank(oRecord.criminalreports__Description__c) && setOffensesToValidate != null && setOffensesToValidate.contains(oRecord.criminalreports__Description__c) && (oRecord.criminalreports__Offense_Date__c == null || (oRecord.criminalreports__Offense_Date__c != null && oRecord.criminalreports__Offense_Date__c >= d3years ))) {
                oRecord.Grant_NYC_Validation__c = true;
            }
        }
    }
}