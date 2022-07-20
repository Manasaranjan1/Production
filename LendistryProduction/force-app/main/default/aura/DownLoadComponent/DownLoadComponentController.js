({
    initData : function(component, event, helper) {
       component.set("v.hideSpinner",true);
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
            "url": "https://lendistry.my.salesforce.com/sfc/servlet.shepherd/document/download/"+ sessionId
        });
        urlEvent.fire();
        //
    },
    previewFile : function(component,event,helper){
        // display modle and set seletedDocumentId attribute with selected record Id   
        component.set("v.hasModalOpen" , true);
        component.set("v.selectedDocumentId" , event.target.title); 
        
    },
    
})