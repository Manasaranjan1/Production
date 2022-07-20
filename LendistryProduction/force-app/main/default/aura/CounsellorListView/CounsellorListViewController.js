({
    doInit: function(component, event, helper) {
        helper.getAccountList(component);
    },
    searchKeyChange: function(component, event,helper) {
        var query ;
        var varfinalString = component.get("v.finalString");
        var  objEctName = 'Counseling_Session__c';
        var filterCondition = component.get("v.Filter");
        var searchKey = component.find("searchKey").get("v.value");
        
        if(searchKey !=undefined && searchKey.length>=3 && searchKey !=""){
            
            if( filterCondition!=undefined && filterCondition !=''){            
                filterCondition = filterCondition+' '+'OR Lead_Business_Name__c LIKE\''+'%'+ searchKey+ '%'+ '\' '+' '+'OR LeadFormula__c LIKE\''+'%'+ searchKey+ '%'+ '\' '+' '+'OR Name LIKE\''+'%'+ searchKey+ '%'+ '\' '+' '+'OR Counsellor_Name__c LIKE\''+'%'+ searchKey+ '%'+ '\' ';
                
            }
            else{
                filterCondition='';
                filterCondition = filterCondition+' '+' Lead_Business_Name__c LIKE\''+'%'+ searchKey+'%'+ '\' '+' '+'OR LeadFormula__c LIKE\''+'%'+ searchKey+ '%'+ '\' '+' '+'OR Name LIKE\''+'%'+ searchKey+ '%'+ '\' '+' '+'OR Counsellor_Name__c LIKE\''+'%'+ searchKey+ '%'+ '\' ';    // 'AND  Counsellor1__c=\''+component.get("v.userId")+ '\'   
            }
            //query = 'select '+varfinalString+' '+ 'from'+' '+objEctName+' '+'where'+' ' +filterCondition+' order by LeadFormula__c ' +component.get("v.sortOrder");
            query = 'select '+varfinalString+' '+ 'from'+' '+objEctName+' '+'where'+' ' +filterCondition+' order by Name ' +component.get("v.sortOrder");
        }        
        else{
            helper.commonFilterRemoval(component,'Name',filterCondition);
            filterCondition = component.get("v.Filter");
            if( filterCondition==undefined || filterCondition ==''){            
                filterCondition = '';
                
            }
            query = 'select '+varfinalString+' '+ 'from'+' '+objEctName+'  order by Name ' +component.get("v.sortOrder");
            
        }
        console.log('searchKey:::::'+searchKey);
        
        
        component.set("v.query",query);
        console.log('queryquery'+query);
        var action = component.get("c.getData");
        action.setParams({
            "soql": query
        });
        action.setCallback(this, function(response) {
            var savedData = component.get("v.wholeData");
            var returnValue= response.getReturnValue();
            savedData.listOfRecord= returnValue;
            component.set("v.returnVale",savedData);
            if(returnValue!=undefined && returnValue.length>0){
                component.set("v.showError",false);
                helper.databinding(component,savedData.listOfRecord,component.get("v.conditionTypeOptions")); 
            }
            
            else{
                component.set("v.showError",true);
                component.set("v.hideSpinner",false);
                var empty=[];
                component.set('v.PaginationList', empty);
            }
        });
        $A.enqueueAction(action);
    },
    handleStartClick : function(component, event, helper) {
        console.log("start button clicked!!");
        helper.setStartTimeOnUI(component);
    },
    handleStopClick : function(component, event, helper) {
        debugger;
        console.log("stop button clicked!!");
        helper.setStopTimeOnUI(component);
        helper.saveTimingTrack(component,event);
    },
    handleResetClick : function(component, event, helper) {
        console.log("Reset button clicked!!");
        helper.setResetTimeOnUI(component);
    }, 
    startTimeTracking:  function(component, event, helper) {
        console.log('Button clicked');
        var buttonClickTime = new Date();
        console.log('buttonClickTime: '+buttonClickTime);
        component.set("v.startTimeTracking",buttonClickTime);
        console.log('fetch from component: '+buttonClickTime);
        component.set("v.timeInput",buttonClickTime);
        if(component.get("v.trackerName")=="Start Tracking")
            component.set("v.trackerName","Stop Tracking");
        else
            component.set("v.trackerName","Start Tracking");
    },
    seletecFilterMenu : function(component, event, helper) {
        var selectedMenuItemValue = event.getParam("value");
        if(selectedMenuItemValue=="AddRemoveColumn"){
            component.set("v.showAddColumn",true);
        }
        if(selectedMenuItemValue=="AddFilter"){
            component.set("v.showfilter",true);
        }
        if(selectedMenuItemValue=="RemoveAllFilter"){
            component.set("v.hideSpinner",true);
            var query = component.get("v.query");
            //alert(query);
            component.set("v.Filter","");
            helper.sortDataFromServer(component,query);
        } 
    },
    
    handleChange :  function(component, event, helper) {       
        var selectedItems = component.get("v.fieldList");
        console.log('selectedItemsselectedItems'+selectedItems+'component.get("v.defaultOptions")'+component.get("v.defaultOptions"));
    },
    enableNotiBar : function(component, event, helper) {
        alert('Hello Noti....');
    },
    goToPage : function(component, event, helper) {
        var oldPage = component.get("v.oldPage");
        var currentPageNumber = parseInt(event.target.value)
        if(oldPage<currentPageNumber){
            var sObjectList = component.get("v.mydata");   // ********
            var end = component.get("v.endPage");
            var start = component.get("v.startPage");
            var pageSize = component.get("v.pageSize");
            var Paginationlist = [];
            var counter = 0;
            for(var i=(end+1)*currentPageNumber; i<(end+1)*currentPageNumber+pageSize+1; i++){
                if(sObjectList.length > i){
                    Paginationlist.push(sObjectList[i]);
                }
                counter ++ ;
            }
            start = start + counter;
            end = end + counter;
            component.set("v.startPage",start);
            component.set("v.endPage",end);
            component.set('v.PaginationList', Paginationlist);
        }
        else{
            helper.previous(component, event);
        }
        component.set("v.oldPage",currentPageNumber);
        
    },
    logout : function(component, event, helper) {
        var url = window.location.hostname;        
        window.location.replace("https://"+url+"/s/login/");
        
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        
        var action = component.get("c.sessionStopTime");
        action.setParams({ "LogInUserID" : userId });
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
            } 
            else {
            }
        });
        $A.enqueueAction(action);
    },
    handleComponentEvent  : function(component, event, helper) {
        
        var varfinalString = component.get("v.finalString");
        var  objEctName = 'Counseling_Session__c';
        var operator = component.get("v.operator");   
        var selectedAccountGetFromEvent = event.getParam("recordByEvent");
        var filterCOnd = component.get("v.Filter"); 
        var filterSelectedMapValue = component.get("v.filterApi");
        helper.commonFilterRemoval(component,'Lead__c',filterCOnd);
        var filterCondition = component.get("v.Filter");
        if( filterCondition!=undefined && filterCondition !=''){            
            if(operator=="=" ){
                filterCondition= filterCondition+' '+'AND Lead__c =\'' +selectedAccountGetFromEvent.Id+ '\' ';
            }
        }
        else{
            if(operator=="=" ){
                filterCondition='';
                filterCondition= filterCondition+' Lead__c=\'' +selectedAccountGetFromEvent.Id+ '\' ';
                
            }
        }
        component.set("v.Filter",filterCondition);
        var query = 'select '+varfinalString+' '+ 'from'+' '+objEctName+' '+'where'+' ' +filterCondition+' order by Name ' +component.get("v.sortOrder");
        helper.sortDataFromServer(component,query);
        component.set("v.showfilter",false);
        component.set("v.selectedValue","");
    },
    getBoolValue :  function(component, event, helper) {
        component.set("v.selectedValue",event.getSource().get("v.checked"));
        
    },
    initData : function(component, event, helper) {
        
        
        // component.set("v.hideSpinner",true);
        var action = component.get('c.getConfigurationData');
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnVale = response.getReturnValue();
                component.set("v.fieldColumn",returnVale.listOfField);
                component.set("v.sortOrder",returnVale.sortOrder);
                component.set("v.orderBy",returnVale.orderby );
                component.set("v.query",returnVale.query );
                component.set("v.userId",returnVale.currentUserId );
                
                component.set("v.finalString",returnVale.finalString );
                component.set("v.wholeData",returnVale);
                component.set("v.conditionTypeOptions",returnVale.fieldquerylist);
                var listField=[];
                var listInterested=[];
                var fieldApiName = returnVale.fieldquerylist;
                for(var i=0;i<fieldApiName.length;i++){
                    listField.push(fieldApiName[i].fapi);
                }
                component.set("v.brokerFields",listField);
                // call helper for data binding
                helper.databinding(component,returnVale.listOfRecord,returnVale.fieldquerylist);
                
                var selectedColumnFilter = returnVale.listOfField;
                var selectedCoulmn = returnVale.fieldquerylist;
                // remove avaliable column
                var options  = [];
                var values = [];
                var mapValue= returnVale.mapForDualList;
                for(var i=0;i<returnVale.listOfField.length;i++){                    
                    var isExistLabel = mapValue[returnVale.listOfField[i]];
                    if(isExistLabel !=undefined){
                        values.push(returnVale.listOfField[i]);
                        //values=["Deleted"];
                    }
                    else{
                        options.push(returnVale.listOfField[i]);
                        
                    }
                    
                }                       
                
                console.log('1111111'+options+'plValuesplValues'+values);
                
                component.set("v.listOptions",options);
                component.set("v.defaultOptions",values);                
                component.set("v.mapOfFieldset",returnVale.mapOfFiewldNameWithWrapper);
                
                //set response value in wrapperList attribute on component.
                
            }
        });
        $A.enqueueAction(action);
    },
    sortTheData : function(component, event, helper) {
        component.set("v.hideSpinner",true);
        var columnName = event.getParam("columnName");//event.target.title;
        helper.commonQueryMaker(component,columnName);
        
    },
    getUpdatedData :  function(component, event, helper) {
        component.set("v.showAddColumn",false);       
        helper.commonQueryMaker(component,"Name");
    },
    
    
    handleGenreChange: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
        
        //Update the Selected Values  
        component.set("v.selectedGenreList", selectedValues);
    },
    
    closeModel : function (component, event, helper) {
        component.set("v.showAddColumn",false);
    },
    closeModel1 :function (component, event, helper) {
        component.set("v.showfilter",false);
    },
    
    getOperator : function (component, event, helper) {
        component.set("v.hidevalueInput",true);
    },
    getSelectedValue : function (component, event, helper) {
        
        
        var selectedVal = event.getSource().get("v.value");
        var mapValue = component.get("v.mapOfFieldset");
        for(var key in mapValue ){  
            if(selectedVal==key){
                var mapKeyValue = mapValue[key];
                component.set("v.typeValue",mapKeyValue.type);
                component.set("v.fieldName",mapKeyValue.label);
                if(mapKeyValue.type=='PICKLIST'){
                    component.set("v.picklistValue",mapKeyValue.listOfOption);
                }
                var apiName = mapKeyValue.apiName;
                component.set("v.filterApi",mapKeyValue);
                console.log('mapKeyValuemapKeyValue'+mapKeyValue.apiName);
                break;
            }
        }
        helper.setOperator(component,mapKeyValue.type); 
        
    },
    applyFilter : function (component, event, helper) {
        var idLeadLookUp = component.get("v.LeadLookUpId"); //alert();
        component.set("v.hideSpinner",true);
        var filterCOnd = component.get("v.Filter"); 
        var filterSelectedMapValue = component.get("v.filterApi");
        var fieldType = filterSelectedMapValue.type;
        if((filterSelectedMapValue.apiName=="LeadFormula__c" ||filterSelectedMapValue.apiName=="Lead__c" ) && idLeadLookUp.includes("00Q")){
            filterSelectedMapValue.apiName='Lead__c';
            fieldType = "REFERENCE"
        }
        if(filterSelectedMapValue.apiName=="Counsellor_Name__c" || filterSelectedMapValue.apiName=="Counsellor1__c"){
            filterSelectedMapValue.apiName='Counsellor1__c';
            fieldType = "REFERENCE"
        }
          
        if(filterSelectedMapValue.apiName=="CreatedDate")
            helper.commonFilterRemoval(component,"Created_Date_Formula__c",filterCOnd);
        else if(filterSelectedMapValue.apiName=="LastModifiedDate")
            helper.commonFilterRemoval(component,"LastModifiedByFormula__c",filterCOnd);
        else
            helper.commonFilterRemoval(component,filterSelectedMapValue.apiName,filterCOnd);
        var  objEctName = 'Counseling_Session__c';
        var varfinalString = component.get("v.finalString");            
        component.set("v.whichField",filterSelectedMapValue.apiName);
        var operator = component.get("v.operator");             
        var selectedFiltervalue = component.get("v.selectedValue");
        
        var filterCondition = component.get("v.Filter");
        var columnName = component.get("v.orderBy");
       
        
        if( filterCondition!=undefined && filterCondition !=''){ 
            if(fieldType=="REFERENCE"){
                if(operator=="=")
                    filterCondition= filterCondition+' ' +filterSelectedMapValue.apiName+'=\'' +component.get("v.LeadLookUpId")+ '\''; 
            if(operator=="!=")
                    filterCondition= filterCondition+' ' +filterSelectedMapValue.apiName+'!=\'' +component.get("v.LeadLookUpId")+ '\''; 
            
            }
            else if((fieldType=='PICKLIST' || fieldType=="STRING" )  && operator=="=" ){
                filterCondition= filterCondition+' '+'AND' +' ' +filterSelectedMapValue.apiName+'=\'' +selectedFiltervalue+ '\'';
            }
            else if((fieldType=='PICKLIST' || fieldType=="STRING" )  && operator=="startwith" ){
                filterCondition= filterCondition+' '+'AND' +' ' +filterSelectedMapValue.apiName+'LIKE\'' +selectedFiltervalue+'%'+'\' ';
            }
                else if((fieldType=='PICKLIST' || fieldType=="STRING" ) && operator=="!=" ){
                    filterCondition= filterCondition+' '+'AND' +' ' +filterSelectedMapValue.apiName+'!=\'' +selectedFiltervalue+ '\' ';
                } 
                    else if(fieldType=='BOOLEAN'){
                        if(selectedFiltervalue==undefined)
                            selectedFiltervalue =false;
                        filterCondition= filterCondition+' '+'AND' +' ' +filterSelectedMapValue.apiName+'=' +selectedFiltervalue+ '\ ';
                    }
                        else if(fieldType=="DATE" || fieldType=="DATETIME" ){
                            component.set("v.continue",false);
                            helper.dateFilter(component,filterSelectedMapValue.apiName,
                                              filterCondition,selectedFiltervalue,varfinalString,objEctName,
                                              columnName);
                        }
            
        }
        else{
            filterCondition='';
            if(fieldType=="REFERENCE"){
                if(operator=="=")
                    filterCondition= filterCondition+' ' +filterSelectedMapValue.apiName+'=\'' +component.get("v.LeadLookUpId")+ '\''; 
            if(operator=="!=")
                    filterCondition= filterCondition+' ' +filterSelectedMapValue.apiName+'!=\'' +component.get("v.LeadLookUpId")+ '\''; 
            
            }
            else if((fieldType=='PICKLIST' || fieldType=="STRING" )  && operator=="=" ){
                filterCondition= filterCondition+' ' +filterSelectedMapValue.apiName+'=\'' +selectedFiltervalue+ '\'';
            }
            else if((fieldType=='PICKLIST' || fieldType=="STRING" )  && operator=="!=" ){
                filterCondition= filterCondition+' ' +filterSelectedMapValue.apiName+'!=\'' +selectedFiltervalue+ '\' ';
            }
                else if(fieldType=='BOOLEAN'){
                    if(selectedFiltervalue==undefined)
                        selectedFiltervalue =false;
                    filterCondition= filterCondition+' ' +filterSelectedMapValue.apiName+'=' +selectedFiltervalue+ '\ ';
                    
                }
                    else if((fieldType=='PICKLIST' || fieldType=="STRING" )  && operator=="startwith" ){
                        filterCondition= filterCondition+' ' +filterSelectedMapValue.apiName+' LIKE \'' +selectedFiltervalue+'%'+ '\' ';
                    }
                        else if(fieldType=="DATE" || fieldType=="DATETIME" ){
                            // create filter from server
                            component.set("v.continue",false);
                            helper.dateFilter(component,filterSelectedMapValue.apiName,
                                              filterCondition,selectedFiltervalue,varfinalString,objEctName,
                                              columnName);
                            
                            
                        }
        }
        if(component.get("v.continue")){
            component.set("v.Filter",filterCondition);
            var query = 'select '+varfinalString+' '+ 'from'+' '+objEctName+' '+'where'+' ' +filterCondition+' order by ' +columnName+ ' '+component.get("v.sortOrder");
            helper.sortDataFromServer(component,query);
            component.set("v.showfilter",false);
            component.set("v.selectedValue","");
            const accountUtility = component.find('leadIdlookUP');        
            accountUtility.createAccount();
        }
        //console.log('1111111'+filterAPI+'222222'+selectedFiltervalue+'operator'+operator);
        //var query = 'select '+varfinalString+' '+ 'from'+' '+objEctName+' '+'where'+' ' +filterCOnd+' '+'order by Appointment_Date__c  desc limit 5000';
        
    },
    onNext : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber+1);
        helper.buildData(component, helper);
    },
    
    onPrev : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber-1);
        helper.buildData(component, helper);
    },
    
    processMe : function(component, event, helper) {
        component.set("v.currentPageNumber", parseInt(event.target.name));
        helper.buildData(component, helper);
    },
    
    onFirst : function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.buildData(component, helper);
    },
    
    onLast : function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.buildData(component, helper);
    },
    toggle : function(component, event, helper) {
        var toggleText = component.get("v.btnName");
        if(toggleText=="show filter"){
            component.set("v.isShowFilter",true);
            component.set("v.btnName","hide filter")
        }
        else{
            component.set("v.isShowFilter",false);
            component.set("v.btnName","show filter")
        }
        
    } ,
    
    //Added by Rahul B
    openCSModel :function(component, event, helper) {
        var hostName = window.location.hostname;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "https://thecenterbylendistry.force.com/apex/GenerateReportofCSessions",
                                isredirect: true
        });
        urlEvent.fire();
       // window.location.href='https://javaportal-thecenterbylendistry.cs169.force.com/apex/GenerateReportofCSessions';
       //https://thecenterbylendistry.force.com/ 
    },
    //end
    
})