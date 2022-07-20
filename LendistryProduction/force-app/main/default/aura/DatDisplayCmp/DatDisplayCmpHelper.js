({
    enableDisableChildQuestions: function(component, event, helper) {
        var selectedCheck = event.getSource().get("v.title");
        var myData = component.get("v.mydata");
        if(myData[selectedCheck].expanded){            
            component.set("v.confirmModal",true);
        }
        
    }
})