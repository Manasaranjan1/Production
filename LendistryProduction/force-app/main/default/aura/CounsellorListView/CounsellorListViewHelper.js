({ 
    waitingTimeId: null,
	setStartTimeOnUI : function(component) {
        component.set("v.ltngIsDisplayed",true);
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
    stopSessionTime : function(component) 
    {
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        var action = component.get("c.sessionStopTime");
        //alert('---userId---->>'+userId);
        action.setParams({ "LogInUserID" : userId });
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                window.location.replace("https://javaportal-thecenterbylendistry.cs169.force.com/login?ec=302&startURL=%2FSession%2Fs%2F");
            } 
            else {
            }
        });
    },
    getAccountList: function(component) {
        var action = component.get('c.getCounselingsession');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.accounts', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    setStopTimeOnUI : function(component) {
        component.set("v.ltngIsDisplayed",false);
        window.clearTimeout(this.waitingTimeId);
    },
    setResetTimeOnUI : function(component) {
        component.set("v.ltngIsDisplayed",false);
        component.set("v.ltngCurrTime","00:00:00");
        window.clearTimeout(this.waitingTimeId);
    },
    
    removeFilter :function (component, event, helper) {
        component.set("v.hideSpinner",true);
        var query = component.get("v.query");
        component.set("v.Filter","");
        this.sortDataFromServer(component,query);
    },
    addRemoveColumn : function (component, event, helper) {
        component.set("v.showAddColumn",true);
    },
    addFilter :  function (component, event, helper) {
        component.set("v.showfilter",true);
    },
    dateFilter : function(component,apiName,filterCondition,selectedFiltervalue,varfinalString,objEctName,columnName,helper){
        component.set("v.continue",true);
        var actionDateData = component.get("c.getDateFilter");
        actionDateData.setParams({ 
            "strDate" : selectedFiltervalue           
        }); 
        actionDateData.setCallback(this, function(response) { 
            var state = response.getState();            
            if (state === "SUCCESS") {
                var operator = component.get("v.operator"); 
                var returnValue= response.getReturnValue(); 
                if(filterCondition==undefined || filterCondition=='' ){
                    if(operator=="=")
                        filterCondition= filterCondition+'LastModifiedByFormula__c=' +returnValue+ '\ ';
                    else  if(operator=="!=")
                        filterCondition= filterCondition+'LastModifiedByFormula__c!=' +returnValue+ '\ ';
                        else  if(operator=="<")
                            filterCondition= filterCondition+'LastModifiedByFormula__c<' +returnValue+ '\ ';
                            else if(operator==">")
                                filterCondition= filterCondition+'LastModifiedByFormula__c>' +returnValue+ '\ ';
                                else if(operator=="<=")
                                    filterCondition= filterCondition+'LastModifiedByFormula__c<=' +returnValue+ '\ ';
                                    else if(operator==">=")
                                        filterCondition= filterCondition+'LastModifiedByFormula__c>=' +returnValue+ '\ ';
 
                }
                else{
                     if(operator=="=")
                        filterCondition= filterCondition+' '+'AND' +' ' +'LastModifiedByFormula__c=' +returnValue+ '\ ';
                    else  if(operator=="!=")
                        filterCondition= filterCondition+' '+'AND' +' ' +'LastModifiedByFormula__c!=' +returnValue+ '\ ';
                        else  if(operator=="<")
                            filterCondition= filterCondition+' '+'AND' +' ' +'LastModifiedByFormula__c<' +returnValue+ '\ ';
                            else if(operator==">")
                                filterCondition= filterCondition+' '+'AND' +' ' +'LastModifiedByFormula__c>' +returnValue+ '\ ';
                                else if(operator=="<=")
                                    filterCondition= filterCondition+' '+'AND' +' ' +'LastModifiedByFormula__c<=' +returnValue+ '\ ';
                                    else if(operator==">=")
                                        filterCondition= filterCondition+' '+'AND' +' ' +'LastModifiedByFormula__c>=' +returnValue+ '\ ';
 
                }
                
                component.set("v.Filter",filterCondition);
                var query = 'select '+varfinalString+' '+ 'from'+' '+objEctName+' '+'where'+' ' +filterCondition+' '+'order by ' +columnName+ ' '+component.get("v.sortOrder");
                this.sortDataFromServer(component,query);
                component.set("v.showfilter",false);
                component.set("v.selectedValue","");    
            }
        });
        $A.enqueueAction(actionDateData);
    },
    databinding : function(component,listOfRecord,listOfField,helper) {

        if(listOfRecord !=undefined && listOfRecord.length>0){
            console.log('fieldsddddd'+JSON.stringify(listOfField));
             var listOfInnerWrapper=[];
            for(var i=0;i<listOfRecord.length;i++){
                var data = listOfRecord[i];
                var wrapCommon=new Object();	// create empty instance of object
                wrapCommon.parentRecordId = data["Id"]; 
                wrapCommon.listColWrap=[];	
                for (var j=0;j< listOfField.length;j++ ) {	
                    var keySetstr = listOfField[j].fapi;
                    console.log('keySetstrkeySetstr'+keySetstr);                    
                    var dataRecord=data[keySetstr];
                    var columnWrap = new Object();
				    columnWrap.typeValue  =   listOfField[j].type;
                    columnWrap.apiName = listOfField[j].fapi;
                    if(keySetstr!="Id"){                       
                        columnWrap.columnValue=dataRecord;
                        
                    }
                    columnWrap.LeadId = data["Lead__c"];  
                    console.log('columnWrap.LeadIdcolumnWrap.LeadId'+columnWrap.LeadId);
                    columnWrap.recordId = data["Id"]; 
                    columnWrap.LeadName = data["LeadFormula__c"];
                    wrapCommon.listColWrap.push(columnWrap);
                }
                 listOfInnerWrapper.push(wrapCommon);// set on the list of wrapper
            }           
            component.set("v.totalPages", Math.ceil(listOfInnerWrapper.length/component.get("v.pageSize")));
            component.set("v.mydata", listOfInnerWrapper);
            component.set("v.currentPageNumber",1);
            this.buildData(component, helper);
        }
         
    },
    // removing filter conditions
    commonFilterRemoval : function(component,fieldName,filterCondition){
       
       
        if(filterCondition !=undefined && filterCondition.includes('AND')){
            var splitCOndition = filterCondition.split("AND");
            //IsClosed = false , RecordType.Name = 'Membership' , Name like '%test%' , StageName like '%Have Not Met%' 
            if(splitCOndition!=undefined && splitCOndition.length>0){  
                var finalFilterCondition ='';
                for(var i=0;i<splitCOndition.length;i++){
                    //
                    var whiteSpaceString  = splitCOndition[i].trim();
                    if(!whiteSpaceString.startsWith(fieldName)){
                        finalFilterCondition= finalFilterCondition+ splitCOndition[i]+' '+ 'AND'
                        
                    }    
                }
                var pos = finalFilterCondition.lastIndexOf("AND");
                var str = finalFilterCondition.substring(0, pos);
                component.set("v.Filter",str)  ;  
            }        
        } 
        else{
           
            if( component.get("v.whichField")==fieldName)
                component.set("v.Filter","")  ;  
        }
    },
    commonQueryMaker : function(component,columnName,sorting){
      
        var  objEctName = 'Counseling_Session__c';
        var varfinalString = component.get("v.finalString");
        //Name,Counsellor__c,is_intrested_in_financing__c,LeadFormula__c,Note__c,Subject__c
        if(!varfinalString.includes('Lead__c'))
            varfinalString = varfinalString+',Lead__c';
        console.log('varfinalString'+varfinalString);
        var filterCondition = component.get("v.Filter");
        if(filterCondition==undefined)
            filterCondition='';
        component.set("v.hideSpinner", true);
        var empty=[];
        // component.set("v.mydata",empty);
        var sortOrder = component.get("v.sortOrder");
        if(sortOrder=="asc"){
            component.set("v.sortOrder","desc");
            
        }
        else{
             component.set("v.sortOrder","asc");
             
        }
           
        //var columnName = event.getParam("columnName");//event.target.title;
        component.set("v.orderBy",columnName);
        //create query here
        if(filterCondition!=undefined && filterCondition!='')
         var query = 'select '+varfinalString+' '+ 'from'+' '+objEctName+' '+'where'+' ' +filterCondition+' order by ' +columnName+ ' '+component.get("v.sortOrder");
        else
          var query = 'select '+varfinalString+' '+ 'from'+' '+objEctName+'  order by ' +columnName+ ' '+component.get("v.sortOrder"); //  create a dynamic string gquery   ;
       
        this.sortDataFromServer(component,query);  
    },
     sortDataFromServer :function(component,query){
        var actionSortData = component.get("c.getData");
        actionSortData.setParams({ 
            "soql" : query           
        }); 
        actionSortData.setCallback(this, function(response) { 
            var state = response.getState();            
            if (state === "SUCCESS") {
                var returnValue= response.getReturnValue(); 
                var savedData = component.get("v.wholeData");
                savedData.listOfRecord= returnValue;
                component.set("v.returnVale",savedData);
                if(returnValue!=undefined && returnValue.length>0){
                    component.set("v.showError",false);
                     this.databinding(component,savedData.listOfRecord,component.get("v.conditionTypeOptions")); 
                }
                   
                else{
                    component.set("v.showError",true);
                    component.set("v.hideSpinner",false);
                    var empty=[];
                    component.set('v.PaginationList', empty);
                }
                
                
            }
        });
        $A.enqueueAction(actionSortData);
    },
    
  saveTimingTrack : function(component,event){               //@@@@@@@@@@
      debugger;
      var actionSortData = component.get("c.saveTimeTracking");
      actionSortData.setParams({ 
          "timeWithDate" :  component.get("v.ltngCurrTime")   ,
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
    
    
    buildData : function(component, helper) {
        var data = [];
        var pageNumber = component.get("v.currentPageNumber");
        var pageSize = component.get("v.pageSize");
        var allData = component.get("v.mydata");
        var x = (pageNumber-1)*pageSize;
        
        //creating data-table data
        for(; x<=(pageNumber)*pageSize; x++){
            if(allData[x]){
            	data.push(allData[x]);
            }
        }
        component.set("v.PaginationList", data);
        
        this.generatePageList(component, pageNumber);
    },
    
    /*
     * this function generate page list
     * */
    generatePageList : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        var pageList = [];
        var totalPages = component.get("v.totalPages");
        if(totalPages > 1){
            if(totalPages <= 10){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                } 
            } else{
                if(pageNumber < 5){
                    pageList.push(2, 3, 4, 5, 6);
                } else{
                    if(pageNumber>(totalPages-5)){
                        pageList.push(totalPages-5, totalPages-4, totalPages-3, totalPages-2, totalPages-1);
                    } else{
                        pageList.push(pageNumber-2, pageNumber-1, pageNumber, pageNumber+1, pageNumber+2);
                    }
                }
            }
        }
        console.log("pageListpageList"+pageList);
        component.set("v.pageList", pageList);
        component.set("v.hideSpinner",false);
        component.set("v.showData",true);
    },
    setOperator: function(component, typeValue){
        var operators=[];
        if(typeValue=="BOOLEAN"){
            operators.push({
                label: '=',
                value: '=',
            });
            
        }
        else if(typeValue=="STRING" || typeValue=="PICKLIST"){
            operators.push({
                label: '=',
                value: '=',
            });
            operators.push({
                label: '!=',
                value: '!=',
            });            
            /*operators.push({
                label: 'startwith',
                value: 'startwith',
            });*/
        }
        else if(typeValue=="DATE" || typeValue=="DATETIME"){
            operators.push({
                label: '=',
                value: '=',
            });
            operators.push({
                label: '!=',
                value: '!=',
            });
            operators.push({
                label: '<',
                value: '<',
            });
             operators.push({
                label: '<=',
                value: '<=',
            });
            operators.push({
                label: '>',
                value: '>',
            });
             operators.push({
                label: '>=',
                value: '>',
            });
        }
        component.set("v.operatorColumn",operators);
    },
    insertStartSession :  function(component)
    {
         var userId = $A.get("$SObjectType.CurrentUser.Id");
        var action = component.get("c.insertSessionStartTime");
        //alert('---userId---->>'+userId);
        action.setParams({ "LogInUserID" : userId });
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                // Do stuff
            } 
            else {
            }
        });
        $A.enqueueAction(action);
    },
    stopSession : function (component)
    {
         var userId = $A.get("$SObjectType.CurrentUser.Id");
        var action = component.get("c.sessionStopTime");
        //alert('---userId---->>'+userId);
        action.setParams({ "LogInUserID" : userId });
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                // Do stuff
            } 
            else {
            }
        });
        $A.enqueueAction(action);
    }
})