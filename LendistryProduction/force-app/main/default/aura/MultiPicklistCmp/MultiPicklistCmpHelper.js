({
	removeValuesFromList : function(a1, a2) {
		 var result = [];
		 for (var i = 0; i < a1.length; i++) {
			 if (a2.indexOf(a1[i]) === -1) {
				 result.push(a1[i]);
			 }
		 }
		 return result;
	},
    commonColumnCreation: function(component,newSelectedValues){
        var queryField='';      
        var newColumnlist=[];
        var newDetailFields=[];
        var mapValue = component.get("v.mapOfFieldset");
        for(var i=0;i<newSelectedValues.length;i++){
            var selectedFieldMap = mapValue[newSelectedValues[i]];
            if(selectedFieldMap !=undefined){
                var newColumn={};
                newColumn.fapi = selectedFieldMap.apiName;
                newColumn.flabel = selectedFieldMap.label;
                newColumn.type = selectedFieldMap.type;
                newColumnlist.push(newColumn);
                newDetailFields.push(selectedFieldMap.apiName);
                queryField =  queryField +selectedFieldMap.apiName+',';
            }               
        }
        var pos = queryField.lastIndexOf(",");
        var str = queryField.substring(0, pos);
        component.set("v.finalString",str);
        console.log('newColumnlistnewColumnlist'+newColumnlist);
        component.set("v.conditionTypeOptions",newColumnlist);
        component.set("v.brokerFields",newDetailFields);
    }
})