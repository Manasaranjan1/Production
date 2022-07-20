({
    initData : function(component, event, helper) {
        component.set("v.hideSpinner",true);
        helper.loadDataAgain(component);
      
    },
    handleUploadFinishedTaxes: function (cmp, event,helper) {
        var uploadedFiles = event.getParam("files");
        helper.commonGetUploadedFiles(cmp,uploadedFiles);
        
    },
    handleUploadFinishedBusinessPlans: function (cmp, event,helper) {
        var uploadedFiles = event.getParam("files");
        helper.commonGetUploadedFiles(cmp,uploadedFiles);
    },
    handleUploadFinishedPermits: function (cmp, event,helper) {
        var uploadedFiles = event.getParam("files");
        helper.commonGetUploadedFiles(cmp,uploadedFiles);
    },
     
    handleUploadFinishedCertificates: function (cmp, event,helper) {
        var uploadedFiles = event.getParam("files");
        helper.commonGetUploadedFiles(cmp,uploadedFiles);
    },
    
    
    handleUploadFinishedFinancialDocs: function (cmp, event,helper) {
        var uploadedFiles = event.getParam("files");
        helper.commonGetUploadedFiles(cmp,uploadedFiles);
    },

    handleUploadFinishedOther: function (cmp, event,helper) {
        var uploadedFiles = event.getParam("files");
        helper.commonGetUploadedFiles(cmp,uploadedFiles);
    },
 
    
    closeModelPreview : function(component, event, helper) {
        component.set("v.hasModalOpen",false);
    },

    
    closeModel : function (cmp, event) {
        var cmpEvent = cmp.getEvent("cmpEvent");        
        cmpEvent.fire();
    },
    previewFile : function(component,event,helper){
        // display modle and set seletedDocumentId attribute with selected record Id   
        component.set("v.hasModalOpen" , true);
        component.set("v.selectedDocumentId" , event.target.title); 
        
    },
})