public without sharing  class CounsellorlListcontroller {
    @AuraEnabled
    public static list<Counseling_Session__c> fetchCounsellorList(){
        
        return [select Id, name, LeadFormula__c, Subject__c, is_intrested_in_financing__c, CreatedById, OwnerId, Lead__c from Counseling_Session__c];             
        
    }
    // get counsellor details
    @AuraEnabled
    public static String getCounsellor(String recordId){
        return [select Counsellor1__c from Counseling_Session__c where id=:recordId].Counsellor1__c;
    }
    
    //Added by Ishan
    @AuraEnabled
    Public static void UpdateCounselor(String objCScId,String recordId){
        system.debug('????????'+objCScId);
        try{
            Counseling_Session__c objcoun = new Counseling_Session__c(id=recordId);
            objcoun.Counsellor1__c = objCScId;
            //Insert Lead Record
            update objcoun; 
        }catch(Exception e){
            //get exception message
            throw new AuraHandledException(e.getMessage());
        }
        finally {
        }
    } 
    
    /* Added by Rahul B */
    
    @AuraEnabled   // Time Tracker 01
    public static Boolean saveTimeTracking1(String timeWithDate, String sessionId){
        system.debug('timeWithDatetimeWithDate'+timeWithDate);
        //Counselling_Session__c sessionobject = new Counselling_Session__c(id=sessionId);
        Time_Tracker__c trackerObj = new Time_Tracker__c();
        trackerObj.Counseling_Session__c = sessionId;  
        trackerObj.Tracking_Date__c =  Date.today();   
        //trackerObj.Tracking_TTime__c = timeWithDate;
        
        System.debug('Time Track 01 : '+timeWithDate);
        
        //String str = '2:20:45';
        String str= timeWithDate;
        String h1 = str.substringBefore(':'); //2
        String TT = str.substringAfter(':'); //20:45
        String m1 = TT.substringBefore(':'); //20
        String s1 = TT.substringAfter(':'); //45
        System.debug('h1 : '+ h1);
        System.debug('m1 : '+ m1);
        System.debug('s1 : '+ s1);
        
        Double d1 = Double.valueOf(h1); //Extracting hours
        d1=d1*1.0; //Hours- to store them in h part of h.m
        Double d2 = Double.valueOf(m1); //Extracting minutes
        //Double d2s = Double.valueOf(s1); //Extracting seconds
        //d2=d2+(d2s/60);
        d2=d2/100; //To store minutes in fractional part i.e. in m part of h.m 
        double d3 = d1+d2;
        system.debug('formated time: '+ d3 );
        trackerObj.Tracking_Time__c = d3;
        
        //sessionobject.Time_Tracker__c  = Date.today()+'::'+ timeWithDate;
        insert trackerObj;
        return true;
    } 
    
    
    @AuraEnabled   /* Time Tracker 03 */
    public static Boolean saveTimeTracking3(String timeInHH, String timeInMM, String sessionId){
        system.debug('Time IN hours: '+timeInHH);
        system.debug('Time IN Minutes: '+timeInMM);
        Double d1 = Double.valueOf(timeInHH);
        d1=d1*1.0;
        Double d2 = Double.valueOf(timeInMM);
        d2=d2/100;
        double d3 = d1+d2;
        system.debug('formated time: '+ d3 );
        
        //string hhmm = timeInHH+'.'+timeInMM;
        //Integer Nhhmm = Integer.valueOf(hhmm); 
        
        
        
        //system.debug('Time IN Minutes: '+hhmm );
        //system.debug('Time IN Minutes: '+Nhhmm );
        //Counselling_Session__c sessionobject = new Counselling_Session__c(id=sessionId);
        Time_Tracker__c trackerObj = new Time_Tracker__c();
        trackerObj.Counseling_Session__c = sessionId;  
        trackerObj.Tracking_Date__c =  Date.today();   
        
        //trackerObj.Tracking_Time_Text__c = Nhhmm;
        //trackerObj.Tracking_Time__c =  Nhhmm;
        trackerObj.Tracking_Time__c =  d3;
        //sessionobject.Time_Tracker__c  = Date.today()+'::'+ timeWithDate;
        insert trackerObj;
        return true;
    } 
    
    
    @AuraEnabled   // Time Tracker 01
    public static Boolean trackRecordedTime (String hour, String minute, String second, String parentRecordID){
        //string strTimeTrack = hour +'.'+ minute;
        Double d1 = Double.valueOf(hour);
        d1=d1*1.0;
        Double d2 = Double.valueOf(minute);
        d2=d2/100;
        double d3 = d1+d2;
        //system.debug('formated time: '+ d3 );
        
        Time_Tracker__c objTimeTracking = new Time_Tracker__c();
        objTimeTracking.Counseling_Session__c = parentRecordID;
        objTimeTracking.Tracking_Date__c = system.today();
        
        objTimeTracking.Tracking_Time__c = d3;
        
        //objTimeTracking.Tracking_Time__c = decimal.valueOf(strTimeTrack) ;
        insert objTimeTracking;
        //system.debug('-strTimeTrack-->'+strTimeTrack +'--minute-->'+minute+'--parentRecordID-->'+parentRecordID);
        return true;
    } 
         @AuraEnabled 
    public static boolean stopSessionTemp (string LogInUserID ){
                system.debug('--sessionStopTime--->>');

        DateTime StopTime = system.now();
        
        System.debug('Inside Session Stop time');
        list<Counselor_Login_Hours__c> EndTime= [select id,Total_Temp_Time__c from Counselor_Login_Hours__c 
                                                 where Start_Time__c != null AND End_Time__c = null AND Counselor__c=:LogInUserID
                                                 order By Createddate desc LIMIT 1 ] ;
        system.debug('Value of EndTime: --->'+EndTime);
        if( EndTime != null && EndTime.size() > 0 && ( EndTime[0].Total_Temp_Time__c ==null || EndTime[0].Total_Temp_Time__c < 1)){
        
            Counselor_Login_Hours__c objCounselorLoginHours = new Counselor_Login_Hours__c (Id = EndTime[0].id);
            objCounselorLoginHours.Temp_End_Time__c = StopTime;
                    
            Update objCounselorLoginHours; 
        }
        return true;
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

    @AuraEnabled
    public static String returnSessionStartTime(string LogInUserID){
        System.debug('Method returnSessionStartTime called from Timer');
                String MySessionID = UserInfo.getSessionID();

        DateTime StopTime = system.now();
        list<Counselor_Login_Hours__c> StartTime= [select id,Start_Time__c,Session_ID__c from Counselor_Login_Hours__c 
                                                   where Start_Time__c != null AND End_Time__c=null  AND Counselor__c=:LogInUserID
                                                   order By Createddate desc LIMIT 1 ] ;
        //System.debug('Data returned from timer method: '+string.valueOf((StartTime[0].Start_Time__c).format('hh:mm:ss a')));
        if(StartTime !=null && StartTime.size()>0 && MySessionID == StartTime[0].Session_ID__c){
            Return string.valueOf((StartTime[0].Start_Time__c));
        }
        else{
            System.debug('Method InsertStartSession called from Else Body ');
            CounsellorlListcontroller.InsertStartSession(LogInUserID);
            Return string.valueOf(StopTime);
        }
       
    }
    public static void InsertStartSession (string LogInUserID ){
        system.debug('--insertSessionStartTime--->>');
        DateTime StartTimeTemp = system.now();
        String MySessionID = UserInfo.getSessionID();
        if( LogInUserID != null && LogInUserID != '')
        {
            user objUser = [ Select id, ContactId from user where id=:LogInUserID limit 1];
            list<Counselor_Login_Hours__c> StartTime= [select id, Session_ID__c from Counselor_Login_Hours__c 
                                                   where End_Time__c = null AND Counselor__c=:LogInUserID order By Createddate desc LIMIT 1 ] ;
       
        system.debug('SessionStartTime:--> '+StartTimeTemp);
        if(StartTime.size() > 0 && MySessionID == StartTime[0].Session_ID__c){
            
            Counselor_Login_Hours__c objCounselorLoginHours = new Counselor_Login_Hours__c(id=StartTime[0].id);
            objCounselorLoginHours.Temp_End_Time__c = System.now();
            //objCounselorLoginHours.Counselor_Contact__c= objUser.ContactId; 
            //objCounselorLoginHours.Start_Time__c = DateTime.Valueof(StartTimeTemp);
            //objCounselorLoginHours.Session_ID__c= MySessionID;sessionStopTime
            update objCounselorLoginHours;
        } 
         System.debug('########LogInUserID###### '+LogInUserID);
         if(StartTime.size() > 0 && MySessionID != StartTime[0].Session_ID__c){
            Counselor_Login_Hours__c objCounselorLoginHours = new Counselor_Login_Hours__c();
            objCounselorLoginHours.Counselor__c = LogInUserID;
            objCounselorLoginHours.Counselor_Contact__c= objUser.ContactId; 
            objCounselorLoginHours.Start_Time__c = DateTime.Valueof(StartTimeTemp);
            objCounselorLoginHours.Session_ID__c= MySessionID;
            Insert objCounselorLoginHours;
            System.debug('############## '+objCounselorLoginHours);
            
        } 
         System.debug('########LogInUserID11###### '+LogInUserID);
         System.debug('########objUser.ContactId###### '+objUser.ContactId);
         System.debug('########DateTime.Valueof(StartTimeTemp)###### '+DateTime.Valueof(StartTimeTemp));
         System.debug('########MySessionID###### '+MySessionID);
         System.debug('########StartTime.size()###### '+StartTime.size());
        if(StartTime.size() == 0 ){
            Counselor_Login_Hours__c objCounselorLoginHours = new Counselor_Login_Hours__c();
            objCounselorLoginHours.Counselor__c = LogInUserID;
            objCounselorLoginHours.Counselor_Contact__c= objUser.ContactId; 
            objCounselorLoginHours.Start_Time__c = DateTime.Valueof(StartTimeTemp);
            objCounselorLoginHours.Session_ID__c= MySessionID;
            Insert objCounselorLoginHours;
            
        } 
      }
        
    }
   
}