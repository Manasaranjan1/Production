({
    fetchOppHistoryList : function(component, event, helper) {
       component.set('v.mycolumns', [
            {label: 'Stage', fieldName: 'Stage_New__c', type: 'text'},
                {label: 'Start Date', fieldName: 'Stage_Start_Date__c', type: 'date'},
                {label: 'Close Date', fieldName: 'Stage_Close_Date__c', type: 'date'},
 				{label: 'Duration', fieldName: 'Stage_Duration__c', type: 'number'}
            ]);
        var action = component.get("c.fetchOpportunityHistoryData");
        action.setParams({
            "OpportunityId" : component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.OppHistoryList", response.getReturnValue());
                console.log('Log'+response.getReturnValue());
            }
           /* window.setTimeout(
                $A.getCallback(function() {
                    var recUpdate = $A.get("e.c:OppRecordCreated");
                    recUpdate.fire();	
                }),1000
            );*/
        });
        $A.enqueueAction(action);
    }
})