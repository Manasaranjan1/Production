({
     logout :function(component, event, helper) {
        var url = window.location.hostname;        
         window.location.replace("https://"+url+"/s/login/");
    },  
})