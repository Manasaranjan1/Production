public class CalculateDuration_batch_cls {

   public static void updateDuration( list<Opportunity_Field_History__C>  lstOfOppHistory)
   {
       integer numberofHolidays =0;
       list<Opportunity_Field_History__C> newUpdatedList = new list<Opportunity_Field_History__C>();
       for(Opportunity_Field_History__C each : lstOfOppHistory)
       {
           if( each.Stage_Start_Date__c != null && each.Stage_Close_Date__c != null )
               numberofHolidays = getHoliday(each.Stage_Start_Date__c, each.Stage_Close_Date__c); 
           else
               numberofHolidays= getHoliday(each.Stage_Start_Date__c, system.today());
           
           if( numberofHolidays != null && numberofHolidays != 0 && each.Stage_Duration_Hidden__c != 0)
           {
               each.Stage_Duration_Hidden__c = each.Stage_Duration_Hidden__c- numberofHolidays;
           }
           newUpdatedList.add(each);
           
       }
       system.debug('*******newUpdatedList******>>'+newUpdatedList);
       
        update newUpdatedList;
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