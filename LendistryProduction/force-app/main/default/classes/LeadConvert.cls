public class LeadConvert implements Schedulable{
    
    public List<Lead> newLead{set;get;}
   /* @InvocableMethod
    public static void LeadConvertPB(List<Lead> newLeadIds){
        System.debug('##########newLeadIds######## '+newLeadIds);
        LeadConvert sc = new LeadConvert(newLeadIds);
        Datetime dt = (Datetime.now()).addMinutes(2);
        String timeForScheduler = dt.format('s m H d M \'?\' yyyy');
        Id schedId = System.Schedule('Lead Convert '+timeForScheduler,timeForScheduler,sc);
         
    }*/
    public LeadConvert(List<Lead> newLeadIds,Map<Id,Lead> objLeadMap){
        this.newLead = newLeadIds;
    }
    public void execute(SchedulableContext SC) {
      OnAfterInsert();
    }
    public void OnAfterInsert() {
        List<Lead> objLeadGQList = new List<Lead>();
        List<Lead> objLeadPCList = new List<Lead>();
        String GQRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('General Questions Contact Form').getRecordTypeId();
        String PCRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Partnership Contact Form').getRecordTypeId();
        System.debug('#############@@@@@@@@@2222'+newLead);
        for(Lead objLead : newLead){
            if(objLead.RecordTypeId == GQRecordTypeID){
                objLeadGQList.add(objLead);
            }
            if(objLead.RecordTypeId == PCRecordTypeID){
                objLeadPCList.add(objLead);
            }
        }
        LeadStatus convertStatus = [SELECT Id, MasterLabel, IsConverted FROM LeadStatus WHERE IsConverted=true limit 1];
        if(objLeadGQList.size() > 0){ 
           List<Database.LeadConvert> leadConvertsGQ = new List<Database.LeadConvert>();
           for(Lead objLead : objLeadGQList){
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(objLead.Id);
                lc.setAccountId(System.Label.DefaultAccount);
                lc.setDoNotCreateOpportunity(true);
                lc.setConvertedStatus(convertStatus.MasterLabel);
                leadConvertsGQ.add(lc);
            }
           if(leadConvertsGQ.size() > 0){
               Database.convertLead(leadConvertsGQ);
               System.debug('############ '+leadConvertsGQ);
           }
        }
        
        if(objLeadPCList.size() > 0){ 
           List<Database.LeadConvert> leadConvertsPC = new List<Database.LeadConvert>();
           for(Lead objLead : objLeadPCList){
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(objLead.Id);
                lc.setDoNotCreateOpportunity(true);
                lc.setConvertedStatus(convertStatus.MasterLabel);
                leadConvertsPC.add(lc);
            }
           if(leadConvertsPC.size() > 0){
               Set<Id> objSetConIds = new Set<Id>();
               Database.LeadConvertResult[] lcrList = Database.convertLead(leadConvertsPC);
               for(Database.LeadConvertResult lcr : lcrList){
                   objSetConIds.add(lcr.getContactId());
               }
               if(objSetConIds.size() > 0){
                   List<Contact> objConList = [Select Id from Contact where Id IN : objSetConIds];
                   Delete objConList;
               }
           }
        }
        
    }
}