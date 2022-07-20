({
    MAX_FILE_SIZE: 4500000, //Max file size 4.5 MB 
    CHUNK_SIZE: 750000,      //Chunk Max size 750Kb 
     
    uploadHelper1: function(component, event) {
        // start/show the loading spinner   
        component.set("v.showLoadingSpinner1", true);
        // get the selected files using aura:id [return array of files]
        
        /*  **************** */
        /*
        var label1 = component.find("fileId1").get('v.label');
        var label2 = component.find("fileId2").get('v.label');
        var fileInput;
        if(label1==="Pay Slip"){
           fileInput = component.find("fileId1").get("v.files");                
        }
        
        if(label1==="Form 16"){
           fileInput = component.find("fileId2").get("v.files");                
        }
          
        var fileInput = component.find("fileId2").get("v.files");  */
        
        /*  **************** */
        
        
        var fileInput = component.find("fileId1").get("v.files");   // Change here
        // get the first file using array index[0]  
        var file = fileInput[0]; 
        
        
        
        var self = this;
        // check the selected file size, if select file size greter then MAX_FILE_SIZE,
        // then show a alert msg to user,hide the loading spinner and return from function  
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner1", false);
            component.set("v.fileName1", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
        }
 
        // create a FileReader object 
        var objFileReader = new FileReader();
        // set onload function of FileReader object   
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
 
            fileContents = fileContents.substring(dataStart);
            // call the uploadProcess method 
            self.uploadProcess1(component, file, fileContents);  //CALL  ****
        });
 
        objFileReader.readAsDataURL(file);

             
        
    },
    
    uploadHelper2: function(component, event) {
        // start/show the loading spinner   
        component.set("v.showLoadingSpinner2", true);
        // get the selected files using aura:id [return array of files]
        
        var fileInput = component.find("fileId2").get("v.files"); //Change here
        // Change here
        // get the first file using array index[0]  
        var file = fileInput[0]; 
                
        var self = this;
        // check the selected file size, if select file size greter then MAX_FILE_SIZE,
        // then show a alert msg to user,hide the loading spinner and return from function  
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner2", false);
            component.set("v.fileName2", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
        }
 
        // create a FileReader object 
        var objFileReader = new FileReader();
        // set onload function of FileReader object   
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
 
            fileContents = fileContents.substring(dataStart);
            // call the uploadProcess method 
            self.uploadProcess2(component, file, fileContents); //CALL ****
        });
 
        objFileReader.readAsDataURL(file);
        
        /*Newly Added */
       /* var uploadedFiles = event.getParam("files");
            self.commonGetUploadedFiles(cmp,uploadedFiles);
            alert('Extracted files');  */  
        
    },
    
    uploadHelper3: function(component, event) {
        // start/show the loading spinner   
        component.set("v.showLoadingSpinner3", true);
        // get the selected files using aura:id [return array of files]
        
        var fileInput = component.find("fileId3").get("v.files"); //Change here
        // Change here
        // get the first file using array index[0]  
        var file = fileInput[0]; 
                
        var self = this;
        // check the selected file size, if select file size greter then MAX_FILE_SIZE,
        // then show a alert msg to user,hide the loading spinner and return from function  
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner3", false);
            component.set("v.fileName3", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
        }
 
        // create a FileReader object 
        var objFileReader = new FileReader();
        // set onload function of FileReader object   
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
 
            fileContents = fileContents.substring(dataStart);
            // call the uploadProcess method 
            self.uploadProcess3(component, file, fileContents); //CALL ****
        });
 
        objFileReader.readAsDataURL(file);
        
        /*Newly Added */
       /* var uploadedFiles = event.getParam("files");
            self.commonGetUploadedFiles(cmp,uploadedFiles);
            alert('Extracted files');  */        
        
    },
    
    uploadHelper4: function(component, event) {
        // start/show the loading spinner   
        component.set("v.showLoadingSpinner4", true);
        // get the selected files using aura:id [return array of files]
        
        var fileInput = component.find("fileId4").get("v.files"); //Change here
        // Change here
        // get the first file using array index[0]  
        var file = fileInput[0]; 
                
        var self = this;
        // check the selected file size, if select file size greter then MAX_FILE_SIZE,
        // then show a alert msg to user,hide the loading spinner and return from function  
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner4", false);
            component.set("v.fileName4", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
        }
 
        // create a FileReader object 
        var objFileReader = new FileReader();
        // set onload function of FileReader object   
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
 
            fileContents = fileContents.substring(dataStart);
            // call the uploadProcess method 
            self.uploadProcess4(component, file, fileContents);  //CALL *****
        });
 
        objFileReader.readAsDataURL(file);
        
        /*Newly Added */
       /* var uploadedFiles = event.getParam("files");
            self.commonGetUploadedFiles(cmp,uploadedFiles);
            alert('Extracted files');   */  
        
    },

    uploadHelper5: function(component, event) {
        // start/show the loading spinner   
        component.set("v.showLoadingSpinner5", true);
        // get the selected files using aura:id [return array of files]
        
        var fileInput = component.find("fileId5").get("v.files"); //Change here
        // Change here
        // get the first file using array index[0]  
        var file = fileInput[0]; 
                
        var self = this;
        // check the selected file size, if select file size greter then MAX_FILE_SIZE,
        // then show a alert msg to user,hide the loading spinner and return from function  
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner5", false);
            component.set("v.fileName5", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
        }
 
        // create a FileReader object 
        var objFileReader = new FileReader();
        // set onload function of FileReader object   
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
 
            fileContents = fileContents.substring(dataStart);
            // call the uploadProcess method 
            self.uploadProcess5(component, file, fileContents);  //CALL *****
        });
 
        objFileReader.readAsDataURL(file);
        
        /*Newly Added */
       /* var uploadedFiles = event.getParam("files");
            self.commonGetUploadedFiles(cmp,uploadedFiles);
            alert('Extracted files');  */
        
    },
    
    uploadHelper6: function(component, event) {
        component.set("v.showLoadingSpinner6", true);
        
        var fileInput = component.find("fileId6").get("v.files"); //Change here
        var file = fileInput[0]; 
                
        var self = this;
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner6", false);
            component.set("v.fileName5", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
        }
 
        var objFileReader = new FileReader();
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
 
            fileContents = fileContents.substring(dataStart);
            self.uploadProcess6(component, file, fileContents);  //CALL *****
        });
 
        objFileReader.readAsDataURL(file);
        
        
    },
    
    
    uploadProcess1: function(component, file, fileContents) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk1(component, file, fileContents, startPosition, endPosition, '');
    },
    
    uploadProcess2: function(component, file, fileContents) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk2(component, file, fileContents, startPosition, endPosition, '');
    },
    
    uploadProcess3: function(component, file, fileContents) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk3(component, file, fileContents, startPosition, endPosition, '');
    },
    
    uploadProcess4: function(component, file, fileContents) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk4(component, file, fileContents, startPosition, endPosition, '');
    },
    
    uploadProcess5: function(component, file, fileContents) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk5(component, file, fileContents, startPosition, endPosition, '');
    },
 
    uploadProcess6: function(component, file, fileContents) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk6(component, file, fileContents, startPosition, endPosition, '');
    },
    
    /******************/
    uploadInChunk1: function(component, file, fileContents, startPosition, endPosition, attachId) {
        // call the apex method 'saveChunk'
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");
        action.setParams({
            parentId: component.get("v.recordId"),
            DocCategory: component.get("v.DocCategory1"),
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
 
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            attachId = response.getReturnValue(); //***********
            //alert(attachId);

            var state = response.getState();
            if (state === "SUCCESS") {
                // update the start position with end postion
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                // check if the start postion is still less then end postion 
                // then call again 'uploadInChunk' method , 
                // else, diaply alert msg and hide the loading spinner
                if (startPosition < endPosition) {
                    this.uploadInChunk1(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                   // alert('Your File is Uploaded Successfully');
                    //component.set("v.showLoadingSpinner1", false); //01
                    
                    component.set("v.spinner",false);           
                    this.loadDataAgain(component,event);
                    this.commonToastMessage(component,file.name);
                    
                    //component.set("v.upInputField1", true);
                    //component.set("v.upButton1", true); 
                    
                    /*Newly Added */
                    // var uploadedFiles = event.getParam("files");
                     // alert('Step 01');
                     //self.commonGetUploadedFiles(cmp,uploadedFiles);
                   // self.commonGetUploadedFiles(cmp);
                    // alert('Step 02');                     
                   // alert('Extracted files');   
                    
                  //this.commonGetUploadedFiles(component);  //calling other helper function  
                }
                // handel the response errors        
            } else if (state === "INCOMPLETE") {
                alert("From server: " + response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // enqueue the action
        $A.enqueueAction(action);
        
        //self.commonGetUploadedFiles(component);
    },

	uploadInChunk2: function(component, file, fileContents, startPosition, endPosition, attachId) {
        // call the apex method 'saveChunk'
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");
        action.setParams({
            parentId: component.get("v.recordId"),
            DocCategory: component.get("v.DocCategory2"),
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
 
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            attachId = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                // update the start position with end postion
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                // check if the start postion is still less then end postion 
                // then call again 'uploadInChunk' method , 
                // else, diaply alert msg and hide the loading spinner
                if (startPosition < endPosition) {
                    this.uploadInChunk2(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    //alert('Your File is Uploaded Successfully');
                    //component.set("v.showLoadingSpinner2", false);   //02
                    component.set("v.spinner",false);           
                    this.loadDataAgain(component,event);
                    this.commonToastMessage(component,file.name);
                    
                }
                // handel the response errors        
            } else if (state === "INCOMPLETE") {
                alert("From server: " + response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // enqueue the action
        $A.enqueueAction(action);
    },

    uploadInChunk3: function(component, file, fileContents, startPosition, endPosition, attachId) {
        // call the apex method 'saveChunk'
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");
        action.setParams({
            parentId: component.get("v.recordId"),
            DocCategory: component.get("v.DocCategory3"),
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
 
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            attachId = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                // update the start position with end postion
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                // check if the start postion is still less then end postion 
                // then call again 'uploadInChunk' method , 
                // else, diaply alert msg and hide the loading spinner
                if (startPosition < endPosition) {
                    this.uploadInChunk3(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    //alert('Your File is Uploaded Successfully');
                    //component.set("v.showLoadingSpinner3", false); //03
                    component.set("v.spinner",false);           
                    this.loadDataAgain(component,event);
                    this.commonToastMessage(component,file.name);
                }
                // handel the response errors        
            } else if (state === "INCOMPLETE") {
                alert("From server: " + response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // enqueue the action
        $A.enqueueAction(action);
    },

    uploadInChunk4: function(component, file, fileContents, startPosition, endPosition, attachId) {
        // call the apex method 'saveChunk'
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");//Calling APEX method
        action.setParams({
            parentId: component.get("v.recordId"),
            DocCategory: component.get("v.DocCategory4"),
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
 
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            attachId = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                // update the start position with end postion
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                // check if the start postion is still less then end postion 
                // then call again 'uploadInChunk' method , 
                // else, diaply alert msg and hide the loading spinner
                if (startPosition < endPosition) {
                    this.uploadInChunk4(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    //alert('Your File is Uploaded Successfully');
                    //component.set("v.showLoadingSpinner4", false); //04
                    component.set("v.spinner",false);           
                    this.loadDataAgain(component,event);
                    this.commonToastMessage(component,file.name);
                }
                // handel the response errors        
            } else if (state === "INCOMPLETE") {
                alert("From server: " + response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // enqueue the action
        $A.enqueueAction(action);
    },

    uploadInChunk5: function(component, file, fileContents, startPosition, endPosition, attachId) {
        // call the apex method 'saveChunk'
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");  //Calling Apex metho
        action.setParams({
            parentId: component.get("v.recordId"),
            DocCategory: component.get("v.DocCategory5"),
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
 
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            attachId = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                // update the start position with end postion
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                // check if the start postion is still less then end postion 
                // then call again 'uploadInChunk' method , 
                // else, diaply alert msg and hide the loading spinner
                if (startPosition < endPosition) {
                    this.uploadInChunk5(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    //alert('Your File is Uploaded Successfully');
                    //component.set("v.showLoadingSpinner5", false); //05
                    component.set("v.spinner",false);           
                    this.loadDataAgain(component,event);
                    this.commonToastMessage(component,file.name);
                }
                // handel the response errors        
            } else if (state === "INCOMPLETE") {
                alert("From server: " + response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // enqueue the action
        $A.enqueueAction(action);
    },
    
    uploadInChunk6: function(component, file, fileContents, startPosition, endPosition, attachId) {
        // call the apex method 'saveChunk'
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");  //Calling Apex Controller
        action.setParams({
            parentId: component.get("v.recordId"),
            DocCategory: component.get("v.DocCategory6"),
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
 		//alert(' attachId '+attachId);
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            attachId = response.getReturnValue();
            var state = response.getState();
            //alert(state+' ttt '+attachId);
            if (state === "SUCCESS") {
                // update the start position with end postion
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                // check if the start postion is still less then end postion 
                // then call again 'uploadInChunk' method , 
                // else, diaply alert msg and hide the loading spinner
                if (startPosition < endPosition) {
                    this.uploadInChunk6(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    //alert('Your File is Uploaded Successfully'+file.name);
                    //component.set("v.showLoadingSpinner6", false); //06
                    //component.set("v.upInputField6", true);
                    //component.set("v.upButton6", true);
                    component.set("v.spinner",false);           
                    this.loadDataAgain(component,event);
                    this.commonToastMessage(component,file.name);
                    
                    
                }
                // handel the response errors        
            } else if (state === "INCOMPLETE") {
                alert("From server: " + response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // enqueue the action
        $A.enqueueAction(action);
    },
    
    
    loadDataAgain : function(component,event) {
        var action = component.get('c.getFiles');
        action.setParams({ 
            "CounsellingSessionId" : component.get("v.recordId")           
        }); 
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnVale = response.getReturnValue();  
                component.set("v.myAttachments",returnVale);              
                component.set("v.spinner",false);
                //this.commonToastMessage(component,'abc.doc');
                //alert('Loading Data');
            }
        });
        $A.enqueueAction(action);
    },
    
	commonToastMessage : function(component,fileName) {		
       
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "File "+fileName+" is Uploaded Successfully.",
            "type" :"success"
        });
        toastEvent.fire();
	}, 
  
    /* Currently this method is Not in Use */ 
    commonGetUploadedFiles : function (component) {
        debugger;
     /*   for(var i=0;i<uploadedFiles.length;i++){
            var fileName = uploadedFiles[i].name;
            this.commonToastMessage(component,fileName);
        }   */
        var action = component.get('c.getFiles');  //Calling Apex method
        action.setParams({ 
            "CounsellingSessionId" : component.get("v.recordId")           
        }); 
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnVale = response.getReturnValue();  
                component.set("v.myAttachments",returnVale);              
                component.set("v.hideSpinner",false);
               // alert('Extracting upLoaded Data');
                //window.location.reload();
                
                component.set("v.isModalOpen", true);
                $A.get('e.force:refreshView').fire();
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The file is uploaded successfully.",
                     "type" :"success"
                });
                toastEvent.fire();
            }
            else{
                alert('Extraction failed');
            }
        });
        $A.enqueueAction(action);
        //window.location.reload();
        //alert('Done--->>');
    },  
    
          
})