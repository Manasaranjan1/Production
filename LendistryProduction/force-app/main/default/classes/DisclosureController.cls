/**********************************************************************************************
 @Name DisclosureController
* @Author Saurabh Kumar <saurabh.kumar3@rsystems.com>
* @Date 21/12/2020
* @Description This class contains all the methods for displaying Question data on Lightning Component.
*******************************************************************************************/
/* MODIFICATION LOG
* 1.1 22 December 2020 Description
*-------------------------------------------------------------------------------------------
* 1.0 Saurabh 21/12/2020 Initial Creation
*************************************************************************************************/

public without sharing class DisclosureController{
    @AuraEnabled
    public static List<questionWrapper> getDisclosureData(Id leadId){
        system.debug('?????????//'+leadId);
        List<Lead_Questions__c> listOfQuestion = new List<Lead_Questions__c> ();
         List<questionWrapper> listOfWrap = new List<questionWrapper>();
         String sObjName = leadId.getSObjectType().getDescribe().getName();
         if(sObjName =='Lead'){
             listOfQuestion = [select id,Name,Answer__c,Is_SubQuestion__c,Options__c,Lead__c,Opportunity__c,Question__c,Question_Type__c,
                                                    (select id,Answer__c,Options__c,Question__c,Question_Type__c from Sub_Questions__r)
                                                  from Lead_Questions__c where Lead__c=:leadId];
         } 
         else{
             listOfQuestion = [select id,Name,Answer__c,Is_SubQuestion__c,Options__c,Lead__c,Opportunity__c,Question__c,Question_Type__c,
                                                    (select id,Answer__c,Options__c,Question__c,Question_Type__c from Sub_Questions__r)
                                                  from Lead_Questions__c where Opportunity__c=:leadId];
         }                                        
         if(listOfQuestion !=null && listOfQuestion.size()>0){
           
            
            for(Lead_Questions__c objQst : listOfQuestion ){
                questionWrapper qstWraper = new questionWrapper() ; 
                qstWraper.Question = objQst.Question__c  ;
                qstWraper.questionType  = objQst.Question_Type__c;
                qstWraper.answer = objQst.Answer__c;
                qstWraper.questionId= objQst.Id;
                if((qstWraper.questionType=='DropDown'  ||  qstWraper.questionType=='radio')&& objQst.Options__c !=null && objQst.Options__c.contains(',')){
                    List<String> optionValues = objQst.Options__c.split(',');
                    for(String str : optionValues){
                        qstWraper.Options.add(str.trim());
                    }                    
                }  
                system.debug('DropDownDropDown'+qstWraper);              
                List<subQuestionWrappper> subQstListWrap = new List<subQuestionWrappper>();
                if(objQst.Is_SubQuestion__c  ){
                    qstWraper.expanded  = true;                   
                    for(Sub_Question__c  sub : objQst.Sub_Questions__r){
                        subQuestionWrappper subWrapper = new subQuestionWrappper();
                        subWrapper.Question = sub.Question__c  ;
                        subWrapper.questionType  = sub.Question_Type__c;
                        subWrapper.answer = sub.Answer__c;
                        subWrapper.subquestionId= sub.Id;
                        if((subWrapper.questionType=='DropDown' ||  subWrapper.questionType=='radio') && sub.Options__c !=null && sub.Options__c.contains(',')){
                            List<String> optionValues = sub.Options__c.split(',');
                            for(String str : optionValues){
                                subWrapper.Options.add(str.trim());
                            }                    
                        } 
                        subQstListWrap.add(subWrapper);
                    }
                }       
                
                qstWraper.items = subQstListWrap ;
                listOfWrap.add(qstWraper);
                
            }
       
         } 
         return listOfWrap; 
    }
    
    // update question data
    @AuraEnabled
    public static List<questionWrapper> updateQuestionData(String parentId, String answer,Id childId){
        CallJavaportalAPI__c obj = CallJavaportalAPI__c.getInstance('Is JavaAPICallOut');
        obj.Is_Call_API__c = true;
        update obj; 
        system.debug('childIdchildId'+answer);
        String sObjName = childId.getSObjectType().getDescribe().getName();
        if(sObjName=='Lead_Questions__c'){
            Lead_Questions__c objQst = new Lead_Questions__c(id=childId);
            if(answer.trim()=='no'){
                objQst.answer__c = answer;
                objQst.Is_SubQuestion__c = false;
            }
            else if(answer.trim()=='yes'){
                objQst.answer__c = answer;
                objQst.Is_SubQuestion__c = true;
            }
            else
                objQst.answer__c = answer;
            update objQst ;
        }
        else{
            Sub_Question__c objSubQst = new Sub_Question__c(id=childId);
            objSubQst.answer__c = answer;
            update objSubQst ;
        }
        
        
        return null;
    }
    
    // wrapper
    public Class QuestionWrapper{
        @AuraEnabled
        public String Question{get;set;}
        @AuraEnabled
        public String questionType {get;set;}
        @AuraEnabled
        public Boolean expanded {get;set;}
        @AuraEnabled
        public Boolean selectedValue{get;set;}
        @AuraEnabled
        public String answer{get;set;}
        @AuraEnabled
        public String questionId{get;set;}
        @AuraEnabled
        public List<String> options ;
        @AuraEnabled
        public List<subQuestionWrappper> items {get;set;}
        public QuestionWrapper(){
            items = new List<subQuestionWrappper>();
            expanded =false;
            options  = new List<String>();
            
        }
        
    }
    public Class subQuestionWrappper{
        @AuraEnabled
        public List<String> options ;
        @AuraEnabled
        public String Question{get;set;}
        @AuraEnabled
        public String questionType {get;set;}
        @AuraEnabled
        public Boolean expanded {get;set;}
        @AuraEnabled
        public String answer{get;set;}
        @AuraEnabled
        public String subquestionId{get;set;}
        public subQuestionWrappper(){
            options = new List<String>();
        }
    }
}