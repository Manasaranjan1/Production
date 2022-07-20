({
    doInit: function(component, event, helper) {
        var action = component.get("c.getCounsellor");
        action.setParams({
            "recordId" : component.get("v.recordId")
        });
        action.setCallback(this,function(response){
            component.set("v.isSpinner",false);
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.oldCounsellor",response.getReturnValue());
            } 
        });       
        $A.enqueueAction(action);
    },
    EditCounselor : function(component, event, helper) {
         component.set("v.errormessage","");
        var field = component.find("Counsellor1Id");
        var fls =  $A.util.isEmpty(field.get("v.value"));        
        if(fls){
            component.set("v.errormessage","Please select counselor.");
            component.set("v.isSpinner",false);
            return;
        }
        var oldCounsellor = component.get("v.oldCounsellor");
        if(field.get("v.value").includes(oldCounsellor)){
            component.set("v.errormessage","Please select different counselor.");
            component.set("v.isSpinner",false);
            return;
        }
        component.set("v.isSpinner",true);
       
        var action = component.get("c.UpdateCounselor");
        action.setParams({
            "objCScId" : field.get("v.value"),
            "recordId" : component.get("v.recordId")
        });
        action.setCallback(this,function(a){
            component.set("v.isSpinner",false);
            var state = a.getState();
            if(state === "SUCCESS"){
                var hostName = window.location.hostname;
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url":"https://thecenterbylendistry.force.com/s/",
                    isredirect: false
                });
                urlEvent.fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Counselor has been changed successfully.",
                    "type" : "success"
                });
                toastEvent.fire();
            } else if(state === "ERROR"){
                var errors = action.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert(errors[0].message);
                    }
                }
            }else if (status === "INCOMPLETE") {
                alert('No response from server or client is offline.');
            }
        });       
        $A.enqueueAction(action);
    },
    Close : function(component, event, helper) {
        component.set("v.showCounsellor",false);
    },	
    
})