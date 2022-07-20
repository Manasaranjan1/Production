({
	enableDisableChildQuestions: function(component, event, ParentQuestionAnswer) {
        var selectedCheck = event.getSource().get("v.title");
        var myData = component.get("v.mydata");
        if(ParentQuestionAnswer =='Yes'){
            
            component.set("v.confirmModal",true);
        }
        else{
            
            component.set("v.confirmModal",false);
        }
    }
})