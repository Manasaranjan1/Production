({
    loadDataAgain : function(component) {
        var action = component.get('c.getFiles');
        action.setParams({ 
            "CounsellingSessionId" : component.get("v.recordId")           
        }); 
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnVale = response.getReturnValue();  
                component.set("v.myAttachments",returnVale);              
                component.set("v.hideSpinner",false);
            }
        });
        $A.enqueueAction(action);
    },
    deleteFileFinally : function(component) {
      
        component.set("v.hideSpinner",true);
        var actionDeleteFile = component.get('c.deleteSalesforceFile');
        actionDeleteFile.setParams({ 
            "ContentDocumentId" : component.get("v.idForDelete")           
        }); 
        actionDeleteFile.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.hideSpinner",false);
                component.set("v.isfinalDelete",false);
                this.loadDataAgain(component);
                var returnVale = response.getReturnValue();  
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The file successfully deleted.",
                     "type" :"success"
                });
                toastEvent.fire();
            }
            
        });
        $A.enqueueAction(actionDeleteFile);
    }
})