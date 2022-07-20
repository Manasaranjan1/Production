({
    closeModel : function(component, event, helper) {
        component.set("v.showModal",false);
    },
    updateQuestion :  function(component, event, helper) {
        debugger;
        component.set("v.hideSpinner",true);
        var updateId;
        var whichId = component.get("v.whichId");
        if(whichId=="LeadQst")
            updateId = component.get("v.Question.questionId");
        if(whichId=="LeadSubQst")
            updateId = component.get("v.Question.subquestionId");
        var actionUpdate = component.get('c.updateQuestionData');
        actionUpdate.setParams({ 
            "parentId" : component.get("v.recordId") ,
            "answer" : component.get("v.Question.answer"),
            "childId" : updateId
        }); 
        actionUpdate.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {                
                component.set("v.showModal",false);
                var cmpEvent = component.getEvent("cmpEvent");
                cmpEvent.fire();                
            }
        });
        $A.enqueueAction(actionUpdate);
    },
})