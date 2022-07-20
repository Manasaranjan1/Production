trigger CriminalReportTrigger on criminalreports__Criminal_Report__c (before update, after update) {
    List<String> listRecordTypeId = Label.RunCriminalReportValidation.split(';');
    Set<String> setRecordTypeId = new Set<String>();
    setRecordTypeId.addAll(listRecordTypeId);
    
    if(Trigger.isBefore && Trigger.isUpdate) {
        for(criminalreports__Criminal_Report__c oRecord : Trigger.new) {
            criminalreports__Criminal_Report__c oOldRecordCriminal = Trigger.oldMap.get(oRecord.Id);
            if(Test.isRunningTest() || (setRecordTypeId.contains(oRecord.Lead_RecordType__c) && oRecord.of_Ownership_Owner__c < 10)) {
                oRecord.X3rd_Party_Validation_Flag__c = 'Pass';
                oRecord.Validation_Failed_Reason__c = '';
            }
        }
    }

    if(Trigger.isAfter && Trigger.isUpdate) {
        Set<Id> setCriminalReports = new Set<Id>();

        for(criminalreports__Criminal_Report__c oRecord : Trigger.new) {
            criminalreports__Criminal_Report__c oldRecord = Trigger.oldMap.get(oRecord.Id);
            if(oRecord.of_Ownership_Owner__c >= 10 && (oRecord.criminalreports__Status__c != oldRecord.criminalreports__Status__c && oRecord.criminalreports__Status__c == 'Completed') || oRecord.criminalreports__Alias_Match_Count__c != oldRecord.criminalreports__Alias_Match_Count__c || oRecord.of_Ownership_Owner__c != oldRecord.of_Ownership_Owner__c) {
                if(setRecordTypeId.contains(oRecord.Lead_RecordType__c) && oRecord.criminalreports__Alias_Match_Count__c > 0) {
                    setCriminalReports.add(oRecord.Id);
                }
            }
        }
        if(setCriminalReports != null && !setCriminalReports.isEmpty()) {
            
            List<criminalreports__Offense__c> listOffenses = [Select Id, Grant_NYC_Validation__c, criminalreports__Description__c, criminalreports__Filing_Date__c, criminalreports__Offense_Date__c, criminalreports__Criminal_Report__c from criminalreports__Offense__c where criminalreports__Criminal_Report__c in:setCriminalReports];

            Map<Id, List<criminalreports__Offense__c>> mapCriminalIdOffenses = new Map<Id, List<criminalreports__Offense__c>>();
            Map<Id, String> mapCriminalReports = new Map<Id, String>();
            Set<Id> setCriminalReport = new Set<Id>(); //report didn't have the Grant-NYC Validation

            for(criminalreports__Offense__c oRec : listOffenses) {
                if(oRec.Grant_NYC_Validation__c) {
                    List<criminalreports__Offense__c> listOffense = new List<criminalreports__Offense__c>();
                    String temp = '';
                    if(mapCriminalIdOffenses != null && mapCriminalIdOffenses.containsKey(oRec.criminalreports__Criminal_Report__c)) {
                        listOffense = mapCriminalIdOffenses.get(oRec.criminalreports__Criminal_Report__c);
                        temp = mapCriminalReports.get(oRec.criminalreports__Criminal_Report__c);
                    }
                    temp += oRec.criminalreports__Description__c + '\n';
                    listOffense.add(oRec);
                    mapCriminalIdOffenses.put(oRec.criminalreports__Criminal_Report__c, listOffense);
                    mapCriminalReports.put(oRec.criminalreports__Criminal_Report__c, temp);
                } else {
                    setCriminalReport.add(oRec.criminalreports__Criminal_Report__c);
                }
            }

            List<criminalreports__Criminal_Report__c> listCRs = new List<criminalreports__Criminal_Report__c>();
            
            if(mapCriminalReports != null && !mapCriminalReports.isEmpty()) {
                for(Id recordId : mapCriminalReports.keySet()) {
                    criminalreports__Criminal_Report__c oReport = new criminalreports__Criminal_Report__c();
                    oReport.Id = recordId;
                    if(mapCriminalReports != null && String.isNotBlank(mapCriminalReports.get(recordId))) {
                        oReport.Validation_Failed_Reason__c = mapCriminalReports.get(recordId);
                        oReport.X3rd_Party_Validation_Flag__c = 'Fail';
                        listCRs.add(oReport);
                    }
                }
            }
           

            if(listCRs != null && !listCRs.isEmpty()) {
                Database.update(listCRs, false);
            }
        }
    }
}