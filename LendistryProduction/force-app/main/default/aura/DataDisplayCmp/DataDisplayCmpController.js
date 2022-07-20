({
	openPage : function(component, event, helper) {
        debugger;
       /* if(component.get("v.ltngCurrTime")=="00:00:00" ){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "ALERT!",
                "message": "Please start time tracker!!",
                "tyee" : "info"
            });
            toastEvent.fire();
            component.set("v.isNewSessionRecord",true);
        }
        else{*/
            
       
        //component.set("v.showDetail",false);
        //var url  ="https://dev-counsellor.cs21.force.com/Demo1/s/detail/"+a1fq00000015WYyAAM;
        var address = '/detail/'+event.target.title;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": address,
            "isredirect" :false
        });
        urlEvent.fire();
        //}
       
        //event.preventDefault();
	},
    initData : function(component, event, helper) {
		var data = component.get("v.mydata");
        
	},
    callChildMethod : function(component, event, helper) {
        
    },
    openDownLoadForm : function(component, event, helper) {
       // component.set("v.parentId",);
    },
})