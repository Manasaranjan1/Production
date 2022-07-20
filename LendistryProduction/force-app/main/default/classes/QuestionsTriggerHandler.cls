public class QuestionsTriggerHandler {
    
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    public static boolean IsFromBachJob ;
    public static boolean isFromUploadAPI=false;
    public static boolean isRecursive=false;
    
    public QuestionsTriggerHandler(boolean isExecuting, integer size)
    {
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    
    public void OnAfterUpdate( List<Lead_Questions__c> newQuestions, Map<ID, Lead_Questions__c> oldQuestionsMap ){
        CallJavaportalAPI__c obj = CallJavaportalAPI__c.getInstance('Is JavaAPICallOut');
         if(obj.Is_Call_API__c ){
             set<string> setOfQuestionsIds = new set<string>();             
             String prod1Url1;
            if(newQuestions != null && newQuestions.size() > 0 ){
                for(Lead_Questions__c each : newQuestions){
                    Lead_Questions__c oldQuestion = oldQuestionsMap.get(each.Id);
                    if(oldQuestion.Answer__c !=each.Answer__c){
                        setOfQuestionsIds.add(each.id);
                        prod1Url1 =  each.PortalAPIEndPoint__c;
                    }                    
                }
                
                 if( setOfQuestionsIds!= null && setOfQuestionsIds.size() > 0 )
                    JavaAPICallOut2.updateLeadQuestions(setOfQuestionsIds,prod1Url1);                                
              }
            }        
    }
    
    // sub question
    public void OnAfterUpdate( List<Sub_Question__c> newSubQuestions, Map<ID, Sub_Question__c> oldSubQuestionsMap ){
         CallJavaportalAPI__c obj = CallJavaportalAPI__c.getInstance('Is JavaAPICallOut');
         if(obj.Is_Call_API__c ){
             set<string> setOfQuestionsIds = new set<string>();              
             String prod1Url1;
            if(newSubQuestions != null && newSubQuestions.size() > 0 ){
                for(Sub_Question__c each : newSubQuestions){
                     Sub_Question__c  oldSubQuestion = oldSubQuestionsMap.get(each.Id);
                     if(oldSubQuestion.Answer__c !=each.Answer__c){
                        setOfQuestionsIds.add(each.Lead_Question__c);
                        prod1Url1 =  each.PortalAPIEndPoint__c;
                     }                                       
                }                
                 if( setOfQuestionsIds  != null && setOfQuestionsIds .size() > 0 )
                    JavaAPICallOut2.updateLeadQuestions(setOfQuestionsIds ,prod1Url1);                    
                             
            }
         }   
    }
}