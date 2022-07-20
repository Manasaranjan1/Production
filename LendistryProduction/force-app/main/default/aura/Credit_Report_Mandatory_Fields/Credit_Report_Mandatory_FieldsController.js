({
    doInit : function(component, event, helper) {
        var action = component.get("c.CheckCreditField");
        action.setParams({
            LeadId: component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var custs = [];
            var conts = response.getReturnValue();
            for(var key in conts){
                custs.push({value:conts[key], key:key});
            }
            component.set("v.LeadFieldValues", custs);
        });
        $A.enqueueAction(action); 
    }
})