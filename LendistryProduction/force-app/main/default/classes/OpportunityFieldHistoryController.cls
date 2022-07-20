public class OpportunityFieldHistoryController {
    
    @AuraEnabled
    public static list<Opportunity_Field_History__C> fetchOpportunityHistoryData( String OpportunityId) { 
        list<Opportunity_Field_History__C> newUpdatedList = new list<Opportunity_Field_History__C>();
        list<Opportunity_Field_History__C> lstOfOppHistoryData =  [ Select Id,Opportunity__c, Name,Stage_Close_Date__c, Stage_Duration_Hidden__c,Stage_Duration__c,Stage_Previous__c,Stage_New__c,Stage_Start_Date__c, LastModifiedDate,LastModifiedBy.Name, Createddate from Opportunity_Field_History__c Where Opportunity__c=:OpportunityId ORDER BY Createddate ASC];
        system.debug('******lstOfOppHistoryData*******>>'+lstOfOppHistoryData);
        Date closedateVal;
        integer numberofHolidays =0;
        for(Opportunity_Field_History__C each : lstOfOppHistoryData)
        {
                if( each.Stage_Start_Date__c != null && each.Stage_Close_Date__c != null )
                    numberofHolidays = getHoliday(each.Stage_Start_Date__c, each.Stage_Close_Date__c); 
                else
                    numberofHolidays= getHoliday(each.Stage_Start_Date__c, system.today());
                   
                each.Stage_Duration_Hidden__c = each.Stage_Duration__c;
                if( numberofHolidays != null && numberofHolidays != 0 && each.Stage_Duration_Hidden__c != 0)
                {
                    each.Stage_Duration_Hidden__c = each.Stage_Duration_Hidden__c- numberofHolidays;
                }
            
                   newUpdatedList.add(each);
            
        }
        if( newUpdatedList != null && newUpdatedList.size() >0 )
        update newUpdatedList;
        
        return newUpdatedList;
    }
        
    public static integer getHoliday( date startDate , date enddate)
    {
        integer numberofHolidays = 0;
        list<Holiday> lstofHolidays = [ Select Id, name, Activitydate from holiday where ActivityDate >=:startDate AND ActivityDate <=:enddate];
       if( lstofHolidays != null && lstofHolidays.size() >0 )
                numberofHolidays = lstofHolidays.size();
        
        return numberofHolidays;
    }
}