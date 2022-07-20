public class AlertlistViewForPagination {
 @AuraEnabled
    public static CounselorDataTableWrapper getCounselorData(Integer pageNumber, Integer pageSize) {
         
        //Offset for SOQL
        Integer offset = (pageNumber - 1) * pageSize;
         
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Counseling_Session__c];
        Integer recordEnd = pageSize * pageNumber;
 
        //Instance of Counselor DataTable Wrapper Class
        CounselorDataTableWrapper objDT =  new CounselorDataTableWrapper();  
        objDT.pageSize = pageSize;
        objDT.pageNumber = pageNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.counselorList = [SELECT Id, Name, Note__c, Counsellor1__c,Counsellor_Name__c FROM Counseling_Session__c ORDER BY LastModifiedDate Desc LIMIT :pageSize OFFSET :offset];
        return objDT;
    }
     
    //Wrapper Class For Counselor DataTable  
    public class CounselorDataTableWrapper {
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Counseling_Session__c> counselorList {get;set;}
    }
}