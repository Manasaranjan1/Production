({loadDataAgain : function(component) {
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
	commonToastMessage : function(component,fileName) {		
       
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "File "+fileName+" Uploaded successfully.",
            "type" :"success"
        });
        toastEvent.fire();
	},
    commonGetUploadedFiles : function (component, uploadedFiles) {
        debugger;
        for(var i=0;i<uploadedFiles.length;i++){
            var fileName = uploadedFiles[i].name;
            this.commonToastMessage(component,fileName);
        }
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
    }
})