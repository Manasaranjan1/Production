({
	fetchSessionStartTime : function(component) {
        var countDownDate1;
        var countDownDate;
        /*  var countDownDate = new Date(component.get("v.endTime"));*/
        console.log('Before Calling Apex from Timer Component: ');
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        var action = component.get("c.returnSessionStartTime");
        action.setParams({ 
            "LogInUserID" :  userId
        });
        action.setCallback(this, function(response) { 
            var state = response.getState();  
            console.log('State after calling APEX '+state);
            if (state === "SUCCESS") {
                countDownDate1= response.getReturnValue(); 
                countDownDate = new Date(countDownDate1).getTime();
                console.log('returnValue for Timer: '+countDownDate);
                
                var timer = setInterval(function() {
                    
                    // Get todays date and time
                    var now = new Date().getTime()- (750 * 60 * 1000);
                    console.log('Value of countDownDate: '+countDownDate);
                    
                    // Find the distance between now and the count down date
                    if(countDownDate == null || countDownDate == undefined){
                        countDownDate = new Date().getTime();
                    }
                    var distance =  now - countDownDate;
                    
                    // Time calculations for days, hours, minutes and seconds
                    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                    
                    // Display the result in the element with id="demo"
                    var timeLeft =  hours + "h " + minutes + "m " + seconds + "s ";
                    component.set("v.timeLeft", timeLeft);
                }, 1000);
                
            }
            
            
            if (state === "ERROR") {
                
                countDownDate = new Date().getTime();
                var timer = setInterval(function() {
                    
                    // Get todays date and time
                    var now = new Date().getTime(); //- (750 * 60 * 1000);
                    console.log('Value of countDownDate: '+countDownDate);
                    
                    // Find the distance between now and the count down date
                    
                    var distance =  now - countDownDate;
                    
                    // Time calculations for days, hours, minutes and seconds
                    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                    
                    // Display the result in the element with id="demo"
                    var timeLeft =  hours + "h " + minutes + "m " + seconds + "s ";
                    component.set("v.timeLeft", timeLeft);
                }, 1000);
                
            }
            
        });
        $A.enqueueAction(action);
    
	}
})