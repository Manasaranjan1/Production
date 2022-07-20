({
    SubmitMethod: function (component, event, helper) {
        var leaddata =  component.get('v.leadObject');
       
        var noOfEmps = component.find("noOfEmps").get('v.value');
        var allValid = component.find('fieldId').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && !inputCmp.get('v.validity').valueMissing;
        }, true);
        if (allValid) {
            var action = component.get("c.createLead");
        } else {
            return;
        }
                   
        action.setParams({
            objLeadData : leaddata,
            noOfEmployees : noOfEmps
            
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if( response.getReturnValue() == 'Your application has been submitted successfully.')
                {
                    alert(response.getReturnValue());
                    helper.callRedirect(component, event, helper);
                }
                else      
                { 
                    alert(response.getReturnValue());
                }
            }
            else {
                
            }
        });
        
        $A.enqueueAction(action);
    },
    toggleAction : function(component, event, secId) {
        var acc = component.find(secId);
        for(var cmp in acc) {
            $A.util.toggleClass(acc[cmp], 'slds-show');  
            $A.util.toggleClass(acc[cmp], 'slds-hide');  
        }
    },    
    callRedirect: function(component, event){
        //alert('redirect check');
        setTimeout(() => {  console.log("Processing . . 1"); }, 6000);
                          //setTimeout(function(){ alert('Processing. . 2'); }, 3000);
                          //alert("Your Form is Submitted Successfully \nThank You");                  
                          window.location.href = 'https://thecenterbylendistry.org/';
      },
                          
       fetchPicklistValues: function(component, objDetails, controllerField, dependentField, mapAttrName) {
                              // call the server side function  
                              var action = component.get("c.getDependentMap");
                              // pass paramerters [object definition , contrller field name ,dependent field name] -
                              // to server side function 
                              action.setParams({
                                  'leadObject' : objDetails,
                                  'contrfieldApiName': controllerField,         // <!-- objDetail ==> leadObject -->
                                  'depfieldApiName': dependentField 
                              });
                              //set callback   
                              action.setCallback(this, function(response) {
                                  if (response.getState() == "SUCCESS") {
                                      //store the return response from server (map<string,List<string>>)  
                                      var StoreResponse = response.getReturnValue();
                                      // once set #StoreResponse to depnedentFieldMap attribute 
                                      component.set(mapAttrName,StoreResponse);
                                      
                                      if(mapAttrName == 'v.depnedentFieldMap'){
                                          
                                          // create a empty array for store map keys(@@--->which is controller picklist values) 
                                          var listOfkeys = []; // for store all map keys (controller picklist values)
                                          var ControllerField = []; // for store controller picklist value to set on lightning:select. 
                                          
                                          // play a for loop on Return map 
                                          // and fill the all map key on listOfkeys variable.
                                          for (var singlekey in StoreResponse) {
                                              listOfkeys.push(singlekey);
                                          }
                                          
                                          //set the controller field value for lightning:select
                                          if (listOfkeys != undefined && listOfkeys.length > 0) {
                                              ControllerField.push('--None--');
                                          }
                                          
                                          for (var i = 0; i < listOfkeys.length; i++) {
                                              ControllerField.push(listOfkeys[i]);
                                          }  
                                          // set the ControllerField variable values to country(controller picklist field)
                                          component.set("v.listControllingValues", ControllerField);
                                      }
                                  }else{
                                      alert('Something went wrong..');
                                  }
                              });
                              $A.enqueueAction(action);
           },
                          
           fetchDepValues: function(component, ListOfDependentFields,lstAttrName) {
                              // create a empty array var for store dependent picklist values for controller field  
                              var dependentFields = [];
                              dependentFields.push('--None--');
                              for (var i = 0; i < ListOfDependentFields.length; i++) {
                                  dependentFields.push(ListOfDependentFields[i]);
                              }
                              // set the dependentFields variable values to store(dependent picklist field) on lightning:select
                              component.set(lstAttrName, dependentFields);
                              
           },
                          
       /*Fetch Custom Metadata */
       fetchCustumMetadata: function(component,event,helper) {
            var action = component.get("c.getCMD");
            action.setCallback(this, function(response) {
              var state = response.getState();
              if (state === "SUCCESS"){
                var result = response.getReturnValue();
                //alert(result);  
                component.set("v.cmdMap", result);
                 // alert('Map returned: '+component.get("v.cmdMap"));
                /* var plValues = [];
                 for (var i = 0; i < result.length; i++) {
                     plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                component.set("v.GenreList", plValues);*/
               }
              else{
                     alert("Something Went Wrong");
              }
        });
        $A.enqueueAction(action);                 
      },               
                          
})