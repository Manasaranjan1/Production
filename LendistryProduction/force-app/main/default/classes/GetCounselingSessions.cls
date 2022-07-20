public class GetCounselingSessions {
    public List<Counseling_Session__c> csList {get;set;}
    
    //public List<double> totalCTime{get;set;}
    //public List<List<Counseling_Session__c>> CSnames{get;set;}
    
      public List<wrapCSList> wList = new List<wrapCSList>(); 
    
    
      public List<double> totalTime{get;set;}
      public List<List<Counseling_Session__c>> listofCS{get;set;}
    
    public GetCounselingSessions() { 
        csList = [select id, Counsellor1__c, Counsellor_Name__c,Name, CS_Hours__c, CS_Minutes__c, Cumulative_Time2__c from Counseling_Session__c];
        //processList();
        getCSSnames();
    }
    public void getCSSnames(){
        set<string> setofCName = new set<string>();
        for (Counseling_Session__c cs: csList ){
            setofCName.add(cs.Counsellor_Name__c);
        }
        List<string> listofCName = new List<string>(setofCName);
        //System.debug(listofCName[0]);
        Map<integer, string> lmap = new Map<integer, string>();
        for(integer i=0;i<listofCName.size();i++){
            lmap.put(i,listofCName[i]);
        }
          
        List<List<Counseling_Session__c>> CSnames = new List<List<Counseling_Session__c>>{};  //********   
       //public List<List<Counseling_Session__c>> CSnames{get;set;}    
        for(integer i=0;i<listofCName.size();i++ ) {            
          List<Counseling_Session__c> nms = new List<Counseling_Session__c>();
          for (Counseling_Session__c cs: csList ){
              if(lmap.get(i)  == cs.Counsellor_Name__c){
                    nms.add(cs);
              }              
          } 
          CSnames.add(nms);  
          //nms.clear();
        } 
        System.debug('******** CSnames : '+CSnames);
        listofCS = CSnames;
        System.debug('******** listofCS : '+listofCS); 
        findTotalCTime(CSnames);
              //return(CSnames);
    }
    
    public void findTotalCTime(List<List<Counseling_Session__c>> CSSnames){
       
        
        //System.debug('******'+listOfCSnames.size());
        List<double> totalCTime = new List<double>();
        //List<double> totalCTime{get;set;}                    //********
        for (integer i=0; i<CSSnames.size();i++){
           System.debug('List '+(i+1)+''+CSSnames[i]);
            Double sumOfhours=0.0;
            Double sumOfminutes=0.0;
           for(Counseling_Session__c cs: CSSnames[i]) {
               sumOfminutes = sumOfminutes + (cs.CS_Minutes__c)*1.0; 
               sumOfhours = sumOfhours + (cs.CS_Hours__c)*1.0;
           }
           double cumulatedTime = sumOfHours*1.0 + Integer.valueOf(sumOfMinutes/60)*1.0 + Double.valueOf(System.math.mod(Integer.valueOf(sumOfMinutes),60))/100; 
         //  System.debug('@@@@@@@@@@@@@@@@@@');
          // System.debug('$$$$ : '+cumulatedTime);
           totalCTime.add(cumulatedTime); 
        }
        System.debug('@@@@@@@  totalCTime :'+totalCTime);
        totalTime=totalCTime;
        System.debug('@@@@@@@ totalTime :'+totalTime);
        //return(totalCTime);
                
    }
    
    public List<wrapCSList> getWrapList(){
        for (integer i=0; i<totalTime.size();  i++){
            wList.add(new wrapCSList(totalTime[i], listofCS[i]));
        }
        
        return wList;
    }
    
    public class wrapCSList {
        public double tTime{get;set;}
        public List<Counseling_Session__c> CSList{get;set;}
        public wrapCSList(double t, list<Counseling_Session__c> csl){
            this.tTime = t;
            this.CSList = csl; 
        }
        
    }
    
    
}