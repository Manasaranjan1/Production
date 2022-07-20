({
    
	 initData : function(component, event, helper) {
        component.set("v.whichpage","2");
        var counsellingFields = component.get("v.brokerFields");
        
        var empty=[];
        var counsellingFlds = component.get("v.brokerFields");
        for(var i=0;i<counsellingFlds.length;i++){
            if(counsellingFlds[i]!='Lead__c'){
                empty.push(counsellingFlds[i]);
                component.set("v.showViewOrEdit",true);
            }
        }
        component.set("v.brokerFields",empty);
    },
     handleOnSuccess : function(component, event, helper) {
        component.set("v.showViewOrEdit",true);
        component.set("v.btnName","EDIT");
        var param = event.getParams(); //get event params
        var fields = param.response.fields; //get all field info       
        var recordId = param.response.id; //g
        //param.response.fields.Lead__c.value
        component.set("v.recordId",recordId);
        component.set("v.Spinner",false);        
        component.set("v.isUpdate",true);
    },
})