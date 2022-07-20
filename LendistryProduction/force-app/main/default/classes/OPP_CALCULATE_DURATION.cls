public class OPP_CALCULATE_DURATION {
   
    public static boolean isexecuting = false;
    public static List<Opportunity_Field_History__c> opphistory_withduration= new List<Opportunity_Field_History__c>();
    PUBLIC static LIst<Opportunity> opt_updated_with_duration = new List<Opportunity>();
    public static List<Opportunity_Field_History__c> sorted_opphistory= new List<Opportunity_Field_History__c>();
    public static date start_dt, end_dt, start_dt_prev,end_dt_prev ;
    public static string stage_process, stage_process_prev, opp_process, opp_process_prev;
    public static Set<date> getHolidaysdate(){
        Set<date> holidateDates = new Set<date>();
        List<Holiday> listHoliday= [Select ID,Activitydate  From Holiday];
        for(Holiday days: listHoliday){
           holidateDates.add(days.ActivityDate);
        }
        return holidateDates;
    }
    
    public static void calling_duration(List<Opportunity> Out2)
    {
        Set<date> holidays = getHolidaysdate();
        if(isexecuting == true){
            return;
        }
        isexecuting = true;
        list<Opportunity_Field_History__c> aggropplst= [select  Stage_Start_Date__c,stage_new__C,Stage_close_date__c,
                                                        Opportunity__c, ID from Opportunity_Field_History__c where
                                                        opportunity__c in :Out2  ORDER BY Opportunity__c,stage_new__C, Stage_Start_Date__c asc ]; 
       
        for (Opportunity_Field_History__c oc: aggropplst )
        {
            Opportunity_Field_History__c sorted_oh = new Opportunity_Field_History__c();
            start_dt = oc.Stage_Start_Date__c;
            end_dt = oc.Stage_Close_Date__c;
            stage_process =  oc.Stage_New__c;
            opp_process = oc.Opportunity__c;
            if(stage_process != stage_process_prev ||  opp_process  != opp_process_prev )
            {//reseting values for new process
                start_dt_prev = null;
                end_dt_prev = null;
                
            }
            if ((start_dt > start_dt_prev &&   end_dt > end_dt_prev && start_dt > end_dt_prev) || (start_dt_prev == null))
            {   
                sorted_oh.Stage_Start_Date__c = start_dt;
                sorted_oh.Stage_Close_Date__c = end_dt;
                sorted_oh.Opportunity__c = oc.Opportunity__c;
                sorted_oh.Stage_New__c = oc.Stage_New__c;
                sorted_opphistory.add(sorted_oh);
            }
            else if((start_dt > start_dt_prev &&   end_dt > end_dt_prev && start_dt < end_dt_prev) || (start_dt_prev == null))
            {
                sorted_oh.Stage_Start_Date__c = end_dt_prev;
                sorted_oh.Stage_Close_Date__c = end_dt;
                sorted_oh.Opportunity__c = oc.Opportunity__c;
                sorted_oh.Stage_New__c = oc.Stage_New__c;
                sorted_opphistory.add(sorted_oh);
            }
            else if(start_dt == start_dt_prev && end_dt> end_dt_prev  )
            {
                sorted_oh.Stage_Start_Date__c = end_dt_prev ;
                sorted_oh.Stage_Close_Date__c = end_dt;
                
                sorted_oh.Opportunity__c = oc.Opportunity__c;
                sorted_oh.Stage_New__c = oc.Stage_New__c;
                
                sorted_opphistory.add(sorted_oh);
            }
            start_dt_prev = oc.Stage_Start_Date__c;
            if (end_dt_prev < oc.Stage_Close_Date__c || end_dt_prev == null)
            {end_dt_prev = oc.Stage_Close_Date__c;}
            stage_process_prev = oc.Stage_New__c;
            opp_process_prev = oc.Opportunity__c;
        }
        
        for (Opportunity_Field_History__c k : sorted_opphistory)
        { 
            integer TotalNoofHolidays = 0;
            decimal TotalDuration = 0;
            date st_dt, cl_dt;
            decimal duration = 0;
            decimal ExactDuration =0;
            integer numOfHolidays = 0;
            st_dt=k.Stage_Start_Date__c;
            cl_dt = k.Stage_Close_Date__c;
            if (cl_dt == null)
            {
                cl_dt = date.today();
            }
            
            Duration = calculateWorkingDays(st_dt, cl_dt);
            
            // Call function to calculate holiday
            if (Duration > 0 ){
                numOfHolidays = holidaysmethod(st_dt,cl_dt,holidays);
            }
            else
            { numOfHolidays = 0;
            }
            
            ExactDuration = duration - numOfHolidays;
            fill_opportunity(k, ExactDuration);
            system.debug('Exact No of days in Stage: '+ExactDuration );
        }
        update  opt_updated_with_duration;
    }
    
    
    public static void fill_opportunity(Opportunity_Field_History__c k, decimal ExactDuration)
    {
        boolean exist = false;
        for(Opportunity o1: opt_updated_with_duration)
        {
            
            Opportunity o_fill = new Opportunity();
            if(o1.id == k.Opportunity__c)
            {
                exist = true;
            }
            else { exist = false; }
            
        }
        if (exist == true)
        {
            
            for(Opportunity o1: opt_updated_with_duration)
            {
                if ( o1.id == k.Opportunity__c)
                {
                    if(k.Stage_New__c == 'Sales Review'){
                        if (o1.Days_in_Sales_Review__c == NULL)
                        {
                            o1.Days_in_Sales_Review__c =0; 
                        }
                        o1.Days_in_Sales_Review__c =  o1.Days_in_Sales_Review__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'PreQual Out'){
                        if (o1.Days_in_PreQual_Out__c == NULL)
                        {
                            o1.Days_in_PreQual_Out__c =0; 
                        }
                        o1.Days_in_PreQual_Out__c = o1.Days_in_PreQual_Out__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'Processing Sub'){
                        if (o1.Days_in_Processing_Sub__c == NULL)
                        {
                            o1.Days_in_Processing_Sub__c =0; 
                        }
                        o1.Days_in_Processing_Sub__c =  o1.Days_in_Processing_Sub__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'UW Sub'){
                        if (o1.Days_in_UW_Sub__c == NULL)
                        {
                            o1.Days_in_UW_Sub__c =0; 
                        }
                        o1.Days_in_UW_Sub__c =  o1.Days_in_UW_Sub__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'CON APP OUT'){
                        if (o1.Days_in_CON_APP_OUT__c == NULL){ o1.Days_in_CON_APP_OUT__c =0; }
                        o1.Days_in_CON_APP_OUT__c =  o1.Days_in_CON_APP_OUT__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'Packaging'){if (o1.Days_in_Packaging__c == NULL) { o1.Days_in_Packaging__c =0; }
                        o1.Days_in_Packaging__c =  o1.Days_in_Packaging__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'UW'){
                        if (o1.Days_in_UW__c == NULL)
                        {
                            o1.Days_in_UW__c =0; 
                        }
                        o1.Days_in_UW__c =  o1.Days_in_UW__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'Sub for Review'){ if (o1.Days_in_Sub_for_Review__c == NULL) { o1.Days_in_Sub_for_Review__c =0;  } o1.Days_in_Sub_for_Review__c =  o1.Days_in_Sub_for_Review__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'Sub for Approval'){ if (o1.Days_in_Sub_for_Approval__c == NULL) { o1.Days_in_Sub_for_Approval__c =0;  } o1.Days_in_Sub_for_Approval__c =  o1.Days_in_Sub_for_Approval__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'CL Out'){ if (o1.Days_in_CL_Out__c == NULL) { o1.Days_in_CL_Out__c =0;  } o1.Days_in_CL_Out__c =  o1.Days_in_CL_Out__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'Docs Out'){ if (o1.Days_in_Docs_Out__c == NULL) { o1.Days_in_Docs_Out__c =0;  } o1.Days_in_Docs_Out__c =  o1.Days_in_Docs_Out__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'Pending for Closing'){ if (o1.Days_in_Pending_for_Closing__c == NULL) { o1.Days_in_Pending_for_Closing__c =0;  } o1.Days_in_Pending_for_Closing__c =  o1.Days_in_Pending_for_Closing__c + ExactDuration;
                    }
                    if(k.Stage_New__c == 'Suspended'){ if (o1.Days_in_Suspended__c == NULL) { o1.Days_in_Suspended__c =0;  } o1.Days_in_Suspended__c =  o1.Days_in_Suspended__c + ExactDuration;
                    }
                    // Commenting Missed Opp so that no Calculation runs when stage is Missed Opp
                    //if(k.Stage_New__c == 'Missed Opp'){ if (o1.Days_in_Missed_Opp__c == NULL) { o1.Days_in_Missed_Opp__c =0;  } o1.Days_in_Missed_Opp__c =  o1.Days_in_Missed_Opp__c + ExactDuration;
                   // }
                    // Commenting Funded so that no Calculation runs when stage has been in Funded
                    //if(k.Stage_New__c == 'Funded'){ if (o1.Days_in_Funded__c == NULL) { o1.Days_in_Funded__c =0;  } o1.Days_in_Funded__c =  o1.Days_in_Funded__c + ExactDuration;
                    //}
                }
                
            }
        }
        else
        {
            Opportunity o_fill = new Opportunity();
            o_fill.id = k.Opportunity__c;
            if(k.Stage_New__c == 'Sales Review'){ o_fill.Days_in_Sales_Review__c = ExactDuration; } 
            if(k.Stage_New__c == 'PreQual Out'){ o_fill.Days_in_PreQual_Out__c = ExactDuration; } 
            if(k.Stage_New__c == 'Processing Sub'){ o_fill.Days_in_Processing_Sub__c = ExactDuration;  }  
            if(k.Stage_New__c == 'UW Sub'){ o_fill.Days_in_UW_Sub__c = ExactDuration; }
            if(k.Stage_New__c == 'CON APP OUT'){o_fill.Days_in_CON_APP_OUT__c = ExactDuration; }
            if(k.Stage_New__c == 'Packaging'){o_fill.Days_in_Packaging__c = ExactDuration; }
            if(k.Stage_New__c == 'UW'){o_fill.Days_in_UW__c = ExactDuration; }
            if(k.Stage_New__c == 'Sub for Review'){o_fill.Days_in_Sub_for_Review__c = ExactDuration; }
            if(k.Stage_New__c == 'Sub for Approval'){o_fill.Days_in_Sub_for_Approval__c = ExactDuration; }
            if(k.Stage_New__c == 'CL Out'){ o_fill.Days_in_CL_Out__c = ExactDuration; }
            if(k.Stage_New__c == 'Docs Out'){o_fill.Days_in_Docs_Out__c = ExactDuration; }
            if(k.Stage_New__c == 'Pending for Closing'){o_fill.Days_in_Pending_for_Closing__c = ExactDuration; }
            if(k.Stage_New__c == 'Suspended'){o_fill.Days_in_Suspended__c  = ExactDuration; }
            if(k.Stage_New__c == 'Missed Opp'){o_fill.Days_in_Missed_Opp__c = ExactDuration; }
            // Commenting Funded so that no Calculation runs when stage has been in Funded
            //if(k.Stage_New__c == 'Funded'){o_fill.Days_in_Funded__c = ExactDuration; }

            opt_updated_with_duration.add(o_fill);   
        } 
    }

    public static Integer holidaysmethod (Date start_date, date close_date, Set<date> holidays){
        if (close_date == null)
            {
                close_date = date.today();
            }
        Integer numOfHolidays = 0;
        for(date dt: holidays){
            if(Date.valueOf(start_date) <= Date.valueOf(dt) && Date.valueOf(close_date) >= Date.valueOf(dt)){
                if(numOfHolidays == 0){
                    numOfHolidays = 1;    
                }
                else{
                    numOfHolidays++;
                }   
            }
        }
        return numOfHolidays;
    }
    
    public static Integer calculateWorkingDays(Date startDate, Date endDate)  
    {    
        if (endDate == null)
            {
                endDate = date.today();
            }
        Set<Date> holidaysSet = new Set<Date>();  
        Integer workingDays = 0;
        for(integer i=0; i <= startDate.daysBetween(endDate); i++)  
        {  
            Date dt = startDate + i;  
            DateTime currDate = DateTime.newInstance(dt.year(), dt.month(), dt.day());  
            String todayDay = currDate.format('EEEE');  
            if(todayDay != 'Saturday' && todayDay !='Sunday' )  
            {  
                workingDays = workingDays + 1;  
            }      
        }  
        if(workingDays!= 0){
            workingDays=workingDays-1;
        }
        return workingDays ;  
    }   
}