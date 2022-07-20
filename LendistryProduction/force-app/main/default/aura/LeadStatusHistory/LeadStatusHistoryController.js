({
    fetchLeadHistoryList : function(component, event, helper) {
      debugger;
        var action = component.get("c.getLeadHistory");
        action.setParams({
            "leadId" : component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
               
                component.set("v.LeadHistory", response.getReturnValue());
                if(response.getReturnValue().length>0){
                    component.set("v.isShow",true);
                }
                console.log('Logddddd'+response.getReturnValue());
            }
           
        });
        $A.enqueueAction(action);
    }
})