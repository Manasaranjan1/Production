@isTest
private class OffenseTriggerHandler_Test {
    
    static testMethod void offenseTesting() {
        Trigger_ON_OFF_Setting__c triggerONOFF = new Trigger_ON_OFF_Setting__c();
        triggerONOFF.Name = 'LeadTrigger_Switch';
        triggerONOFF.LeadTrigger_ON_OFF__c = true;
        insert triggerONOFF;
        
        MockHttpResponseGenerator2 oMock = new MockHttpResponseGenerator2(200, 'OK', getSampleReponseXML() , new Map<String, String>());
        Test.setMock(HttpCalloutMock.class, oMock);
        
        Test.startTest();
        Id recTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Grant-NYC').getRecordTypeId();
        
        criminalreports__Criminal_Report__c oCriminal_Report = new criminalreports__Criminal_Report__c();
        oCriminal_Report.criminalreports__City__c = 'TestCity';
        oCriminal_Report.criminalreports__Country__c = 'US';
        oCriminal_Report.criminalreports__DOB__c = System.today().addYears(-20);
        oCriminal_Report.criminalreports__First_Name__c = 'TestFirstName';
        oCriminal_Report.criminalreports__Last_Name__c = 'LastName';
        oCriminal_Report.criminalreports__Middle_Name__c = 'M';
        oCriminal_Report.criminalreports__SSN__c = '123456789';
        oCriminal_Report.criminalreports__Status__c = 'Not Requested';
        oCriminal_Report.criminalreports__Street_Name__c = 'Test Wall Street';
        oCriminal_Report.criminalreports__State__c = 'NJ';
        oCriminal_Report.criminalreports__Zip_Code__c = '10005';
        oCriminal_Report.Lead_RecordType__c = recTypeId;
        oCriminal_Report.of_Ownership_Owner__c = 11;
        insert oCriminal_Report;
        
        List<Offence_to_Validate__c> listValidate = new List<Offence_to_Validate__c>();
        
        Offence_to_Validate__c oRecord = new Offence_to_Validate__c();
        oRecord.Description__c = 'Test 1';
        oRecord.isActive__c = true;
        listValidate.add(oRecord);
        
        Offence_to_Validate__c oRecord1 = new Offence_to_Validate__c();
        oRecord1.Description__c = 'Test 2';
        oRecord1.isActive__c = true;
        listValidate.add(oRecord1);
        insert listValidate;
        
        criminalreports__Criminal_Report__c oCR = [SELECT criminalreports__City__c, criminalreports__Country__c, criminalreports__DOB__c, criminalreports__First_Name__c, criminalreports__Last_Name__c, criminalreports__Middle_Name__c, criminalreports__SSN__c, criminalreports__Status__c, criminalreports__Street_Name__c, criminalreports__State__c, criminalreports__Zip_Code__c from criminalreports__Criminal_Report__c LIMIT 1];
        
        criminalreports__Candidate__c oCandidate = new criminalreports__Candidate__c();
        oCandidate.criminalreports__Criminal_Report__c = oCR.Id;
        oCandidate.criminalreports__Full_Name__c = oCR.criminalreports__First_Name__c + ' ' + oCR.criminalreports__Last_Name__c;
        insert oCandidate;
        
        criminalreports__Offense__c offense = new criminalreports__Offense__c();
        offense.criminalreports__Candidate__c = oCandidate.Id;
        offense.criminalreports__Criminal_Report__c = oCR.Id;
        offense.criminalreports__Description__c = 'Test 1';
        offense.criminalreports__Offense_Date__c = System.today().addYears(-2);
        insert offense;
        
        criminalreports__Offense__c offense1 = new criminalreports__Offense__c();
        offense1.criminalreports__Candidate__c = oCandidate.Id;
        offense1.criminalreports__Criminal_Report__c = oCR.Id;
        offense1.criminalreports__Description__c = 'Test 2';
        offense1.criminalreports__Offense_Date__c = System.today().addYears(-2);
        insert offense1;
        
        oCriminal_Report.criminalreports__Status__c = 'Completed';
        oCriminal_Report.of_Ownership_Owner__c = 15;
        update oCriminal_Report;
        
        Test.stopTest();
    }
    
    
    static testMethod void offenseTesting2() {
        Trigger_ON_OFF_Setting__c triggerONOFF = new Trigger_ON_OFF_Setting__c();
        triggerONOFF.Name = 'LeadTrigger_Switch';
        triggerONOFF.LeadTrigger_ON_OFF__c = true;
        insert triggerONOFF;
        
        MockHttpResponseGenerator2 oMock = new MockHttpResponseGenerator2(200, 'OK', getSampleReponseXML() , new Map<String, String>());
        Test.setMock(HttpCalloutMock.class, oMock);
        
        Test.startTest();
        Id recTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Grant-NYC').getRecordTypeId();
        
        criminalreports__Criminal_Report__c oCriminal_Report = new criminalreports__Criminal_Report__c();
        oCriminal_Report.criminalreports__City__c = 'TestCity';
        oCriminal_Report.criminalreports__Country__c = 'US';
        oCriminal_Report.criminalreports__DOB__c = System.today().addYears(-20);
        oCriminal_Report.criminalreports__First_Name__c = 'TestFirstName';
        oCriminal_Report.criminalreports__Last_Name__c = 'LastName';
        oCriminal_Report.criminalreports__Middle_Name__c = 'M';
        oCriminal_Report.criminalreports__SSN__c = '123456789';
        oCriminal_Report.criminalreports__Status__c = 'Not Requested';
        oCriminal_Report.criminalreports__Street_Name__c = 'Test Wall Street';
        oCriminal_Report.criminalreports__State__c = 'NJ';
        oCriminal_Report.criminalreports__Zip_Code__c = '10005';
        oCriminal_Report.Lead_RecordType__c = recTypeId;
        insert oCriminal_Report;
        
        List<Offence_to_Validate__c> listValidate = new List<Offence_to_Validate__c>();
        
        Offence_to_Validate__c oRecord = new Offence_to_Validate__c();
        oRecord.Description__c = 'Test 1';
        oRecord.isActive__c = true;
        listValidate.add(oRecord);
        
        Offence_to_Validate__c oRecord1 = new Offence_to_Validate__c();
        oRecord1.Description__c = 'Test 2';
        oRecord1.isActive__c = true;
        listValidate.add(oRecord1);
        insert listValidate;
        
        criminalreports__Criminal_Report__c oCR = [SELECT criminalreports__City__c, criminalreports__Country__c, criminalreports__DOB__c, criminalreports__First_Name__c, criminalreports__Last_Name__c, criminalreports__Middle_Name__c, criminalreports__SSN__c, criminalreports__Status__c, criminalreports__Street_Name__c, criminalreports__State__c, criminalreports__Zip_Code__c from criminalreports__Criminal_Report__c LIMIT 1];
        
        criminalreports__Candidate__c oCandidate = new criminalreports__Candidate__c();
        oCandidate.criminalreports__Criminal_Report__c = oCR.Id;
        oCandidate.criminalreports__Full_Name__c = oCR.criminalreports__First_Name__c + ' ' + oCR.criminalreports__Last_Name__c;
        insert oCandidate;
        
        criminalreports__Offense__c offense = new criminalreports__Offense__c();
        offense.criminalreports__Candidate__c = oCandidate.Id;
        offense.criminalreports__Criminal_Report__c = oCR.Id;
        offense.criminalreports__Description__c = 'Test 1';
        offense.criminalreports__Offense_Date__c = System.today().addYears(-2);
        insert offense;
        
        oCriminal_Report.criminalreports__Status__c = 'Completed';
        update oCriminal_Report;
        Test.stopTest();
    }
    
    static String getSampleReponseXML() {
        String sRequest ='';
        sRequest += '<XMLCRIM>';
        sRequest += '<OrderResponse>';
        sRequest += '<ResponseID>706171</ResponseID>';
        sRequest += '<Name>Consumer,Zakhary</Name>';
        sRequest += '<Reference>OFAC SAMPLE</Reference>';
        sRequest += '<Message>Request Results</Message>';
        sRequest += '</OrderResponse>';
        sRequest += '<CICcriminal>';
        sRequest += '<Candidates count="13">';
        sRequest += '<Candidate>';
        sRequest += '<Subject>';
        sRequest += '<FullName>ZAKHARY JAYAR CONSUMER</FullName>';
        sRequest += '<DOB>07/12/1968</DOB>';
        sRequest += '<Category>PATRIOT</Category>';
        sRequest += '<Source>OFFICE OF FOREIGN ASSETS CONTROL (OFAC) SPECIALLY DESIGNATED NATIONALS AND BLOCKED PERSONS</Source>';
        sRequest += '<Address>GENERAL TYUSKOV STREET, 3, BUILDING 9, APARTMENT 121, MOSCOW</Address>';
        sRequest += '<Alias>CONSUMIR, ZAKHAR</Alias>';
        sRequest += '</Subject>';
        sRequest += '<Offenses count="1">';
        sRequest += '<Offense>';
        sRequest += '<Description>NOT PROVIDED BY SOURCE.</Description>';
        sRequest += '<Disposition>SPECIALLY DESIGNATED/BLOCKED</Disposition>';
        sRequest += '</Offense>';
        sRequest += '</Offenses>';
        sRequest += '</Candidate>';
        sRequest += '</Candidates>';
        sRequest += '</CICcriminal>';
        sRequest += '</XMLCRIM>';
        system.debug(' sRequest  :::---'+sRequest);
        return sRequest;
    }
}