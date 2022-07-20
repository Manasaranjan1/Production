({
    doInit : function(component, event, helper) { 
        
        
        // get the fields API name and pass it to helper function 
        var urlString =window.location.href;
        var ReferralPartnerName = '';
        if( urlString.includes('='))
            ReferralPartnerName= urlString.substring(urlString.indexOf('=') + 1);
        else
            ReferralPartnerName='Center Intake Form';
        
        var uri_dec = decodeURI(ReferralPartnerName);
         component.set('v.leadObject.Referral_Partner1__c',uri_dec);
        var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var dependingFieldAPI = component.get("v.dependingFieldAPI");
        var subDependingFieldAPI = component.get("v.subDependingFieldAPI");   //   <!-- objDetail ==> leadObject -->
          
        var objDetails = component.get("v.leadObject");
        
        
        
        // call the helper function
        helper.fetchPicklistValues(component,objDetails,controllingFieldAPI, dependingFieldAPI, "v.depnedentFieldMap");
        
        // 2nd and 3rd picklist 
        helper.fetchPicklistValues(component,objDetails,dependingFieldAPI, subDependingFieldAPI, "v.subDepnedentFieldMap");
       
        //call helper for Custom Metadata
           helper.fetchCustumMetadata(component,event,helper);
        
        var action = component.get("c.getPiklistValues");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                var plValues = [];
                for (var i = 0; i < result.length; i++) {
                    plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                component.set("v.GenreList", plValues);
            }
        });
        $A.enqueueAction(action);
        

    },
    onControllerFieldChange: function(component, event, helper) {     
        var controllerValueKey = event.getSource().get("v.value"); // get selected controller field value
        var depnedentFieldMap = component.get("v.depnedentFieldMap");
        
        if (controllerValueKey != '--None--') {
            // disable and reset sub dependent field 
            
            var ListOfDependentFields = depnedentFieldMap[controllerValueKey];
            
            if(ListOfDependentFields.length > 0){
                component.set("v.bDisabledDependentFld" , false);  
                helper.fetchDepValues(component, ListOfDependentFields,"v.listDependingValues");    
            }else{
                component.set("v.bDisabledDependentFld" , true); 
                component.set("v.listDependingValues", ['--None--']);
            }  
            
        } else {
            component.set("v.listDependingValues", ['--None--']);
            component.set("v.bDisabledDependentFld" , true);
        }
        
        component.set("v.bDisabledSubDependentFld" , true);
        component.set("v.listSubDependingValues", ['--None--']);
    },
    onSubControllerFieldChange : function(component, event, helper) {     
        var controllerValueKey = event.getSource().get("v.value"); // get selected sub controller field value
        var depnedentFieldMap = component.get("v.subDepnedentFieldMap");
        
        if (controllerValueKey != '--None--') {
            var ListOfDependentFields = depnedentFieldMap[controllerValueKey];
            if(ListOfDependentFields.length > 0){
                component.set("v.bDisabledSubDependentFld" , false);  
                helper.fetchDepValues(component, ListOfDependentFields,"v.listSubDependingValues");    
            }else{
                component.set("v.bDisabledSubDependentFld" , true); 
                component.set("v.listSubDependingValues", ['--None--']);
            }  
            
        } else {
            component.set("v.listSubDependingValues", ['--None--']);
            component.set("v.bDisabledSubDependentFld" , true);
        }
    },
    handleSectionToggle: function (cmp, event) {
        var openSections = event.getParam('openSections');
        
        if (openSections.length === 0) {
            cmp.set('v.activeSectionsMessage', "All sections are closed");
        } else {
            cmp.set('v.activeSectionsMessage', "Open sections: " + openSections.join(', '));
        }
    },
    
    submitJSMethod: function (component, event, helper) 
    {      
        helper.SubmitMethod(component, event, helper);
    },
    handleFilesChange0: function (component, event, helper) {
        var amCmp = component.find("checkbox0").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
           component.set("v.leadObject.Use_of_Funds__c",amCmp);
    },
    handleFilesChange1: function (component, event, helper) {
        var amCmp = component.find("checkbox1").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
            component.set("v.leadObject.Use_of_Funds__c",amCmp);
        
        console.log('???????/'+userfund);
    },
    handleFilesChange2: function (component, event, helper) {
        
       var amCmp = component.find("checkbox2").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
               component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
            component.set("v.leadObject.Use_of_Funds__c",amCmp);
         console.log('???????/'+userfund);
    },
    handleFilesChange3: function (component, event, helper) {
       var amCmp = component.find("checkbox3").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
           component.set("v.leadObject.Use_of_Funds__c",amCmp);
         console.log('???????/'+userfund);
    },
    handleFilesChange4: function (component, event, helper) {
        var amCmp = component.find("checkbox4").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
           component.set("v.leadObject.Use_of_Funds__c",amCmp);
         console.log('???????/'+userfund);
    },
    handleFilesChange5: function (component, event, helper) {
       var amCmp = component.find("checkbox5").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
           component.set("v.leadObject.Use_of_Funds__c",amCmp);
         console.log('???????/'+userfund);
    },
    handleFilesChange6: function (component, event, helper) {
        var amCmp = component.find("checkbox6").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
           component.set("v.leadObject.Use_of_Funds__c",amCmp);
         console.log('???????/'+userfund);
    },
    handleFilesChange7: function (component, event, helper) {
        var amCmp = component.find("checkbox7").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
           component.set("v.leadObject.Use_of_Funds__c",amCmp);
         console.log('???????/'+userfund);
    },
    handleFilesChange8: function (component, event, helper) {
       var amCmp = component.find("checkbox8").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
               component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
          component.set("v.leadObject.Use_of_Funds__c",amCmp);
         console.log('???????/'+userfund);
    },
    handleFilesChange9: function (component, event, helper) {
       var amCmp = component.find("checkbox9").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
            component.set("v.leadObject.Use_of_Funds__c",amCmp);
    },
    handleFilesChange10: function (component, event, helper) {
        var amCmp = component.find("checkbox10").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                 component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
            component.set("v.leadObject.Use_of_Funds__c",amCmp);
    }, 
    handleFilesChange11: function (component, event, helper) {
        var amCmp = component.find("checkbox11").get("v.label");
        var chk = event.getSource().get('v.checked');
        // old value
        var userfund = component.get("v.leadObject.Use_of_Funds__c");
        if(userfund!=undefined){
            if(chk == true){
                userfund = userfund+';'+amCmp;
                 component.set("v.leadObject.Use_of_Funds__c",userfund);
            }            
        }
        else
             component.set("v.leadObject.Use_of_Funds__c",amCmp);
          
    },
    onCheck : function(component, event, helper) {
        
        var amCmp = component.find("checkbox23").get("v.value");
        var amCm1p = component.find("checkbox23").get("v.label");
    },
    panelOne : function(component, event, helper) {
        helper.toggleAction(component, event, 'panelOne');
    },
    panelTwo : function(component, event, helper) {
        helper.toggleAction(component, event, 'panelTwo');
    },
    panelThree : function(component, event, helper) {
        helper.toggleAction(component, event, 'panelThree');
    },
    panelFour : function(component, event, helper) {
        helper.toggleAction(component, event, 'panelFour');
    },
    panelFive : function(component, event, helper) {
        helper.toggleAction(component, event, 'panelFive');
    },
    WBEClicked : function(component, event, helper){
        var amCmp = component.find("WBECheckbox").get("v.label");
        var chk = event.getSource().get('v.checked');
        var test = component.find("WBECheckbox").get("v.value");
        if(chk == true){
            
            component.set("v.leadObject.WBE__c", true);
            component.set('v.WBE',true);
        }
        if(chk == false){
            component.set("v.leadObject.WBE__c", false);
            component.set('v.WBE',false);
        }
        
    },
    WBEClicked1 : function(component, event, helper){
        var amCmp = component.find("WBECheckbox1").get("v.label");
        var amCmp1 = component.find("WBECheckbox1").get("v.value");
        var chk = event.getSource().get('v.checked');
        if(chk == true){
            component.set("v.leadObject.MBE__c", true);

            component.set('v.MBE',true);
        }
        if(chk == false){
            component.set("v.leadObject.MBE__c", false);
            //console.log('----false---MBE__c--Tesing --Boddh-->'+component.get("v.leadObject.MBE__c"));
            component.set('v.MBE',false);
        }
        
    },
    WBEClicked2 : function(component, event, helper){
        var amCmp = component.find("WBECheckbox2").get("v.label");
        var chk = event.getSource().get('v.checked');
        // alert(chk);
        if(chk == true){
            component.set("v.leadObject.Other1__c", true);
            
            component.set('v.HIRE',amCmp);
        }
        if(chk == false){
            component.set("v.leadObject.Other1__c", false);
            
            component.set('v.HIRE',false);
        }
        
    },
    LSBEClicked : function(component, event, helper){
        var amCmp = component.find("LSBECheckbox").get("v.label");
        var chk = event.getSource().get('v.checked');
        if(chk == true){
            component.set("v.leadObject.LSBE__c", true);
            
            component.set('v.LSBE',amCmp);
        }
        if(chk == false){
            component.set("v.leadObject.LSBE__c", false);
            
            component.set('v.LSBE',false);
        }
    },
    SBEClicked: function(component, event, helper){
        var amCmp = component.find("SBECheckbox").get("v.label");
        var chk = event.getSource().get('v.checked');
        //alert(chk);
        if(chk == true){
            component.set("v.leadObject.SBE__c", true);
            
            component.set('v.SBE',amCmp);
        }
        if(chk == false){
            component.set("v.leadObject.SBE__c", false);
            
            component.set('v.SBE',false);
        }
    },
    checkfutureDate :  function(cmp, event, helper) {
        debugger;
        var g1 = new Date()
        var currentdate = event.getSource().get("v.value");
        var g2 = new Date(currentdate);
        if (g1.getTime() < g2.getTime()){
            var  allInputFlds =  cmp.find('fieldId');         
            for(var i=0;i<allInputFlds.length;i++){
                var nameValue = allInputFlds[i].get("v.name");
                if(nameValue=="BusinessStartDate"){
                     $A.util.addClass(cmp.find("fteError"),"show");
                }
            }           
        }
        else     {
             $A.util.removeClass(cmp.find("fteError"), "show");
        }
    },
    handleChange: function(cmp, event, helper) {
        var Ethnicity = cmp.find("Ethnicity").get("v.value");
        //var lastname = cmp.find("lastname").get("v.value");
    },
    validateBusinessPhone : function(component, event, helper) {
        
        var phoneNo = component.find("BusinessPhone");
        var phoneNumber = phoneNo.get('v.value');
        var s = (""+phoneNumber).replace(/\D/g, '');
        var m = s.match(/^(\d{3})(\d{3})(\d{4})$/);
        var formattedPhone = (!m) ? null : "(" + m[1] + ") " + m[2] + "-" + m[3];
        phoneNo.set('v.value',formattedPhone);
        
        return;
    },
    validateBusStartDate : function(component, event, helper) {
        
        var phoneNo = component.find("phone");
        var phoneNumber = phoneNo.get('v.value');
        var s = (""+phoneNumber).replace(/\D/g, '');
        var m = s.match(/^(\d{3})(\d{3})(\d{4})$/);
        var formattedPhone = (!m) ? null : "(" + m[1] + ") " + m[2] + "-" + m[3];
        phoneNo.set('v.value',formattedPhone);
        
        return;
    },
    ValidateEmail : function(component, event, helper) {  
    },
    getURLParameter : function(param) {
        var result=decodeURIComponent
        ((new RegExp('[?|&]' + param + '=' + '([^&;]+?)(&|#|;|$)').
          exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null;
        console.log('Param ' + param + ' from URL = ' + result);
        return result;
    },
    // this function automatic call by aura:waiting event  
    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
    },
    // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
    },
    handleGenreChange: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
         
        //Update the Selected Values  
        component.set("v.selectedGenreList", selectedValues);
    },
     
    getSelectedGenre : function(component, event, helper){
        //Get selected Genre List on button click 
        var selectedValues = component.get("v.selectedGenreList");
        console.log('Selectd Genre-' + selectedValues);
    },
    Pickilistvalue: function(component,helper,event){
        //alert(component.find('HearaboutId').get('v.value') + '  is Selected');
        var selectValue= component.find('HearaboutId').get('v.value');
        if(selectValue == 'Center Business Advisor'){
            component.set("v.showdiv", true);
        }
        else{
            component.set("v.showdiv", false);
        }
    },  
    callKeyUp : function(component, event, helper) {  
          
        //if ( event.keyCode == 13 )  
         //   alert(component.get("v.leadObject.Zip_Code_Owner_1__c")); 
         var zp = component.find("ZipId").get("v.value");
        //alert(zp);
        var county;
        var cmMap = component.get("v.cmdMap");
        let val;
        /* if(zp.length === 4){         //99929  
             //alert('hi, I m in 4');
            //var cmMap = component.get("v.cmdMap");
             //alert('cmMap.keys() : '+Object.keys(cmMap)); //******
             //alert('cmMap.values() : '+Object.values(cmMap)); 
             //var kk = Object.keys(cmMap)
             //let val;
             //alert('zp'+zp); //1004
             for(var key of Object.keys(cmMap)){
                    //alert(key);
                    if(zp == key) {
                       //alert('inside if (zp == key)'); 
                      val = cmMap[key];
                      //alert('Done '+val);
                      break;  
                    }                     
             }
             component.set("v.leadObject.County__c", val);
             
         }  */
         if(zp.length === 5){         
            //alert('hi, I m in 5');
            //var cmMap = component.get("v.cmdMap");
             //alert('cmMap.keys() : '+Object.keys(cmMap)); //******
             //alert('cmMap.values() : '+Object.values(cmMap)); 
             //var kk = Object.keys(cmMap)
             //let val;
             //alert('zp'+zp); //1004
             for(var key of Object.keys(cmMap)){
                    //alert(key);
                    if(zp == key) {
                       //alert('inside if (zp == key)'); 
                      val = cmMap[key];
                      //alert('Done '+val);
                      break;  
                    }                     
             }
             component.set("v.leadObject.County__c", val);
         }              
         
    },  
})