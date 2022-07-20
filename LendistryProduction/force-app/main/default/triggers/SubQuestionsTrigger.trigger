/**********************************************************************************************
 @Name SubQuestionsTrigger 
* @Author Saurabh Kumar <saurabh.kumar3@rsystems.com>
* @Date 21/12/2020
* @Description This trigger is used to call Question Trigger Handler for Third party callout.
*******************************************************************************************/
/* MODIFICATION LOG
* 1.1 22 December 2020 Description
*-------------------------------------------------------------------------------------------
* 1.0 Saurabh 21/12/2020 Initial Creation
*************************************************************************************************/
trigger SubQuestionsTrigger on Sub_Question__c (after update) {
    QuestionsTriggerHandler handler = new QuestionsTriggerHandler(Trigger.isExecuting, Trigger.size);       
        if ( Trigger.isUpdate && Trigger.isAfter)        {
            handler.OnAfterUpdate(trigger.New ,Trigger.OldMap);
        }
}