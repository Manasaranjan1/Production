({
    initData : function(component, event, helper) { 
        
        var action = component.get('c.getDisclosureData');
        action.setParams({ 
            "leadId" : component.get("v.recordId")        
        }); 
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                debugger;
                var returnVale = response.getReturnValue();
                if(returnVale !=null && returnVale.length>0){
                    for(var i=0;i<returnVale.length;i++){
                        var optionsList=[];
                        var questionType = returnVale[i].questionType;
                        
                        if(questionType=="radio"){
                            var optionsValue = returnVale[i].options;                           
                            if(optionsValue !=null && optionsValue.length>0){
                                for(var j=0;j<optionsValue.length;j++){
                                    var str = optionsValue[j].trim(); 
                                    optionsList.push({'label':str,'value':str});
                                }
                            } 
                            returnVale[i].options = optionsList;
                        }                        
                        if( returnVale[i].items !=undefined && returnVale[i].items.length>0){
                            for(var k=0;k<returnVale[i].items.length;k++){
                                var singleItem= returnVale[i].items[k];
                                var optionsList=[];
                                var questionType =singleItem.questionType;                                
                                if(questionType=="radio"){
                                    var optionsValue = singleItem.options;                           
                                    if(optionsValue !=null && optionsValue.length>0){
                                        for(var l=0;l<optionsValue.length;l++){ 
                                            var str = optionsValue[l].trim();
                                            optionsList.push({'label':str,'value':str});                                        }
                                    }  
                                    returnVale[i].items[k].options = optionsList;
                                }                               
                            }
                        }                       
                    }
                }
                component.set("v.items",returnVale);
                component.set("v.hideSpinner",false);
            }
        });
        $A.enqueueAction(action);
    }
})