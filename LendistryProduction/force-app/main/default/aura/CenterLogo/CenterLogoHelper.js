({
    /* Added by Rahul B */
    waitingTimeId: null,
	setStartTimeOnUI : function(component) {
        
        //component.set("v.ltngIsDisplayed",true);
        
        /* newly Added */
        component.set("v.DisableBtn2 ",true);                
        component.set("v.DisableStart",true);
        component.set("v.DisableStop",false);
        component.set("v.DisableReset",false);
        /* Newly Added */
        
        var currTime =component.get("v.ltngCurrTime");
        var ss = currTime.split(":");
        var dt = new Date();
        dt.setHours(ss[0]);
        dt.setMinutes(ss[1]);
        dt.setSeconds(ss[2]);
        
        var dt2 = new Date(dt.valueOf() + 1000);
        var temp = dt2.toTimeString().split(" ");
        var ts = temp[0].split(":");
        
        component.set("v.ltngCurrTime",ts[0] + ":" + ts[1] + ":" + ts[2]);
        this.waitingTimeId =setTimeout($A.getCallback(() => this.setStartTimeOnUI(component)), 1000);
    },
    setStopTimeOnUI : function(component) {
        //component.set("v.ltngIsDisplayed",false);
        
        /* newly Added */
        component.set("v.DisableBtn2 ",true);                
        component.set("v.DisableStart",true);
        component.set("v.DisableStop",true);
        component.set("v.DisableReset",true);
        /* Newly Added */
        
        window.clearTimeout(this.waitingTimeId);
    },
    setResetTimeOnUI : function(component) {
        //component.set("v.ltngIsDisplayed",false);
        
        /* newly Added */
        component.set("v.DisableBtn2 ",false);                
        component.set("v.DisableStart",false);
        component.set("v.DisableStop",false);
        component.set("v.DisableReset",true);
        /* Newly Added */
        
        component.set("v.ltngCurrTime","00:00:00");
        window.clearTimeout(this.waitingTimeId);
    },
    
    
    saveTimingTrack1 : function(component,event){               //@@@@@@@@@@
      debugger;
      var actionSortData = component.get("c.saveTimeTracking1");
      actionSortData.setParams({ 
          "timeWithDate" :  component.get("v.ltngCurrTime")   ,
          "sessionId" : component.get("v.recordId")
      }); 
      actionSortData.setCallback(this, function(response) { 
          var state = response.getState();            
          if (state === "SUCCESS") {
              var returnValue= response.getReturnValue();
              /* -- Start -- */
              var toastEvent = $A.get("e.force:showToast");
              toastEvent.setParams({
                title : 'Success',
                message: 'Time Submitted Successfully',
                duration:'5000',
                key: 'info_alt',
                type: 'success',               
              });
              toastEvent.fire(); 
              /* -- End -- */
              
          }else {              
              /* -- Start -- */
              var toastEvent = $A.get("e.force:showToast");
              toastEvent.setParams({
                title : 'Error',
                message: 'Something Went Wrong',
                duration:'5000',
                key: 'info_alt',
                type: 'error',               
              });
              toastEvent.fire(); 
              /* -- End -- */                            
          }
          
      });
      $A.enqueueAction(actionSortData);
  },
    
   /* 
   saveTimingTrack2 : function(component,event){               //@@@@@@@@@@
      debugger;
      var actionSortData = component.get("c.saveTimeTracking2");
      actionSortData.setParams({ 
          "timeWithDate" :  component.get("v.TimeinHour")   ,
          "sessionId" : component.get("v.recordId")
      }); 
      actionSortData.setCallback(this, function(response) { 
          var state = response.getState();            
          if (state === "SUCCESS") {
              var returnValue= response.getReturnValue();            
          }
      });
      $A.enqueueAction(actionSortData);
  },  
       */
     
    /* HH-MM Timing Component 3 */ 
   saveTimingTrack3 : function(component,event){               //@@@@@@@@@@
      debugger;
      var actionSortData = component.get("c.saveTimeTracking3");
      //alert('I m in Helper'); 
      //alert(component.get("v.TimeinHH"));
      //alert(component.get("v.TimeinMM")); 
      actionSortData.setParams({ 
          "timeInHH" :  component.get("v.TimeinHH")   ,
          "timeInMM" :  component.get("v.TimeinMM")   ,
          "sessionId" : component.get("v.recordId")
      }); 
      
      actionSortData.setCallback(this, function(response) { 
          var state = response.getState();            
          if (state === "SUCCESS") {
              var returnValue= response.getReturnValue();
              //alert('Time Submitted Successully '+ returnValue); 
              /* -- Start -- */
              var toastEvent = $A.get("e.force:showToast");
              toastEvent.setParams({
                title : 'Success',
                message: 'Time Submitted Successfully',
                duration:'5000',
                key: 'info_alt',
                type: 'success',               
              });
              toastEvent.fire(); 
              /* -- End -- */
          } else {
              //alert('Something went wrong '+ returnValue);
              /* -- Start -- */
              var toastEvent = $A.get("e.force:showToast");
              toastEvent.setParams({
                title : 'Error',
                message: 'Something Went Wrong',
                duration:'5000',
                key: 'info_alt',
                type: 'error',               
              });
              toastEvent.fire(); 
              /* -- End -- */
              
          }
          
      });
      $A.enqueueAction(actionSortData);
  }, 
   
    
    
    /* Added by Rahul B - END */
    
    
    handleCounsellingSubmit: function(component, event) {
        component.set("v.Spinner",true);
        event.preventDefault();       // stop the form from submitting\\
        //eventFields["Description"] = 'Lead was created from Lightning RecordEditForm'; 
        var fields = event.getParam('fields');
        component.find('counsellingForm').submit(fields);
        
    },
    showToast : function(component, event, helper) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": "ALERT!",
        "message": "Please stop time tracker before leaving the current Counselling Session!!",
        "type" : "warning"
    });
    toastEvent.fire();
}
    
})