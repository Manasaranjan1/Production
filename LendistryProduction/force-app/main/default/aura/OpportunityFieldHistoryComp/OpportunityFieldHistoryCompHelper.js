({
    fetchData: function(component, event, helper) {
        
        //call apex class method
        var action = component.get('c.fetchOpportunityHistoryData');
        action.setParams({
            "OpportunityId" : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                //set response value in Opp History List attribute on component.
                console.log('******response.getReturnValue()***********'+response.getReturnValue());
                component.set('v.columns', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
})