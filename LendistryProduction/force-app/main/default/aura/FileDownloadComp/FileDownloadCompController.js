({
    initData : function(component, event, helper) {
       component.set("v.isModalOpen",true); 
       component.set("v.spinner",true);
        //alert('calling Apex');
       helper.loadDataAgain(component);
    },
    finalDelete : function(component, event, helper) {
        component.set("v.hideSpinner",true);
        helper.deleteFileFinally(component);
    },
    deleteFile : function(component, event, helper) {
        // first alert 
        component.set("v.isfinalDelete",true);      
        component.set("v.idForDelete", event.target.title);      
    },
    closeModel :  function(component, event, helper) {
        component.set("v.isModalOpen",false);
        component.set("v.showDownLoadAttach",false);
        
    },
    closeModelPreview : function(component, event, helper) {
        component.set("v.hasModalOpen",false);
    },
    cancelDelete :  function(component, event, helper) {
        component.set("v.isfinalDelete",false);
    },
    downloadFile : function(component, event, helper) {
      // https://lendistry.my.salesforce.com//sfc/servlet.shepherd/document/download/069q0000001YJFlAAO?operationContext=S1
        var sessionId = event.target.title;        
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "https://lendistry.lightning.force.com/sfc/servlet.shepherd/document/download/"+ sessionId
        });
        urlEvent.fire();
        
    },
    previewFile : function(component,event,helper){
        // display modle and set seletedDocumentId attribute with selected record Id   
        component.set("v.hasModalOpen" , true);
        component.set("v.selectedDocumentId" , event.target.title); 
        
    },
    
    // function automatic called by aura:waiting event  
    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for displaying loading spinner 
        component.set("v.spinner", true); 
    },
     
    // function automatic called by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hiding loading spinner    
        component.set("v.spinner", false);
    },  
    
    
    
})