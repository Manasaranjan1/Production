({
     initData : function(component, event, helper) {
        component.set("v.hideSpinner",true);
        component.set("v.isModalOpen", true); 
        helper.loadDataAgain(component,event);
        
        // var attc = Component.get("v.myAttachments");
         //alert(attc);    
    }, 
    
    
    doSave1: function(component, event, helper) {
        
        /* Upload Progress bar */
          /*  var interval = setInterval($A.getCallback(function () {
            var progress = component.get('v.progress');
            component.set('v.progress', progress === 100 ? clearInterval(interval) : progress + 10);
        }), 200);   */
        /* ********** */
        
        if (component.find("fileId1").get("v.files").length > 0) {     // Change here
            helper.uploadHelper1(component, event);
            //window.location.reload();
           
            //$A.get('e.force:refreshView').fire();
            //component.set("v.isModalOpen", true);
           
            //component.set("v.showUploadAttach",true);
            //component.set("v.isModalOpen", true);
            //var uploadedFiles = event.getParam("files");
            //alert('step 2');
                    
            //alert('Extracted files'); 
            //var attc = Component.get("v.myAttachments");
            //alert(attc);
        } 
                
        else {
            alert('Please Select a Valid File');
        }
       
    },
    
    doSave2: function(component, event, helper) {
        if (component.find("fileId2").get("v.files").length > 0) {     // Change here
            helper.uploadHelper2(component, event);
            //helper.commonGetUploadedFiles(component);
            //window.location.reload();
            
          /*  var uploadedFiles = event.getParam("files");
            helper.commonGetUploadedFiles(cmp,uploadedFiles); */
        } 
        else {
            alert('Please Select a Valid File');
        }
        
    },
    
    doSave3: function(component, event, helper) {
        if (component.find("fileId3").get("v.files").length > 0) {     // Change here
            helper.uploadHelper3(component, event);
            //helper.commonGetUploadedFiles(component);
            //window.location.reload();
            
           /* var uploadedFiles = event.getParam("files");
            helper.commonGetUploadedFiles(cmp,uploadedFiles);  */
        } 
        else {
            alert('Please Select a Valid File');
        }        
    },

    doSave4: function(component, event, helper) {
        if (component.find("fileId4").get("v.files").length > 0) {     // Change here
            helper.uploadHelper4(component, event);
            //helper.commonGetUploadedFiles(component);
            //window.location.reload();
            
          /*  var uploadedFiles = event.getParam("files");
            helper.commonGetUploadedFiles(cmp,uploadedFiles);  */
        } 
        else {
            alert('Please Select a Valid File');
        }
    },

    doSave5: function(component, event, helper) {
        if (component.find("fileId5").get("v.files").length > 0) {     // Change here
            helper.uploadHelper5(component, event);
            //helper.commonGetUploadedFiles(component);
            //window.location.reload();
            
            /* var uploadedFiles = event.getParam("files");
            helper.commonGetUploadedFiles(cmp,uploadedFiles);  */
        } 
        else {
            alert('Please Select a Valid File');
        }
        
    },
    
    doSave6: function(component, event, helper) {
        if (component.find("fileId6").get("v.files") != null) {     // Change here
            helper.uploadHelper6(component, event);
            //helper.commonGetUploadedFiles(component);
            //window.location.reload();
            
          /*  var uploadedFiles = event.getParam("files");
            helper.commonGetUploadedFiles(cmp,uploadedFiles);   */
        } 
        else {
            alert('Please Select a Valid File');
        }
        
    },
    
   
    handleFilesChange1: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName1", fileName);
    },
       
    handleFilesChange2: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName2", fileName);
    },
      
    handleFilesChange3: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName3", fileName);
    },
    
    handleFilesChange4: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName4", fileName);
    },
    
    handleFilesChange5: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName5", fileName);
    },
   
    handleFilesChange6: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName6", fileName);
    },
    
   openModel: function(component, event, helper) {
      // Set isModalOpen attribute to true
      component.set("v.isModalOpen", true);
   },
  
   closeModel: function(component, event, helper) {
      // Set isModalOpen attribute to false  
      component.set("v.isModalOpen", false);
      component.set("v.showUploadAttach",false);
   },
  
   submitDetails: function(component, event, helper) {
      // Set isModalOpen attribute to false
      //Add your code to call apex method or do some processing
      //component.set("v.isModalOpen", false);
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
    
    
    handleCancel: function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
        component.set("v.showLoadingSpinner1", false);
        component.set("v.fileName", "");
    }, 
    
    previewFile : function(component,event,helper){
        // display modle and set seletedDocumentId attribute with selected record Id   
        component.set("v.hasModalOpen" , true);
        component.set("v.selectedDocumentId" , event.target.title); 
    },
    closeModelPreview : function(component, event, helper) {
        component.set("v.hasModalOpen",false);
    },
    
})