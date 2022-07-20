({
     uploadToAWS : function(component, event, helper) {
        var action = component.get("c.uploadToAWSServier");
         let button = event.getSource();
    		button.set('v.disabled',true);
         action.setParams({
            'leadRecordId' : component.get("v.recordId"),
             'contentDocumentId' : event.getSource().get("v.name")
        });
          component.set("v.Spinner", true);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
               // component.set('v.lstContentDoc', response.getReturnValue());
               if( response.getReturnValue() == true)
               {
                   component.set("v.Spinner", false); 
                   helper.showSuccess();
               }
                else
                {
                  helper.showError();   
               console.log('-----SUCCESS------>>');
                }
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
    showSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'your File is uploaded successfully',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    showError : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Error',
            message:'Your File is not uploaded successfully. Please check with Salesforce Team.',
            duration:' 5000',
            key: 'info_alt',
            type: 'error',
            mode: 'pester'
        });
        toastEvent.fire();
    }

})