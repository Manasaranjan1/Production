/**********************************************************************************************
 @Name SalesforceQuestionsApi
* @Author Saurabh Kumar <saurabh.kumar3@rsystems.com>
* @Date 21/12/2020
* @Description This class is used by third party for storing Lead Questions data in SF.
*******************************************************************************************/
/* MODIFICATION LOG
* 1.1 22 December 2020 Description
*-------------------------------------------------------------------------------------------
* 1.0 Saurabh 21/12/2020 Initial Creation
*************************************************************************************************/
@RestResource(urlMapping = '/SalesforceQuestionsApi/*')

global with sharing class SalesforceQuestionsApi{
@HttpPost
    global static void insertLeadQuestions() {
         
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        list<Lead_Questions__c> lstOfQuestions = new list<Lead_Questions__c>();    //  list for new question insertion
        list<Sub_Question__c> lstOfSubQuestionsInsert = new list<Sub_Question__c>(); //  list for new sub question insertion
        Map<Integer,List<Sub_Question__c>> mapOfKeyWithSubQuestion = new Map<Integer,List<Sub_Question__c>>(); // map to hold sub question for upadte
        list<Lead_Questions__c> lstOfOldQuestions = new list<Lead_Questions__c>(); // old question list for update 
        Map<String,Sub_Question__c> mapOfIdWithSubQst = new Map<String,Sub_Question__c>(); // map for insert new sub question 
        list<Lead_Questions__c> lstOfOldUpdateQuestions = new list<Lead_Questions__c>();
        String jsonResponse = '';
        JSON2ApexQuestionsWithSubQst objQuestions = JSON2ApexQuestionsWithSubQst.parse(request.requestBody.toString());
        system.debug('+++Request body+++' + request.requestBody.toString());
        Portal_Integration_Response_Code__c objPortalExceptionHadling = new Portal_Integration_Response_Code__c();
        try {
            system.debug('?????????'+objQuestions.LeadId);
            if (objQuestions != null && objQuestions.Questionnaire != null && objQuestions.Questionnaire.size() > 0 ) {
                if( (objQuestions.LeadId != null && (objQuestions.OpportunityId == null || objQuestions.OpportunityId == '')))
                    lstOfOldQuestions = [ Select id,Question_Id__c,Lead__c,(select id,Sub_Question_Id__c,Parent_Question_Id__c from Sub_Questions__r)  from Lead_Questions__c where  Lead__c =:objQuestions.LeadId limit 100 ];
                if( (objQuestions.LeadId != null && (objQuestions.OpportunityId != null && objQuestions.OpportunityId != '')))
                    lstOfOldQuestions = [ Select id,Question_Id__c,Opportunity__c,(select id,Sub_Question_Id__c,Parent_Question_Id__c from Sub_Questions__r)   from Lead_Questions__c where Opportunity__c =:objQuestions.OpportunityId limit 100 ];
                
              // iterate over JSON questions               
                for( JSON2ApexQuestionsWithSubQst.Questionnaire  eachQuestion : objQuestions.Questionnaire ){
                    if( lstOfOldQuestions != null && lstOfOldQuestions.size() > 0 ){
                        for( Lead_Questions__c old : lstOfOldQuestions ){
                            if( old.Question_Id__c == string.valueof(eachQuestion.questionId)){
                                Lead_Questions__c objQues = new Lead_Questions__c(id=old.id);
                                if( objQuestions.OpportunityId != null && objQuestions.OpportunityId != '' )
                                    objQues.Opportunity__c = objQuestions.OpportunityId;
                                
                                objQues.Question_Id__c = string.valueof(eachQuestion.questionId);
                                objQues.Options__c  =   eachQuestion.options ;                          
                                objQues.Question__c = eachQuestion.questionDesc;
                                objQues.Question_Type__c = eachQuestion.questionType;
                                objQues.Tenant_Id__c = string.valueof(objQuestions.TenantId);
                                if( objQuestions.LeadId != null )
                                    objQues.Lead__c = string.valueof(objQuestions.LeadId);
                                
                                objQues.Answer__c= eachQuestion.answer.trim();
                                objQues.Is_SubQuestion__c = eachQuestion.isSubQuestion;
                                
                                // check if question isSubSection true or falsu thenupdate the subQuestion data
                                if(eachQuestion.isSubQuestion || !eachQuestion.isSubQuestion){
                                system.debug('---Update Call--eachQuestion.questionId----->' + eachQuestion.listOfSubQuestion);
                                    if(eachQuestion.listOfSubQuestion !=null && eachQuestion.listOfSubQuestion.size()>0){
                                        for(JSON2ApexQuestionsWithSubQst.SubQuestionnaire  subWrap : eachQuestion.listOfSubQuestion){
                                            for(Sub_Question__c objSub : old.Sub_Questions__r){
                                                system.debug('objSub.Sub_Question_Id__c'+objSub.Sub_Question_Id__c);
                                                system.debug('String.valueOf(subWrap.subQuestionId)'+String.valueOf(subWrap.subQuestionId));
                                                if(objSub.Parent_Question_Id__c == String.valueOf(subWrap.parentQuestionId) && objSub.Sub_Question_Id__c==String.valueOf(subWrap.subQuestionId)){
                                                    Sub_Question__c oldSubQst = new Sub_Question__c(id=objSub.Id);
                                                    oldSubQst.Answer__c = subWrap.answer.trim();
                                                    oldSubQst.Question__c = subWrap.questionDesc;
                                                    oldSubQst.Question_Type__c = subWrap.questionType;
                                                    oldSubQst.Options__c  =   subWrap.options ;
                                                    mapOfIdWithSubQst.put(oldSubQst.Id,oldSubQst);// add here old subquestions for update 
                                                    system.debug('----mapOfIdWithSubQst---' + mapOfIdWithSubQst);
                                                }                                                
                                            } 
                                        }                                          
                                    }                               
                                }
                                lstOfOldUpdateQuestions.add(objQues);    // add question for update
                            }
                            
                        }
                    }
                    // this block executes when no records of question found under Lead or Opportunity
                    else {
                      // create new Lead qustion instance and add in a list for insertion

                        Lead_Questions__c objQues = new Lead_Questions__c();
                        if( objQuestions.OpportunityId != null && objQuestions.OpportunityId != '' )
                            objQues.Opportunity__c = objQuestions.OpportunityId;
                        
                        objQues.Question_Id__c = string.valueof(eachQuestion.questionId);
                        
                        objQues.Question__c = eachQuestion.questionDesc;
                        objQues.Question_Type__c = eachQuestion.questionType;
                        objQues.Tenant_Id__c = string.valueof(objQuestions.TenantId);
                        if( objQuestions.LeadId != null )
                            objQues.Lead__c = string.valueof(objQuestions.LeadId);
                        
                        objQues.Answer__c= eachQuestion.answer;
                        objQues.Options__c  =   eachQuestion.options ;
                        // insert sub question here
                        objQues.Is_SubQuestion__c = eachQuestion.isSubQuestion;
                        // here a sub questuion list iterate for insertion
                        if(objQues.Is_SubQuestion__c ){
                            if(eachQuestion.listOfSubQuestion !=null && eachQuestion.listOfSubQuestion.size()>0){
                                for(JSON2ApexQuestionsWithSubQst.SubQuestionnaire  subWrap : eachQuestion.listOfSubQuestion){
                                    Sub_Question__c newSubQst = new Sub_Question__c();
                                    newSubQst.Answer__c = subWrap.answer;
                                    newSubQst.Question__c = subWrap.questionDesc;
                                    newSubQst.Question_Type__c = subWrap.questionType;
                                    newSubQst.Options__c  =   subWrap.options ;
                                    newSubQst.Sub_Question_Id__c = String.valueOf(subWrap.subQuestionId);
                                    newSubQst.Parent_Question_Id__c = String.valueOf(subWrap.parentQuestionId);
                                    if(mapOfKeyWithSubQuestion.containsKey(subWrap.parentQuestionId )){
                                        mapOfKeyWithSubQuestion.get(subWrap.parentQuestionId).add(newSubQst);
                                    }
                                   else{
                                       mapOfKeyWithSubQuestion.put(subWrap.parentQuestionId, new List<Sub_Question__c>{newSubQst});
                                   }                                     
                                } 
                            }       
                        }
                        lstOfQuestions.add(objQues);
                    }
                    
                    
                }
            }
            
            system.debug('mapOfIdWithSubQstmapOfIdWithSubQst'+mapOfIdWithSubQst);
            if(lstOfOldUpdateQuestions !=null && lstOfOldUpdateQuestions.size()>0)
                update lstOfOldUpdateQuestions;    // update old question 
            if(mapOfIdWithSubQst!=null && mapOfIdWithSubQst.size()>0)
                update mapOfIdWithSubQst.values();    // update old subquestion
            if(lstOfQuestions !=null && lstOfQuestions.size()>0)
                insert lstOfQuestions;    // insert new questions
            // insert child question by iterating to inserted question
            for(Lead_Questions__c newQst : lstOfQuestions){    
                if(mapOfKeyWithSubQuestion.get(Integer.valueOf(newQst.Question_Id__c))!=null){
                    List<Sub_Question__c > listofSubQstion = mapOfKeyWithSubQuestion.get(Integer.valueOf(newQst.Question_Id__c));
                    for(Sub_Question__c newSubQst : listofSubQstion){
                        newSubQst.Lead_Question__c = newQst.Id;    // set question id to subquestion
                        lstOfSubQuestionsInsert.add(newSubQst);
                    }
                }      
            }
            
            if(lstOfSubQuestionsInsert !=null && lstOfSubQuestionsInsert.size()>0)
                insert lstOfSubQuestionsInsert;    // insert subquestiuons
            // update custom setting to false
            
            // update custom setting
            
            jsonResponse = '{"status": true, "LeadID": "' + objQuestions.LeadId + '", "errors":[]}';
            res.responseBody = blob.valueOf(jsonResponse);
            objPortalExceptionHadling.Response__c = string.valueof(jsonResponse);
            objPortalExceptionHadling.Success_Error_Code__c = '200';
            objPortalExceptionHadling.Request__c = request.requestBody.toString();
            objPortalExceptionHadling.exception__c = null;
            //return objmainWrapper;
        }Catch(Exception ex) {
            res.statusCode = 500;
            jsonResponse = '{"status": false, "errors": "[' + ex + ']"}';
            res.responseBody = blob.valueOf(jsonResponse);
            system.debug('*****Exception *******>>' + ex);
            objPortalExceptionHadling.Response__c = jsonResponse;
            objPortalExceptionHadling.Success_Error_Code__c = '500';
            objPortalExceptionHadling.Request__c = 'test'; //request.requestBody.toString();
            objPortalExceptionHadling.exception__c = string.valueof(ex);
            
        }
        insert objPortalExceptionHadling;
        //return jsonResponse;
   } 
    
}