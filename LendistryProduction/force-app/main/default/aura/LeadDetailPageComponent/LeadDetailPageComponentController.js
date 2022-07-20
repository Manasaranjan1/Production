({
    
    initData : function(component, event, helper) {
        helper.callgetLeadField(component, event, helper);
       
    },            
    
    
    
    
    openModel: function(component, event, helper) {
       
       /* Newly Added */
        
         helper.callgetLeadField(component, event, helper);
         //helper.callGetLeadID(component, event, helper);
        
         
       /* Newly Added */
       
       //for Display Model,set the "isOpen" attribute to "true"
      
   /*    component.set("v.isOpen", true);
         component.set("v.DisableViewLead", true);

       
       var LeadDetail = component.get("c.GetLeadID");    
        var counselingid = component.get("v.recordId");
        LeadDetail.setParams({ "Csid": counselingid });
        // actionSortData.setresponse{}
        LeadDetail.setCallback(this, function(response) { 
            var state = response.getState();            
            if (state === "SUCCESS") {
             var returnValue= response.getReturnValue(); 
             component.set("v.LeadId",returnValue);
                
            }});
          $A.enqueueAction(LeadDetail);                        */

   },
    
    
     likenClose: function(component, event, helper) {
      // Display alert message on the click on the "Like and Close" button from Model Footer 
      // and set set the "isOpen" attribute to "False for close the model Box.
      component.set("v.isOpen", false);
      component.set("v.DisableViewLead", false);

   },
 
    back : function(component, event, helper) {
       
    }
    
})