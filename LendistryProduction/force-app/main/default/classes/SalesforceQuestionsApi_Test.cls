@isTest(seeAllData=true)
public class SalesforceQuestionsApi_Test{
    public static testMethod  void method1(){
        
        JSON2ApexQuestionsWithSubQst  objMain = new JSON2ApexQuestionsWithSubQst();
        JSON2ApexQuestionsWithSubQst.Questionnaire   objWrap = new JSON2ApexQuestionsWithSubQst.Questionnaire ();
        objWrap.questionId = 1;
        objWrap.questionDesc = 'test';
        objWrap.questionType ='text';
        objWrap.isRequired = true;
        objWrap.answer ='No';
        objWrap.options='';
        objWrap.isCustomized = false;
        objWrap.isSubQuestion = true;
        
        JSON2ApexQuestionsWithSubQst.SubQuestionnaire objSub1 = new JSON2ApexQuestionsWithSubQst.SubQuestionnaire();
        
        objSub1.questionDesc = 'test';
        objSub1.questionType ='text';
        objSub1.isRequired = true;
        objSub1.answer ='No';
        objSub1.options='';
        objSub1.isCustomized = false;
        objMain .Questionnaire= new List<JSON2ApexQuestionsWithSubQst.Questionnaire   >{objWrap};
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorQst ());
        Lead  objLead = new Lead();
        objLead.lastName = 'test';
        objLead.Company = 'RSI';
        objLead.Status = 'New';
        insert objLead;
        
        
        Lead_Questions__c objQst = new Lead_Questions__c();
        objQst.Lead__c = objLead.Id;
        objQst.Question_Id__c = '1';
        objQst.Is_SubQuestion__c  = true;
        objQst.Question_Type__c  ='DropDown';
        objQst.Options__c ='Yes,No';
        insert objQst; 
        
        Sub_Question__c  objSub = new Sub_Question__c();
        objSub.Lead_Question__c= objQst.Id;
        objSub.Question_Type__c  ='what is what';
        objSub.Parent_Question_Id__c = '2';
       
        objSub.Question_Type__c  ='DropDown';
        objSub.Options__c ='Yes,No';
        objSub.Sub_Question_Id__c = String.valueOf(3);
        insert objSub; 
        
        DisclosureController.getDisclosureData(objLead.Id);
        DisclosureController.updateQuestionData(objLead.Id,'yes',objQst.Id);
        String requestBodyString = '{"TenantId":"67","LeadId":"'+objLead.Id+'","OpportunityId":"","Questionnaire":[{"questionId":16,"questionDesc":"Please provide the total combined household taxable income as reported on your most recently filed federal tax returns (for 2019, Line 11b, for 2018, Line 10) for all individuals in the household.","questionType":"number","isRequired":true,"isCustomized":false,"options":null,"answer":"6567609","isSubQuestion":false,"listOfSubQuestion":null},{"questionId":6,"questionDesc":"If YES to Question #5, what was the name of the program?","questionType":"DropDown","isRequired":false,"isCustomized":false,"options":"SBA EIDL,Local/Municipal Funds,PA State Grant,Other","answer":"SBA EIDL","isSubQuestion":false,"listOfSubQuestion":null},{"questionId":5,"questionDesc":"Has the Company received other COVID-19 related emergency grant funds (IE. EIDL advance/grant, Local/Municipal Emergency Funds or Other)?","questionType":"DropDown","isRequired":false,"isCustomized":false,"options":"YES,NO","answer":"YES","isSubQuestion":false,"listOfSubQuestion":null},{"questionId":4,"questionDesc":"What was the gross revenue for the business March – May 2020?","questionType":"number","isRequired":true,"isCustomized":false,"options":null,"answer":"454509","isSubQuestion":false,"listOfSubQuestion":null},{"questionId":3,"questionDesc":"What was the gross revenue for the business March – May 2019?","questionType":"number","isRequired":true,"isCustomized":false,"options":null,"answer":"4545709","isSubQuestion":false,"listOfSubQuestion":null},{"questionId":2,"questionDesc":"Does the business operate in a designated revitalization area including a Main Street Program or Elm Street Program, a town in the Trail Town Program™, a town located in the PA Wilds™, or designated commercial corridors in Philadelphia, and Neighborhood Business Districts in Pittsburgh.","questionType":"DropDown","isRequired":true,"isCustomized":false,"options":"YES,NO","answer":"NO","isSubQuestion":false,"listOfSubQuestion":null},{"questionId":1,"questionDesc":"DES 14","questionType":"DropDown","isRequired":true,"isCustomized":false,"options":"YES,NO","answer":"YES","isSubQuestion":true,"listOfSubQuestion":[{"subQuestionId":3,"questionType":"DropDown","questionDesc":"DEP 1","parentQuestionId":2,"isRequired":true,"isCustomized":false,"options":"YES,NO","answer":"YES"}]}]}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceQuestionsApi/*','POST');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        SalesforceQuestionsApi.insertLeadQuestions();
        Test.stopTest();
    }
    public static testMethod  void method2(){       
       try{
        //Lead_Questions__c objQust = [ Select id,Question_Id__c,Lead__r.Id,Opportunity__r.Id    from Lead_Questions__c where  Lead__c !=null and Opportunity__c  !=null limit 1];
        Lead  objLead = new Lead();
        objLead.lastName = 'test';
        objLead.Company = 'RSI';
        objLead.Status = 'New';
        insert objLead;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorQst ());
        String requestBodyString = '{"TenantId":101,"LeadId":"'+objLead.Id+'","OpportunityId":"","Questionnaire":[{"questionId":1,"description":"What is your Name","questionType":"text","isRequired":false,"answer":"any","options":null,"isCustomized":false},{"questionId":2,"description":"Do you live in india","questionType":"DropDown","isRequired":false,"answer":"Yes","options":"Yes,No","isCustomized":false}]}';
        RestContext.request = setTestRestRequest(requestBodyString,'/services/apexrest/SalesforceQuestionsApi/*','POST');
        RestContext.response = new RestResponse();
        
        Test.startTest();
        SalesforceQuestionsApi.insertLeadQuestions();
        Test.stopTest();
        }catch(exception e){}
    }
    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType){
        RestRequest req = new RestRequest();
        req.requestURI = url; 
        req.httpMethod = requestType;
        req.requestBody = Blob.valueof(requestBodyString);
        return req;
        
    }

}