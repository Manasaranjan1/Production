({
	sortTheData : function(component, event, helper) {       
        var compEvent = component.getEvent("handleColumn");
        // set the Selected sObject Record to the event attribute.  
        compEvent.setParams({"columnName" : event.target.title});  
        // fire the event  
        compEvent.fire(); 
	}
})