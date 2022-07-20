public class UserTriggerHandler {
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    public static boolean IsFromBachJob ;
    public static boolean isFromUploadAPI=false;
    
    public UserTriggerHandler(boolean isExecuting, integer size)
    {
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    public void OnAfterInsert(List<User> newUser)
    {
         List<GroupMember> NonCallCenterGMlist = new List<GroupMember>();
         List<GroupMember> CallCenterGMlist = new List<GroupMember>();
        
        for(User U : newUser ) {
        if(U.isActive && U.Is_Call_Center_User__c) {
            GroupMember GM = new GroupMember();
            GM.GroupId = System.Label.Call_Center_Public_Group; 
            GM.UserOrGroupId = U.Id;
            CallCenterGMlist.add(GM);        
        }
         if(U.isActive && U.Is_Call_Center_User__c == false ) {
            GroupMember GM = new GroupMember();
            GM.GroupId = System.Label.Non_Call_Center_Public_Group; 
            GM.UserOrGroupId = U.Id;
            NonCallCenterGMlist.add(GM);    
        }
    }
    if(!CallCenterGMlist.isEmpty()) {
        System.debug('CallCenterGMlist  Group Member List is ' + CallCenterGMlist );
        insert CallCenterGMlist ;
    }
    if(!NonCallCenterGMlist.isEmpty()) {
        System.debug('NonCallCenterGMlist Group Member List is ' + CallCenterGMlist );
        insert NonCallCenterGMlist;
    }
   
    commonUserAPICall();
    }
    
    public void OnAfterUpdate( List<User> newUser, Map<ID, user> oldUserMap ){
         list<GroupMember> ListgroupMemberDel = new list<GroupMember>();
         List<GroupMember> NonCallCenterGMlist = new List<GroupMember>();
         List<GroupMember> CallCenterGMlist = new List<GroupMember>();
         set<string> setOfUserIds = new set<string>();
        
        for(User U : newUser ) {
            User oldUser = oldUserMap.get(U.Id);
            if(U.isActive && oldUser.Is_Call_Center_User__c != U.Is_Call_Center_User__c && U.Is_Call_Center_User__c) {
                GroupMember GM = new GroupMember();
                GM.GroupId = System.Label.Call_Center_Public_Group; 
                GM.UserOrGroupId = U.Id;
                CallCenterGMlist.add(GM);
                setOfUserIds.add(oldUser.id);        
            }
             if(U.isActive && oldUser.Is_Call_Center_User__c != U.Is_Call_Center_User__c && U.Is_Call_Center_User__c == false ) {                
                GroupMember GM = new GroupMember();
                GM.GroupId = System.Label.Non_Call_Center_Public_Group; 
                GM.UserOrGroupId = U.Id;
                NonCallCenterGMlist.add(GM);
                setOfUserIds.add(oldUser.id);    
            }
    }
    
        if( setOfUserIds != null && setOfUserIds.size() > 0 )
        {
        system.debug('setOfUserIds ----------->>'+setOfUserIds );
            
           ListgroupMemberDel = [select Id, UserOrGroupId from GroupMember where ( GroupId=:System.Label.Call_Center_Public_Group OR GroupId=:System.Label.Non_Call_Center_Public_Group )  AND UserOrGroupId IN:setOfUserIds ];
        }
        
    
    if(!CallCenterGMlist.isEmpty()) {
        System.debug('CallCenterGMlist  Group Member List is ' + CallCenterGMlist );
        insert CallCenterGMlist ;
    }
    if(!NonCallCenterGMlist.isEmpty()) {
        System.debug('NonCallCenterGMlist Group Member List is ' + CallCenterGMlist );
        insert NonCallCenterGMlist;
    }
    
    if(!ListgroupMemberDel.isEmpty()) {
        System.debug('ListgroupMemberDel Group Member List is ' + ListgroupMemberDel);
        Delete ListgroupMemberDel;
    }
    
    //JavaAPICallOut.makeJavaPortalUserAPICall();
    commonUserAPICall();
      
    }
    
    
  public static void commonUserAPICall(){
      //update by saurabh Kumar on 22 March 2021 for callinf user API for all clusters
    
    // main cluster
    String mainCluster = System.Label.ProductionEndPoint0;
    JavaAPICallOut.makeJavaPortalUserAPICall(mainCluster);
    // for first cluster
    String firstCluster = System.Label.ProductionEndPoint1;
     system.debug('firstClusterfirstClusterfirstCluster'+firstCluster );
    JavaAPICallOut.makeJavaPortalUserAPICall(firstCluster);
    // for Second cluster
    String secondCluster = System.Label.ProductionEndPoint2;
    JavaAPICallOut.makeJavaPortalUserAPICall(secondCluster);
    
     // for third cluster
    String thirdCluster = System.Label.ProductionEndPoint3;
    JavaAPICallOut.makeJavaPortalUserAPICall(thirdCluster);
    
     // for fourth cluster
    String fourthCluster = System.Label.ProductionEndPoint4;
    JavaAPICallOut.makeJavaPortalUserAPICall(fourthCluster);
    
    // for fifth cluster
    String fifthCluster = System.Label.ProductionEndPoint5;
    JavaAPICallOut.makeJavaPortalUserAPICall(fifthCluster);
    
    // sixth cluster
    String sixthCluster = System.Label.ProductionEndPoint6;
    JavaAPICallOut.makeJavaPortalUserAPICall(sixthCluster);
    
     // seven cluster
    String sevenCluster = System.Label.ProductionEndPoint7;
    JavaAPICallOut.makeJavaPortalUserAPICall(sevenCluster);
    
     // eight cluster
    String eightCluster = System.Label.ProductionEndPoint8;
    JavaAPICallOut.makeJavaPortalUserAPICall(eightCluster);
    
     // nine cluster
    String nineCluster = System.Label.ProductionEndPoint9;
    JavaAPICallOut.makeJavaPortalUserAPICall(nineCluster);
    
     // preprods cluster
    String preprodCluster = System.Label.ProductionEndPoint10;
    JavaAPICallOut.makeJavaPortalUserAPICall(preprodCluster);
    
    // preprods cluster NYC
    String preprodClusterNYC = System.Label.ProductionEndPoint11;
    JavaAPICallOut.makeJavaPortalUserAPICall(preprodClusterNYC);
  }  
}