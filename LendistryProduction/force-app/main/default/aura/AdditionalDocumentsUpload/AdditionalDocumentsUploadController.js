({
    /*call apex controller method "fetchContentDocument" to get salesforce file records*/
    doInit : function(component, event, helper) {
        var action = component.get("c.fetchContentDocument");
        //alert('--------component.get("v.recordId")------>>'+component.get("v.recordId"));
        action.setParams({
            'leadRecordId' : component.get("v.recordId")
        });
        component.set("v.Spinner", true); 
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.lstContentDoc', response.getReturnValue());
                component.set("v.Spinner", false); 
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);  
    },
    getSelected : function(component,event,helper){
       // var btnId= event.getSource().get("v.name").set("v.disabled", true);
      // alert('Selected Account to delete - ' + event.getSource().get("v.name"));
       // var toggleText = component.find("0693J0000001yT2QAI");
      //  $A.util.toggleClass(toggleText, "toggle");
//        let button = component.find('0693J0000001yT2QAI');
    //button.set('v.disabled',true);
      //  var buttonId = component.get(btnId);
      //  buttonId.set('v.disabled',true);
       //var buttonId = component.find(event.getSource().get("v.name"));
       //button.set('v.disabled',true);
      // var btn = event.getSource().get("v.name");
//btn.set("v.disabled",true);//Disable the button
       helper.uploadToAWS(component,event,helper);
        
    },
    closeModel: function(component, event, helper) {
        // for Close Model, set the "hasModalOpen" attribute to "FALSE"  
        component.set("v.hasModalOpen", false);
        component.set("v.selectedDocumentId" , null); 
    },
         
})