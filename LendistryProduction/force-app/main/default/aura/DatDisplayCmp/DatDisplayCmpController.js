({
    handleComponentEvent : function(component, event, helper) {
        var cmpEvent = component.getEvent("disEvent");
        cmpEvent.fire();
    },
    disableSubQuestion : function(component, event, helper) {
        var myData  = component.get("v.mydata");
        var selectedValue = event.getSource().get("v.value");
        var indexVal = event.getSource().get("v.title");
        var selectedItem = myData[indexVal];
        if(selectedValue=="Yes"){
            selectedItem.expanded = true;
        }
        else{
            selectedItem.expanded = false;
        }
        component.set("v.mydata",myData);
    },
    closeAlertModel:function(component, event, helper) {
         component.set("v.confirmModal",false);
    },
    
    removeSubQuestionAnswer :  function(component, event, helper) {
        helper.enableDisableChildQuestions(component, event, helper);
       
    },
	editQuestion : function(component, event, helper) {
       
        component.set("v.whichId","LeadQst");
        var selectedCheck = event.target.title;//event.getSource().get("v.title");
        var selectedIndex = event.target.name;
        var questionList = component.get("v.mydata");      
        component.set("v.singleQst",questionList[selectedIndex]);
        component.set("v.indexNumber",selectedIndex);
        component.set("v.showModal",true);
        
       // component.set("v.confirmModal",true);
        
	},
    editSubQuestion : function(component, event, helper) {
       
        
        component.set("v.whichId","LeadSubQst");
        var selectedCheck = event.target.title;//parent
        var selectedIndex = event.target.name; // child        
        var questionList = component.get("v.mydata"); 
        var parentQuestion = questionList[selectedCheck];// parent questiomn
        var childQst = parentQuestion.items[selectedIndex];
        component.set("v.singleQst",childQst);
        component.set("v.indexNumber",selectedIndex);
        component.set("v.showModal",true);
	},
    
    applyConfirm : function(component, event, helper) {
        alert('--------');
    }
    
})