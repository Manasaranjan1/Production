trigger SharingTriggerforcounselingsession on Counseling_Session__c (after insert,after update) {
     
     List<Counseling_Session__Share> shareuser = new List<Counseling_Session__Share>();
     // for insert
     if(Trigger.isInsert && Trigger.isAfter ){
        for(Counseling_Session__c CS : trigger.new){
           if(CS.Counsellor1__c !=null  ){
                Counseling_Session__Share Counselorshare = new Counseling_Session__Share();
                Counselorshare.ParentId = CS.Id;
                Counselorshare.UserOrGroupId = CS.Counsellor1__c;
                Counselorshare.AccessLevel = 'edit';           
                Counselorshare.RowCause = Schema.Counseling_Session__Share.RowCause.Manual;//Schema.Counseling_Session__Share.RowCause.Manual;
                shareuser.add(Counselorshare);
            }        
        }   
    }
     // for update
     if(Trigger.isUpdate && Trigger.isAfter ){
        for(Counseling_Session__c CS : trigger.new){
            Counseling_Session__c oldCS = Trigger.oldMap.get(CS.Id);
            if(CS.Counsellor1__c !=null && oldCS.Counsellor1__c != CS.Counsellor1__c ){
                Counseling_Session__Share Counselorshare = new Counseling_Session__Share();
                Counselorshare.ParentId = CS.Id;
                Counselorshare.UserOrGroupId = CS.Counsellor1__c;
                Counselorshare.AccessLevel = 'edit';           
                Counselorshare.RowCause = Schema.Counseling_Session__Share.RowCause.Manual;//Schema.Counseling_Session__Share.RowCause.Manual;
                shareuser.add(Counselorshare);
            }        
        }   
    }
    if(shareuser !=null && shareuser.size()>0)
        Database.SaveResult[] jobShareInsertResult = Database.insert(shareuser,false);
}