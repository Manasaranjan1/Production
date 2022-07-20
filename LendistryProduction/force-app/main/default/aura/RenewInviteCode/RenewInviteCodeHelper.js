({
	renewBase64: function(component, event, helper) {
        
        //call apex class method
        var action = component.get('c.renewBase64Code');
        action.setParams({
            "LeadId" : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.Message", response.getReturnValue());
                if( component.get("v.Message") == 'Re-Invited') 
                helper.showSuccessToast(component, event, helper);
                if( component.get("v.Message") == 'Has PortalId')
                helper.showWarningHasPortalIdToast(component, event, helper);    
                if( component.get("v.Message") =='Still - Active')
                helper.showWarningStillActiveToast(component, event, helper);
                     
                
                $A.get("e.force:refreshView").fire();
                $A.get("e.force:closeQuickAction").fire();
            }
        });
        $A.enqueueAction(action);
    },
    showSuccessToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success Message',
            message: 'This Lead has been reinvited to Portal.',
            messageTemplate: 'This Lead has been reinvited to Portal.',
            duration:' 500',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    
    showWarningHasPortalIdToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Warning',
            message: 'This Lead has been originated from Portal and Can not be reinvited',
            messageTemplate: 'This Lead has been originated from Portal and Can not be reinvited',
            messageTemplateData: ['Salesforce', {
                url: 'http://www.webkul.com/',
                label: 'Click Here',
            }],
            duration:' 5000',
            key: 'info_alt',
            type: 'error',
            mode: 'sticky'
        });
        toastEvent.fire();
    },
    showWarningStillActiveToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Warning',
            message: 'The Invite Url is still active.',
            messageTemplate: 'The Invite Url is still active.',
            messageTemplateData: ['Salesforce', {
                url: 'http://www.webkul.com/',
                label: 'Click Here',
            }],
            duration:' 5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'sticky'
        });
        toastEvent.fire();
    }
    
})