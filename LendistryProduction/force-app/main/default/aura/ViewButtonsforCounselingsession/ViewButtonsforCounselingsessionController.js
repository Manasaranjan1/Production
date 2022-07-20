({
    openManualTimeTracker : function(component, event, helper) {
        component.set("v.openManualTracker",true);
    },
    /* Added by Rahul B */
    handleStartClick : function(component, event, helper) {
		console.log("start button clicked!!");
        helper.setStartTimeOnUI(component);
	},
    handleStopClick : function(component, event, helper) {
        debugger;
		console.log("stop button clicked!!");
        helper.setStopTimeOnUI(component);
        
        helper.saveTimingTrack1(component,event); //First Time Tracker
	},
    handleResetClick : function(component, event, helper) {
		console.log("Reset button clicked!!");
        helper.setResetTimeOnUI(component);
	},
    OpenChangeCounselorModal : function(component, event, helper) {
		 component.set("v.showCounsellor",true);
	},
    /*
    saveTime : function(component, event, helper) {
        component.set("v.DisableBtn ",true);  
        helper.saveTimingTrack2(component,event);
    },  */    
    
    /* Second Time Tracker */
    saveTime2 : function(component, event, helper) {
        component.set("v.DisableBtn2 ",true);
        //alert('I m in Controller Js');
        
        /* Validate hh mm Field */
        var inputCmp1 = component.find("hh");
        var inputCmp2 = component.find("mm");
        
        var value1 = inputCmp1.get("v.value");
        var value2 = inputCmp2.get("v.value");
        
        //alert(' value check : '+value1);
        
        if(value1==='' || value2==='') {          
            
            //alert("Fields should not be Empty");
            component.set("v.DisableBtn2 ",false);
                        
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
               title : 'Alert',
               message: 'Time fields should not be empty',
               duration:'10000',
               key: 'info_alt',
               type: 'error',
               
            });
            toastEvent.fire();                           
        } 
        else {
            
            var inputCmp2 = component.find("mm");        
            var value2 = inputCmp2.get("v.value");
            if(parseInt(value2) >= 60){
               component.set("v.DisableBtn2 ",false);
               var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                  title : 'Alert',
                  message: 'Minutes should be less than 60',
                  duration:'10000',
                  key: 'info_alt',
                  type: 'error',
               
               });
               toastEvent.fire();    
                
            }
            else {
               helper.saveTimingTrack3(component,event);    
            }
             
        }
    },
        
    /* Added by Rahul B - END */
    
    openModel : function(component, event, helper) { 
        var leadId = component.get("v.LeadId");  
        component.set("v.LeadId",leadId);
        var btnName =  component.get("v.viewLeadBtn");
      
        if(btnName=="View Lead"){
            component.set("v.isOpen",true);
            component.set("v.viewLeadBtn","Close Lead");
        }
        else{
            component.set("v.isOpen",false);
            component.set("v.viewLeadBtn","View Lead");
        }       
    },
    //Added by Rahul B
   /* openCSModel :function(component, event, helper) {
        var hostName = window.location.hostname;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "https://uat-thecenterbylendistry.cs218.force.com/apex/GenerateReportofCSessions",
                                isredirect: true
        });
        urlEvent.fire();
       // window.location.href='https://javaportal-thecenterbylendistry.cs169.force.com/apex/GenerateReportofCSessions';
    },  */
    //end
     
    back :function(component, event, helper) {
      
        var hostName = window.location.hostname;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "https://thecenterbylendistry.force.com/s/",
                              //  isredirect: false
        });
        urlEvent.fire();
        
    },
    OpenUploadModal : function(component, event, helper) {
        component.set("v.showUploadAttach",true);
    },
    OpenDownLoadModal : function(component, event, helper) {
         component.set("v.showDownLoadAttach",true);
    },
   /* handleMenuSelect: function(cmp, event, helper) {
        var selectedMenuItemValue = event.getParam("value");
        if(selectedMenuItemValue=="ViewLead"){
            helper.goToLead(cmp, event, helper);
        }
        if(selectedMenuItemValue=="Upload"){
            helper.OpenUploadModal(cmp, event, helper);
        }
        if(selectedMenuItemValue=="Download"){
            helper.OpenDownLoadModal(cmp, event, helper);
        }
    },*/
    logout :function(component, event, helper) {
        window.location.replace("https://dev-counsellor.cs21.force.com/Session/login?ec=302&startURL=%2FSession%2Fs%2F");
        
    },
    
    
    closeModel :  function(component, event, helper) {
        component.set("v.showModal",false);
    },
    initData : function(component, event, helper) {
                
        component.set("v.whichpage","2");
        var counsellingFields = component.get("v.brokerFields");
        
        var empty=[];
        var counsellingFlds = component.get("v.brokerFields");
        for(var i=0;i<counsellingFlds.length;i++){
            if(counsellingFlds[i]!='Lead__c'){
                empty.push(counsellingFlds[i]);
                component.set("v.showViewOrEdit",true);
            }
        }
        component.set("v.brokerFields",empty);
    },
    hideColumn : function(component, event, helper) {
        component.find("newtag").destroy();
        component.set("v.showViewOrEdit",true);
    },
    
    
    edit:function(component, event, helper) {
        
        component.set("v.showViewOrEdit",false);
        
    },
    cancel : function(component, event, helper) {
        
        component.set("v.showViewOrEdit",true);
        
    },
    handleSubmit: function(component, event, helper) {
        component.set("v.Spinner",true);
        event.preventDefault();       // stop the form from submitting\\
        //eventFields["Description"] = 'Lead was created from Lightning RecordEditForm'; 
        var fields = event.getParam('fields');
        component.find('counsellingForm').submit(fields);
        
    },
    handleOnSuccess : function(component, event, helper) {
        component.set("v.showViewOrEdit",true);
        component.set("v.btnName","EDIT");
        var param = event.getParams(); //get event params
        var fields = param.response.fields; //get all field info       
        var recordId = param.response.id; //g
        //param.response.fields.Lead__c.value
        component.set("v.recordId",recordId);
        component.set("v.Spinner",false);        
        component.set("v.isUpdate",true);
    },
    
    handleComponentEvent : function(component, event, helper) {
        component.set("v.showUploadAttach",false);
    },
    
    
})