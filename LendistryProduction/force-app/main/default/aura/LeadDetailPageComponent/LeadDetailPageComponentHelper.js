({
    
    
    
    
    /* Newly Added */
    callgetLeadField : function(component, event, helper) {
        component.set("v.whichpage","3");  
            var userId = $A.get("$SObjectType.CurrentUser.Id");
             //alert('----userId------->'+userId);

        //console.log('-URL------------>'+window.location.pathname);
        
        var counselingid = component.get("v.recordId");
        
        var actionSortData = component.get("c.getLeadField");        
        var counselingid = component.get("v.recordId");
        actionSortData.setParams({ "Csid": counselingid, "CurrentUserId": userId });
        actionSortData.setCallback(this, function(response) { 
            var state = response.getState();            
            if (state === "SUCCESS") {
                
                var returnValue= response.getReturnValue(); 
                //alert('-returnValue.LeadId------------>'+returnValue.LeadId);
                component.set("v.LeadId", returnValue.LeadId)
                component.set("v.detailFields",returnValue.listOfDetails);
                component.set("v.listClientData",returnValue.listClientData);
                component.set("v.listBusinessInformation",returnValue.listBusinessInformation);
                component.set("v.listSalesInformation",returnValue.listSalesInformation);                
                component.set("v.listOneonOneConsulting",returnValue.listOneonOneConsulting);
                component.set("v.listOnlinecourses",returnValue.listOnlinecourses);
                component.set("v.listAdditionalInformation",returnValue.listAdditionalInformation);
                component.set("v.isOpenLead",true);
                component.set("v.DisableViewLead",true);
            }
            
        });
        $A.enqueueAction(actionSortData);
        
    },
    
    
    
    
    /* Newly Added */    
    
})