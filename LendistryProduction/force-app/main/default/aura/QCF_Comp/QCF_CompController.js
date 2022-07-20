({
    doInit : function(component, event, helper) {   
        helper.loadQCFData(component, event,helper);
    },
    
    countfirstYearData: function(component, event, helper)
    {
        var fNameCmp = component.find("inputMonthFY").value;
        //alert('---fNameCmp--->'+component.get("v.input2016"));
        //VarTotal2016 = component.get("v.Total2016");
        component.set("v.Total2016", component.get("v.input2016"));
    },
    
    RunQuickCashFlow : function(component, event, helper)
    {
        var allValid = component.find('fieldId').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        console.log('allValid: '+allValid);
        if (allValid) {
            helper.RunQuickCashFlow(component,event,helper);
        } 
        else {
            var sMsg = 'Please fill all mandatory fields before running QCF \n';
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
               mode: 'dismissible',
               duration: 5000,
                message: sMsg,
                type : 'error'
            });
            toastEvent.fire();
        }
        
        
    },
    saveQCF : function(component,event,helper)
    {
        if( component.get("v.IsQCF_Run"))
            helper.saveQCF(component,event,helper);
        else
        {
            helper.showToast( component,event,helper);
        }
    },
    
    openModel: function(component, event, helper) {
        // Set isModalOpen attribute to true
        // component.set("v.isModalOpen", true);
    },
    
    closeModel: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
    },
    handleClose : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire() 
    },
    
    
    submitDetails: function(component, event, helper) {
        // Set isModalOpen attribute to false
        //Add your code to call apex method or do some processing
        component.set("v.isModalOpen", false);
    },
    
    sectionOne : function(component, event, helper) {
        helper.helperFun(component,event,'articleOne');
    },
    
    sectionTwo : function(component, event, helper) {
        helper.helperFun(component,event,'articleTwo');
    },
    
    sectionThree : function(component, event, helper) {
        helper.helperFun(component,event,'articleThree');
    },
    
    sectionFour : function(component, event, helper) {
        helper.helperFun(component,event,'articleFour');
    },
    sectionFifth : function(component, event, helper) {
        helper.helperFun(component,event,'articleFive');
    },
    calculateAdult : function(component, event, helper){
        var ownerOneAdultvalue = component.find("adultOwner1").get("v.value");
        ownerOneAdultvalue = (ownerOneAdultvalue=='Undefined' || ownerOneAdultvalue==null || ownerOneAdultvalue =='')?0:ownerOneAdultvalue;
        component.set("v.wrapperData.AdultCurrency_Owner1", (ownerOneAdultvalue*6000));
        
        var ownerTwoAdultvalue = component.find("adultOwner2").get("v.value");
        ownerTwoAdultvalue = (ownerTwoAdultvalue=='Undefined' || ownerTwoAdultvalue==null || ownerTwoAdultvalue =='')?0:ownerTwoAdultvalue;
        component.set("v.wrapperData.AdultCurrency_Owner2", (ownerTwoAdultvalue*6000));
         
        
        var ownerThreeAdultvalue = component.find("adultOwner3").get("v.value");
        ownerThreeAdultvalue = (ownerThreeAdultvalue=='Undefined' || ownerThreeAdultvalue==null || ownerThreeAdultvalue =='')?0:ownerThreeAdultvalue;
        component.set("v.wrapperData.AdultCurrency_Owner3", (ownerThreeAdultvalue*6000));
        
        var ownerFourAdultvalue = component.find("adultOwner4").get("v.value");
        ownerFourAdultvalue = (ownerFourAdultvalue=='Undefined' || ownerFourAdultvalue==null || ownerFourAdultvalue =='')?0:ownerFourAdultvalue;
        component.set("v.wrapperData.AdultCurrency_Owner4", (ownerFourAdultvalue*6000));
        
        var ownerFiveAdultvalue = component.find("adultOwner5").get("v.value");
        ownerFiveAdultvalue = (ownerFiveAdultvalue=='Undefined' || ownerFiveAdultvalue==null || ownerFiveAdultvalue =='')?0:ownerFiveAdultvalue;
        component.set("v.wrapperData.AdultCurrency_Owner5", (ownerFiveAdultvalue*6000));
        
        if( ownerOneAdultvalue == 0 )
            component.set("v.wrapperData.Adult_Owner1", 0);
        if( ownerTwoAdultvalue == 0 )
            component.set("v.wrapperData.Adult_Owner2", 0);
        if( ownerThreeAdultvalue == 0 )
            component.set("v.wrapperData.Adult_Owner3", 0);
        if( ownerFourAdultvalue == 0 )
            component.set("v.wrapperData.Adult_Owner4", 0);
       if( ownerFiveAdultvalue == 0 )
            component.set("v.wrapperData.Adult_Owner5", 0);     
            
        
    },
    
    calculateKid : function(component, event, helper){
        var ownerOneKidvalue = component.find("kidOwner1").get("v.value");
        ownerOneKidvalue = (ownerOneKidvalue=='Undefined' || ownerOneKidvalue==null || ownerOneKidvalue =='')?0:ownerOneKidvalue;
        component.set("v.wrapperData.KidCurrency_Owner1", (ownerOneKidvalue*3000));
        
        var ownerTwoKidvalue = component.find("kidOwner2").get("v.value");
        ownerTwoKidvalue = (ownerTwoKidvalue=='Undefined' || ownerTwoKidvalue==null || ownerTwoKidvalue =='')?0:ownerTwoKidvalue;
        component.set("v.wrapperData.KidCurrency_Owner2", (ownerTwoKidvalue*3000));
        
        var ownerThreeKidvalue = component.find("kidOwner3").get("v.value");
        ownerThreeKidvalue = (ownerThreeKidvalue=='Undefined' || ownerThreeKidvalue==null || ownerThreeKidvalue =='')?0:ownerThreeKidvalue;
        component.set("v.wrapperData.KidCurrency_Owner3", (ownerThreeKidvalue*3000));
        
        var ownerFourKidvalue = component.find("kidOwner4").get("v.value");
        ownerFourKidvalue = (ownerFourKidvalue=='Undefined' || ownerFourKidvalue==null || ownerFourKidvalue =='')?0:ownerFourKidvalue;
        component.set("v.wrapperData.KidCurrency_Owner4", (ownerFourKidvalue*3000));
        
        var ownerFiveKidvalue = component.find("kidOwner5").get("v.value");
        ownerFiveKidvalue = (ownerFiveKidvalue=='Undefined' || ownerFiveKidvalue==null || ownerFiveKidvalue =='')?0:ownerFiveKidvalue;
        component.set("v.wrapperData.KidCurrency_Owner5", (ownerFiveKidvalue*3000));
       
        if( ownerOneKidvalue == 0 )
            component.set("v.wrapperData.Kid_Owner1", 0);
        if( ownerTwoKidvalue == 0 )
            component.set("v.wrapperData.Kid_Owner2", 0);
        if( ownerThreeKidvalue == 0 )
            component.set("v.wrapperData.Kid_Owner3", 0);
        if( ownerFourKidvalue == 0 )
            component.set("v.wrapperData.Kid_Owner4", 0);
       if( ownerFiveKidvalue == 0 )
            component.set("v.wrapperData.Kid_Owner5", 0);
        
        
    },
    calculateOwnerDebt : function(component, event, helper){
        var ownerOneAnnualDebt1= 0;
        var ownerOneAnnualDebt2= 0;
        var ownerOneAnnualDebt3= 0;
        var ownerOneAnnualDebt4= 0;
        var ownerOneAnnualDebt5= 0;
        
        
        var rMO1 = component.get("v.wrapperData.Residence_Mortgage_Owner_1");
        rMO1 = (rMO1=='Undefined' || rMO1==null || rMO1 =='')?'0':rMO1;
        var rPO1 = component.get("v.wrapperData.Rental_Payment_Owner_1");
        rPO1 = (rPO1=='Undefined' || rPO1==null || rPO1 =='')?'0':rPO1;
        var hO1 = component.get("v.wrapperData.HELOC_Owner_1");
        hO1 = (hO1=='Undefined' || hO1==null || hO1 =='')?'0':hO1;
        var IDO1 = component.get("v.wrapperData.Installment_Debt_Owner_1");
        IDO1 = (IDO1=='Undefined' || IDO1==null || IDO1 =='')?'0':IDO1;
        var CDO1 = component.get("v.wrapperData.Credit_Card_Debt_Owner_1");
        CDO1 = (CDO1=='Undefined' || CDO1==null || CDO1 =='')?'0':CDO1;
        var ODO1 = component.get("v.wrapperData.Other_debt_Owner_1");
        ODO1 = (ODO1=='Undefined' || ODO1==null || ODO1 =='')?'0':ODO1;
        
        var rMO2 = component.get("v.wrapperData.Residence_Mortgage_Owner_2");
        rMO2 = (rMO2=='Undefined' || rMO2==null || rMO2 =='')?'0':rMO2;
        var rPO2 = component.get("v.wrapperData.Rental_Payment_Owner_2");
        rPO2 = (rPO2=='Undefined' || rPO2==null || rPO2 =='')?'0':rPO2;
        var hO2 = component.get("v.wrapperData.HELOC_Owner_2");
        hO2 = (hO2=='Undefined' || hO2==null || hO2 =='')?'0':hO2;
        var IDO2 = component.get("v.wrapperData.Installment_Debt_Owner_2");
        IDO2 = (IDO2=='Undefined' || IDO2==null || IDO2 =='')?'0':IDO2;
        var CDO2 = component.get("v.wrapperData.Credit_Card_Debt_Owner_2");
        CDO2 = (CDO2=='Undefined' || CDO2==null || CDO2 =='')?'0':CDO2;
        var ODO2 = component.get("v.wrapperData.Other_debt_Owner_2");
        ODO2 = (ODO2=='Undefined' || ODO2==null || ODO2 =='')?'0':ODO2;
        
        var rMO3 = component.get("v.wrapperData.Residence_Mortgage_Owner_3");
        rMO3 = (rMO3=='Undefined' || rMO3==null || rMO3 =='')?'0':rMO3;
        var rPO3 = component.get("v.wrapperData.Rental_Payment_Owner_3");
        rPO3 = (rPO3=='Undefined' || rPO3==null || rPO3 =='')?'0':rPO3;
        var hO3 = component.get("v.wrapperData.HELOC_Owner_3");
        hO3 = (hO3=='Undefined' || hO3==null || hO3 =='')?'0':hO3;
        var IDO3 = component.get("v.wrapperData.Installment_Debt_Owner_3");
        IDO3 = (IDO3=='Undefined' || IDO3==null || IDO3 =='')?'0':IDO3;
        var CDO3 = component.get("v.wrapperData.Credit_Card_Debt_Owner_3");
        CDO3 = (CDO3=='Undefined' || CDO3==null || CDO3 =='')?'0':CDO3;
        var ODO3 = component.get("v.wrapperData.Other_debt_Owner_3");
        ODO3 = (ODO3=='Undefined' || ODO3==null || ODO3 =='')?'0':ODO3;
        
        var rMO4 = component.get("v.wrapperData.Residence_Mortgage_Owner_4");
        rMO4 = (rMO4=='Undefined' || rMO4==null || rMO4 =='')?'0':rMO4;
        var rPO4 = component.get("v.wrapperData.Rental_Payment_Owner_4");
        rPO4 = (rPO4=='Undefined' || rPO4==null || rPO4 =='')?'0':rPO4;
        var hO4 = component.get("v.wrapperData.HELOC_Owner_4");
        hO4 = (hO4=='Undefined' || hO4==null || hO4 =='')?'0':hO4;
        var IDO4 = component.get("v.wrapperData.Installment_Debt_Owner_4");
        IDO4 = (IDO4=='Undefined' || IDO4==null || IDO4 =='')?'0':IDO4;
        var CDO4 = component.get("v.wrapperData.Credit_Card_Debt_Owner_4");
        CDO4 = (CDO4=='Undefined' || CDO4==null || CDO4 =='')?'0':CDO4;
        var ODO4 = component.get("v.wrapperData.Other_debt_Owner_4");
        ODO4 = (ODO4=='Undefined' || ODO4==null || ODO4 =='')?'0':ODO4;
        
        var rMO5 = component.get("v.wrapperData.Residence_Mortgage_Owner_5");
        rMO5 = (rMO5=='Undefined' || rMO5==null || rMO5 =='')?'0':rMO5;
        var rPO5 = component.get("v.wrapperData.Rental_Payment_Owner_5");
        rPO5 = (rPO5=='Undefined' || rPO5==null || rPO5 =='')?'0':rPO5;
        var hO5 = component.get("v.wrapperData.HELOC_Owner_5");
        hO5 = (hO5=='Undefined' || hO5==null || hO5 =='')?'0':hO5;
        var IDO5 = component.get("v.wrapperData.Installment_Debt_Owner_5");
        IDO5 = (IDO5=='Undefined' || IDO5==null || IDO5 =='')?'0':IDO5;
        var CDO5 = component.get("v.wrapperData.Credit_Card_Debt_Owner_5");
        CDO5 = (CDO5=='Undefined' || CDO5==null || CDO5 =='')?'0':CDO5;
        var ODO5 = component.get("v.wrapperData.Other_debt_Owner_5");
        ODO5 = (ODO5=='Undefined' || ODO5==null || ODO5 =='')?'0':ODO5;
        
        ownerOneAnnualDebt1 = parseFloat(rMO1) + parseFloat(rPO1) + parseFloat(hO1) + + parseFloat(IDO1) + parseFloat(CDO1) + parseFloat(ODO1);
        ownerOneAnnualDebt2 = parseFloat(rMO2) + parseFloat(rPO2) + parseFloat(hO2) + + parseFloat(IDO2) + parseFloat(CDO2) + parseFloat(ODO2);
        ownerOneAnnualDebt3 = parseFloat(rMO3) + parseFloat(rPO3) + parseFloat(hO3) + + parseFloat(IDO3) + parseFloat(CDO3) + parseFloat(ODO3);
        ownerOneAnnualDebt4 = parseFloat(rMO4) + parseFloat(rPO4) + parseFloat(hO4) + + parseFloat(IDO4) + parseFloat(CDO4) + parseFloat(ODO4);
        ownerOneAnnualDebt5 = parseFloat(rMO5) + parseFloat(rPO5) + parseFloat(hO5) + + parseFloat(IDO5) + parseFloat(CDO5) + parseFloat(ODO5);
        
        component.set("v.wrapperData.Total_Annual_Debt_Service_Owner_1", (ownerOneAnnualDebt1*12));
        
        component.set("v.wrapperData.Total_Annual_Debt_Service_Owner_2", (ownerOneAnnualDebt2*12));
        
        component.set("v.wrapperData.Total_Annual_Debt_Service_Owner_3", (ownerOneAnnualDebt3*12));
        
        component.set("v.wrapperData.Total_Annual_Debt_Service_Owner_4", (ownerOneAnnualDebt4*12));
        component.set("v.wrapperData.Total_Annual_Debt_Service_Owner_5", (ownerOneAnnualDebt5*12));
    },
    
    calculatePersonalOwnerOne : function(component, event, helper){
       
        
        var SWBO1CY = 0; 
        var SWBS1CY = 0;  
        var SDCG1CY = 0; 
        var S_C_I1CY = 0;  
        var SER1CY = 0;  
        var SCI1CY = 0; 
        var OGW1CY = 0; 
        var OI1CY = 0; 
        var KD1CY = 0; 
        var IDI1CY = 0; 
        var PID1CY = 0;
        var TotalOwner1CY = 0;
        
        SWBO1CY = component.get("v.wrapperData.Salary_Wages_Borrower_O1_CY");
        SWBO1CY = (SWBO1CY=='Undefined' || SWBO1CY==null || SWBO1CY =='')?'0':SWBO1CY;
       
        SWBS1CY = component.get("v.wrapperData.Salary_Wages_Spouse_O1_CY");  
        SWBS1CY = (SWBS1CY=='Undefined' || SWBS1CY==null || SWBS1CY =='')?'0':SWBS1CY;
       
        OGW1CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY"); 
        OGW1CY = (OGW1CY=='Undefined' || OGW1CY==null || OGW1CY =='')?'0':OGW1CY;
        IDI1CY = component.get("v.wrapperData.Interestdividend_Income_O1_CY");
        IDI1CY = (IDI1CY=='Undefined' || IDI1CY==null || IDI1CY =='')?'0':IDI1CY;
        OI1CY = component.get("v.wrapperData.Other_Income_O1_CY");
        OI1CY = (OI1CY=='Undefined' || OI1CY==null || OI1CY =='')?'0':OI1CY;
        PID1CY = component.get("v.wrapperData.PensionIRA_Distributions_O1_CY");
        PID1CY = (PID1CY=='Undefined' || PID1CY==null || PID1CY =='')?'0':PID1CY;
        SDCG1CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY");
        SDCG1CY = (SDCG1CY=='Undefined' || SDCG1CY==null || SDCG1CY =='')?'0':SDCG1CY;
        S_C_I1CY = component.get("v.wrapperData.Schedule_C_Income_O1_CY");
        S_C_I1CY = (S_C_I1CY=='Undefined' || S_C_I1CY==null || S_C_I1CY =='')?'0':S_C_I1CY;
        SER1CY = component.get("v.wrapperData.Schedule_E_Rental_O1_CY");
        SER1CY = (SER1CY=='Undefined' || SER1CY==null || SER1CY =='')?'0':SER1CY;
        KD1CY =  component.get("v.wrapperData.K1_Distributions_O1_CY");
        KD1CY = (KD1CY=='Undefined' || KD1CY==null || KD1CY =='')?'0':KD1CY;
        
        TotalOwner1CY = parseFloat(SWBO1CY) + parseFloat(SWBS1CY) + parseFloat(OGW1CY) +  parseFloat(IDI1CY) + parseFloat(OI1CY) + parseFloat(PID1CY) + parseFloat(SDCG1CY) +  parseFloat(S_C_I1CY) + parseFloat(SER1CY) + parseFloat(KD1CY); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O1_CY", TotalOwner1CY);
        
        //=====================Owner #1 CY-1 =========================================
        var SWBO1CY1 = 0; 
        var SWBS1CY1 = 0;  
        var SDCG1CY1 = 0; 
        var S_C_I1CY1 = 0;  
        var SER1CY1 = 0;  
        var SCI1CY1 = 0; 
        var OGW1CY1 = 0; 
        var OI1CY1 = 0; 
        var KD1CY1 = 0; 
        var IDI1CY1 = 0; 
        var PID1CY1 = 0;
        var TotalOwner1CY1 = 0;
        
        SWBO1CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O1_CY1");
        SWBO1CY1 = (SWBO1CY1=='Undefined' || SWBO1CY1==null || SWBO1CY1 =='')?'0':SWBO1CY1;
       
        SWBS1CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O1_CY1");  
        SWBS1CY1 = (SWBS1CY1=='Undefined' || SWBS1CY1==null || SWBS1CY1 =='')?'0':SWBS1CY1;
       
        OGW1CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY1"); 
        OGW1CY1 = (OGW1CY1=='Undefined' || OGW1CY1==null || OGW1CY1 =='')?'0':OGW1CY1;
        IDI1CY1 = component.get("v.wrapperData.Interestdividend_Income_O1_CY1");
        IDI1CY1 = (IDI1CY1=='Undefined' || IDI1CY1==null || IDI1CY1 =='')?'0':IDI1CY1;
        OI1CY1 = component.get("v.wrapperData.Other_Income_O1_CY1");
        OI1CY1 = (OI1CY1=='Undefined' || OI1CY1==null || OI1CY1 =='')?'0':OI1CY1;
        PID1CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O1_CY1");
        PID1CY1 = (PID1CY1=='Undefined' || PID1CY1==null || PID1CY1 =='')?'0':PID1CY1;
        SDCG1CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY1");
        SDCG1CY1 = (SDCG1CY1=='Undefined' || SDCG1CY1==null || SDCG1CY1 =='')?'0':SDCG1CY1;
        S_C_I1CY1 = component.get("v.wrapperData.Schedule_C_Income_O1_CY1");
        S_C_I1CY1 = (S_C_I1CY1=='Undefined' || S_C_I1CY1==null || S_C_I1CY1 =='')?'0':S_C_I1CY1;
        SER1CY1 = component.get("v.wrapperData.Schedule_E_Rental_O1_CY1");
        SER1CY1 = (SER1CY1=='Undefined' || SER1CY1==null || SER1CY1 =='')?'0':SER1CY1;
        KD1CY1 =  component.get("v.wrapperData.K1_Distributions_O1_CY1");
        KD1CY1 = (KD1CY1=='Undefined' || KD1CY1==null || KD1CY1 =='')?'0':KD1CY1;
        
        TotalOwner1CY1 = parseFloat(SWBO1CY1) + parseFloat(SWBS1CY1) + parseFloat(OGW1CY1) +  parseFloat(IDI1CY1) + parseFloat(OI1CY1) + parseFloat(PID1CY1) + parseFloat(SDCG1CY1) +  parseFloat(S_C_I1CY1) + parseFloat(SER1CY1) + parseFloat(KD1CY1); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O1_CY1", TotalOwner1CY1);
        
        //==============================Owner #1 CY- 2 ===================================
        var SWBO1CY2 = 0; 
        var SWBS1CY2 = 0;  
        var SDCG1CY2 = 0; 
        var S_C_I1CY2 = 0;  
        var SER1CY2 = 0;  
        var SCI1CY2 = 0; 
        var OGW1CY2 = 0; 
        var OI1CY2 = 0; 
        var KD1CY2 = 0; 
        var IDI1CY2 = 0; 
        var PID1CY2 = 0;
        var TotalOwner1CY2 = 0;
        
        SWBO1CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O1_CY2");
        SWBO1CY2 = (SWBO1CY2=='Undefined' || SWBO1CY2==null || SWBO1CY2 =='')?'0':SWBO1CY2;
       
        SWBS1CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O1_CY2");  
        SWBS1CY2 = (SWBS1CY2=='Undefined' || SWBS1CY2==null || SWBS1CY2 =='')?'0':SWBS1CY2;
       
        OGW1CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY2"); 
        OGW1CY2 = (OGW1CY2=='Undefined' || OGW1CY2==null || OGW1CY2 =='')?'0':OGW1CY2;
        IDI1CY2 = component.get("v.wrapperData.Interestdividend_Income_O1_CY2");
        IDI1CY2 = (IDI1CY2=='Undefined' || IDI1CY2==null || IDI1CY2 =='')?'0':IDI1CY2;
        OI1CY2 = component.get("v.wrapperData.Other_Income_O1_CY2");
        OI1CY2 = (OI1CY2=='Undefined' || OI1CY2==null || OI1CY2 =='')?'0':OI1CY2;
        PID1CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O1_CY2");
        PID1CY2 = (PID1CY2=='Undefined' || PID1CY2==null || PID1CY2 =='')?'0':PID1CY2;
        SDCG1CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY2");
        SDCG1CY2 = (SDCG1CY2=='Undefined' || SDCG1CY2==null || SDCG1CY2 =='')?'0':SDCG1CY2;
        S_C_I1CY2 = component.get("v.wrapperData.Schedule_C_Income_O1_CY2");
        S_C_I1CY2 = (S_C_I1CY2=='Undefined' || S_C_I1CY2==null || S_C_I1CY2 =='')?'0':S_C_I1CY2;
        SER1CY2 = component.get("v.wrapperData.Schedule_E_Rental_O1_CY2");
        SER1CY2 = (SER1CY2=='Undefined' || SER1CY2==null || SER1CY2 =='')?'0':SER1CY2;
        KD1CY2 =  component.get("v.wrapperData.K1_Distributions_O1_CY2");
        KD1CY2 = (KD1CY2=='Undefined' || KD1CY2==null || KD1CY2 =='')?'0':KD1CY2;
        
        TotalOwner1CY2 = parseFloat(SWBO1CY2) + parseFloat(SWBS1CY2) + parseFloat(OGW1CY2) +  parseFloat(IDI1CY2) + parseFloat(OI1CY2) + parseFloat(PID1CY2) + parseFloat(SDCG1CY2) +  parseFloat(S_C_I1CY2) + parseFloat(SER1CY2) + parseFloat(KD1CY2); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O1_CY2", TotalOwner1CY2);
        
        //============================Owner #1  CY-3- ==============================================
        var SWBO1CY3 = 0; 
        var SWBS1CY3 = 0;  
        var SDCG1CY3 = 0; 
        var S_C_I1CY3 = 0;  
        var SER1CY3 = 0;  
        var SCI1CY3 = 0; 
        var OGW1CY3 = 0; 
        var OI1CY3 = 0; 
        var KD1CY3 = 0; 
        var IDI1CY3 = 0; 
        var PID1CY3 = 0;
        var TotalOwner1CY3 = 0;
        
        SWBO1CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O1_CY3");
        SWBO1CY3 = (SWBO1CY3=='Undefined' || SWBO1CY3==null || SWBO1CY3 =='')?'0':SWBO1CY3;
       
        SWBS1CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O1_CY3");  
        SWBS1CY3 = (SWBS1CY3=='Undefined' || SWBS1CY3==null || SWBS1CY3 =='')?'0':SWBS1CY3;
       
        OGW1CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY3"); 
        OGW1CY3 = (OGW1CY3=='Undefined' || OGW1CY3==null || OGW1CY3 =='')?'0':OGW1CY3;
        IDI1CY3 = component.get("v.wrapperData.Interestdividend_Income_O1_CY3");
        IDI1CY3 = (IDI1CY3=='Undefined' || IDI1CY3==null || IDI1CY3 =='')?'0':IDI1CY3;
        OI1CY3 = component.get("v.wrapperData.Other_Income_O1_CY3");
        OI1CY3 = (OI1CY3=='Undefined' || OI1CY3==null || OI1CY3 =='')?'0':OI1CY3;
        PID1CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O1_CY3");
        PID1CY3 = (PID1CY3=='Undefined' || PID1CY3==null || PID1CY3 =='')?'0':PID1CY3;
        SDCG1CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY3");
        SDCG1CY3 = (SDCG1CY3=='Undefined' || SDCG1CY3==null || SDCG1CY3 =='')?'0':SDCG1CY3;
        S_C_I1CY3 = component.get("v.wrapperData.Schedule_C_Income_O1_CY3");
        S_C_I1CY3 = (S_C_I1CY3=='Undefined' || S_C_I1CY3==null || S_C_I1CY3 =='')?'0':S_C_I1CY3;
        SER1CY3 = component.get("v.wrapperData.Schedule_E_Rental_O1_CY3");
        SER1CY3 = (SER1CY3=='Undefined' || SER1CY3==null || SER1CY3 =='')?'0':SER1CY3;
        KD1CY3 =  component.get("v.wrapperData.K1_Distributions_O1_CY3");
        KD1CY3 = (KD1CY3=='Undefined' || KD1CY3==null || KD1CY3 =='')?'0':KD1CY3;
        
        TotalOwner1CY3 = parseFloat(SWBO1CY3) + parseFloat(SWBS1CY3) + parseFloat(OGW1CY3) +  parseFloat(IDI1CY3) + parseFloat(OI1CY3) + parseFloat(PID1CY3) + parseFloat(SDCG1CY3) +  parseFloat(S_C_I1CY3) + parseFloat(SER1CY3) + parseFloat(KD1CY3); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O1_CY3", TotalOwner1CY3);
       
    },
    calculatePersonalOwnerTwo : function(component, event, helper){
       
        
        var SWBO1CY = 0; 
        var SWBS1CY = 0;  
        var SDCG1CY = 0; 
        var S_C_I1CY = 0;  
        var SER1CY = 0;  
        var SCI1CY = 0; 
        var OGW1CY = 0; 
        var OI1CY = 0; 
        var KD1CY = 0; 
        var IDI1CY = 0; 
        var PID1CY = 0;
        var TotalOwner2CY = 0;
        
        SWBO1CY = component.get("v.wrapperData.Salary_Wages_Borrower_O2_CY");
        SWBO1CY = (SWBO1CY=='Undefined' || SWBO1CY==null || SWBO1CY =='')?'0':SWBO1CY;
       
        SWBS1CY = component.get("v.wrapperData.Salary_Wages_Spouse_O2_CY");  
        SWBS1CY = (SWBS1CY=='Undefined' || SWBS1CY==null || SWBS1CY =='')?'0':SWBS1CY;
       
        OGW1CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY"); 
        OGW1CY = (OGW1CY=='Undefined' || OGW1CY==null || OGW1CY =='')?'0':OGW1CY;
        IDI1CY = component.get("v.wrapperData.Interestdividend_Income_O2_CY");
        IDI1CY = (IDI1CY=='Undefined' || IDI1CY==null || IDI1CY =='')?'0':IDI1CY;
        OI1CY = component.get("v.wrapperData.Other_Income_O2_CY");
        OI1CY = (OI1CY=='Undefined' || OI1CY==null || OI1CY =='')?'0':OI1CY;
        PID1CY = component.get("v.wrapperData.PensionIRA_Distributions_O2_CY");
        PID1CY = (PID1CY=='Undefined' || PID1CY==null || PID1CY =='')?'0':PID1CY;
        SDCG1CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY");
        SDCG1CY = (SDCG1CY=='Undefined' || SDCG1CY==null || SDCG1CY =='')?'0':SDCG1CY;
        S_C_I1CY = component.get("v.wrapperData.Schedule_C_Income_O2_CY");
        S_C_I1CY = (S_C_I1CY=='Undefined' || S_C_I1CY==null || S_C_I1CY =='')?'0':S_C_I1CY;
        SER1CY = component.get("v.wrapperData.Schedule_E_Rental_O2_CY");
        SER1CY = (SER1CY=='Undefined' || SER1CY==null || SER1CY =='')?'0':SER1CY;
        KD1CY =  component.get("v.wrapperData.K1_Distributions_O2_CY");
        KD1CY = (KD1CY=='Undefined' || KD1CY==null || KD1CY =='')?'0':KD1CY;
        
        TotalOwner2CY = parseFloat(SWBO1CY) + parseFloat(SWBS1CY) + parseFloat(OGW1CY) +  parseFloat(IDI1CY) + parseFloat(OI1CY) + parseFloat(PID1CY) + parseFloat(SDCG1CY) +  parseFloat(S_C_I1CY) + parseFloat(SER1CY) + parseFloat(KD1CY); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O2_CY", TotalOwner2CY);
        
        //=====================Owner #1 CY-1 =========================================
        var SWBO1CY1 = 0; 
        var SWBS1CY1 = 0;  
        var SDCG1CY1 = 0; 
        var S_C_I1CY1 = 0;  
        var SER1CY1 = 0;  
        var SCI1CY1 = 0; 
        var OGW1CY1 = 0; 
        var OI1CY1 = 0; 
        var KD1CY1 = 0; 
        var IDI1CY1 = 0; 
        var PID1CY1 = 0;
        var TotalOwner2CY1 = 0;
        
        SWBO1CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O2_CY1");
        SWBO1CY1 = (SWBO1CY1=='Undefined' || SWBO1CY1==null || SWBO1CY1 =='')?'0':SWBO1CY1;
       
        SWBS1CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O2_CY1");  
        SWBS1CY1 = (SWBS1CY1=='Undefined' || SWBS1CY1==null || SWBS1CY1 =='')?'0':SWBS1CY1;
       
        OGW1CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY1"); 
        OGW1CY1 = (OGW1CY1=='Undefined' || OGW1CY1==null || OGW1CY1 =='')?'0':OGW1CY1;
        IDI1CY1 = component.get("v.wrapperData.Interestdividend_Income_O2_CY1");
        IDI1CY1 = (IDI1CY1=='Undefined' || IDI1CY1==null || IDI1CY1 =='')?'0':IDI1CY1;
        OI1CY1 = component.get("v.wrapperData.Other_Income_O2_CY1");
        OI1CY1 = (OI1CY1=='Undefined' || OI1CY1==null || OI1CY1 =='')?'0':OI1CY1;
        PID1CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O2_CY1");
        PID1CY1 = (PID1CY1=='Undefined' || PID1CY1==null || PID1CY1 =='')?'0':PID1CY1;
        SDCG1CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY1");
        SDCG1CY1 = (SDCG1CY1=='Undefined' || SDCG1CY1==null || SDCG1CY1 =='')?'0':SDCG1CY1;
        S_C_I1CY1 = component.get("v.wrapperData.Schedule_C_Income_O2_CY1");
        S_C_I1CY1 = (S_C_I1CY1=='Undefined' || S_C_I1CY1==null || S_C_I1CY1 =='')?'0':S_C_I1CY1;
        SER1CY1 = component.get("v.wrapperData.Schedule_E_Rental_O2_CY1");
        SER1CY1 = (SER1CY1=='Undefined' || SER1CY1==null || SER1CY1 =='')?'0':SER1CY1;
        KD1CY1 =  component.get("v.wrapperData.K1_Distributions_O2_CY1");
        KD1CY1 = (KD1CY1=='Undefined' || KD1CY1==null || KD1CY1 =='')?'0':KD1CY1;
        
        TotalOwner2CY1 = parseFloat(SWBO1CY1) + parseFloat(SWBS1CY1) + parseFloat(OGW1CY1) +  parseFloat(IDI1CY1) + parseFloat(OI1CY1) + parseFloat(PID1CY1) + parseFloat(SDCG1CY1) +  parseFloat(S_C_I1CY1) + parseFloat(SER1CY1) + parseFloat(KD1CY1); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O2_CY1", TotalOwner2CY1);
        
        //==============================Owner #1 CY- 2 ===================================
        var SWBO1CY2 = 0; 
        var SWBS1CY2 = 0;  
        var SDCG1CY2 = 0; 
        var S_C_I1CY2 = 0;  
        var SER1CY2 = 0;  
        var SCI1CY2 = 0; 
        var OGW1CY2 = 0; 
        var OI1CY2 = 0; 
        var KD1CY2 = 0; 
        var IDI1CY2 = 0; 
        var PID1CY2 = 0;
        var TotalOwner2CY2 = 0;
        
        SWBO1CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O2_CY2");
        SWBO1CY2 = (SWBO1CY2=='Undefined' || SWBO1CY2==null || SWBO1CY2 =='')?'0':SWBO1CY2;
       
        SWBS1CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O2_CY2");  
        SWBS1CY2 = (SWBS1CY2=='Undefined' || SWBS1CY2==null || SWBS1CY2 =='')?'0':SWBS1CY2;
       
        OGW1CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY2"); 
        OGW1CY2 = (OGW1CY2=='Undefined' || OGW1CY2==null || OGW1CY2 =='')?'0':OGW1CY2;
        IDI1CY2 = component.get("v.wrapperData.Interestdividend_Income_O2_CY2");
        IDI1CY2 = (IDI1CY2=='Undefined' || IDI1CY2==null || IDI1CY2 =='')?'0':IDI1CY2;
        OI1CY2 = component.get("v.wrapperData.Other_Income_O2_CY2");
        OI1CY2 = (OI1CY2=='Undefined' || OI1CY2==null || OI1CY2 =='')?'0':OI1CY2;
        PID1CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O2_CY2");
        PID1CY2 = (PID1CY2=='Undefined' || PID1CY2==null || PID1CY2 =='')?'0':PID1CY2;
        SDCG1CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY2");
        SDCG1CY2 = (SDCG1CY2=='Undefined' || SDCG1CY2==null || SDCG1CY2 =='')?'0':SDCG1CY2;
        S_C_I1CY2 = component.get("v.wrapperData.Schedule_C_Income_O2_CY2");
        S_C_I1CY2 = (S_C_I1CY2=='Undefined' || S_C_I1CY2==null || S_C_I1CY2 =='')?'0':S_C_I1CY2;
        SER1CY2 = component.get("v.wrapperData.Schedule_E_Rental_O2_CY2");
        SER1CY2 = (SER1CY2=='Undefined' || SER1CY2==null || SER1CY2 =='')?'0':SER1CY2;
        KD1CY2 =  component.get("v.wrapperData.K1_Distributions_O2_CY2");
        KD1CY2 = (KD1CY2=='Undefined' || KD1CY2==null || KD1CY2 =='')?'0':KD1CY2;
        
        TotalOwner2CY2 = parseFloat(SWBO1CY2) + parseFloat(SWBS1CY2) + parseFloat(OGW1CY2) +  parseFloat(IDI1CY2) + parseFloat(OI1CY2) + parseFloat(PID1CY2) + parseFloat(SDCG1CY2) +  parseFloat(S_C_I1CY2) + parseFloat(SER1CY2) + parseFloat(KD1CY2); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O2_CY2", TotalOwner2CY2);
        
        //============================Owner #1  CY-3- ==============================================
        var SWBO1CY3 = 0; 
        var SWBS1CY3 = 0;  
        var SDCG1CY3 = 0; 
        var S_C_I1CY3 = 0;  
        var SER1CY3 = 0;  
        var SCI1CY3 = 0; 
        var OGW1CY3 = 0; 
        var OI1CY3 = 0; 
        var KD1CY3 = 0; 
        var IDI1CY3 = 0; 
        var PID1CY3 = 0;
        var TotalOwner2CY3 = 0;
        
        SWBO1CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O2_CY3");
        SWBO1CY3 = (SWBO1CY3=='Undefined' || SWBO1CY3==null || SWBO1CY3 =='')?'0':SWBO1CY3;
       
        SWBS1CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O2_CY3");  
        SWBS1CY3 = (SWBS1CY3=='Undefined' || SWBS1CY3==null || SWBS1CY3 =='')?'0':SWBS1CY3;
       
        OGW1CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY3"); 
        OGW1CY3 = (OGW1CY3=='Undefined' || OGW1CY3==null || OGW1CY3 =='')?'0':OGW1CY3;
        IDI1CY3 = component.get("v.wrapperData.Interestdividend_Income_O2_CY3");
        IDI1CY3 = (IDI1CY3=='Undefined' || IDI1CY3==null || IDI1CY3 =='')?'0':IDI1CY3;
        OI1CY3 = component.get("v.wrapperData.Other_Income_O2_CY3");
        OI1CY3 = (OI1CY3=='Undefined' || OI1CY3==null || OI1CY3 =='')?'0':OI1CY3;
        PID1CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O2_CY3");
        PID1CY3 = (PID1CY3=='Undefined' || PID1CY3==null || PID1CY3 =='')?'0':PID1CY3;
        SDCG1CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY3");
        SDCG1CY3 = (SDCG1CY3=='Undefined' || SDCG1CY3==null || SDCG1CY3 =='')?'0':SDCG1CY3;
        S_C_I1CY3 = component.get("v.wrapperData.Schedule_C_Income_O2_CY3");
        S_C_I1CY3 = (S_C_I1CY3=='Undefined' || S_C_I1CY3==null || S_C_I1CY3 =='')?'0':S_C_I1CY3;
        SER1CY3 = component.get("v.wrapperData.Schedule_E_Rental_O2_CY3");
        SER1CY3 = (SER1CY3=='Undefined' || SER1CY3==null || SER1CY3 =='')?'0':SER1CY3;
        KD1CY3 =  component.get("v.wrapperData.K1_Distributions_O2_CY3");
        KD1CY3 = (KD1CY3=='Undefined' || KD1CY3==null || KD1CY3 =='')?'0':KD1CY3;
        
        TotalOwner2CY3 = parseFloat(SWBO1CY3) + parseFloat(SWBS1CY3) + parseFloat(OGW1CY3) +  parseFloat(IDI1CY3) + parseFloat(OI1CY3) + parseFloat(PID1CY3) + parseFloat(SDCG1CY3) +  parseFloat(S_C_I1CY3) + parseFloat(SER1CY3) + parseFloat(KD1CY3); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O2_CY3", TotalOwner2CY3);
       
    },
    calculatePersonalOwnerThree : function(component, event, helper){
       
        
        var SWBO1CY = 0; 
        var SWBS1CY = 0;  
        var SDCG1CY = 0; 
        var S_C_I1CY = 0;  
        var SER1CY = 0;  
        var SCI1CY = 0; 
        var OGW1CY = 0; 
        var OI1CY = 0; 
        var KD1CY = 0; 
        var IDI1CY = 0; 
        var PID1CY = 0;
        var TotalOwner3CY = 0;
        
        SWBO1CY = component.get("v.wrapperData.Salary_Wages_Borrower_O3_CY");
        SWBO1CY = (SWBO1CY=='Undefined' || SWBO1CY==null || SWBO1CY =='')?'0':SWBO1CY;
       
        SWBS1CY = component.get("v.wrapperData.Salary_Wages_Spouse_O3_CY");  
        SWBS1CY = (SWBS1CY=='Undefined' || SWBS1CY==null || SWBS1CY =='')?'0':SWBS1CY;
       
        OGW1CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY"); 
        OGW1CY = (OGW1CY=='Undefined' || OGW1CY==null || OGW1CY =='')?'0':OGW1CY;
        IDI1CY = component.get("v.wrapperData.Interestdividend_Income_O3_CY");
        IDI1CY = (IDI1CY=='Undefined' || IDI1CY==null || IDI1CY =='')?'0':IDI1CY;
        OI1CY = component.get("v.wrapperData.Other_Income_O3_CY");
        OI1CY = (OI1CY=='Undefined' || OI1CY==null || OI1CY =='')?'0':OI1CY;
        PID1CY = component.get("v.wrapperData.PensionIRA_Distributions_O3_CY");
        PID1CY = (PID1CY=='Undefined' || PID1CY==null || PID1CY =='')?'0':PID1CY;
        SDCG1CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY");
        SDCG1CY = (SDCG1CY=='Undefined' || SDCG1CY==null || SDCG1CY =='')?'0':SDCG1CY;
        S_C_I1CY = component.get("v.wrapperData.Schedule_C_Income_O3_CY");
        S_C_I1CY = (S_C_I1CY=='Undefined' || S_C_I1CY==null || S_C_I1CY =='')?'0':S_C_I1CY;
        SER1CY = component.get("v.wrapperData.Schedule_E_Rental_O3_CY");
        SER1CY = (SER1CY=='Undefined' || SER1CY==null || SER1CY =='')?'0':SER1CY;
        KD1CY =  component.get("v.wrapperData.K1_Distributions_O3_CY");
        KD1CY = (KD1CY=='Undefined' || KD1CY==null || KD1CY =='')?'0':KD1CY;
        
        TotalOwner3CY = parseFloat(SWBO1CY) + parseFloat(SWBS1CY) + parseFloat(OGW1CY) +  parseFloat(IDI1CY) + parseFloat(OI1CY) + parseFloat(PID1CY) + parseFloat(SDCG1CY) +  parseFloat(S_C_I1CY) + parseFloat(SER1CY) + parseFloat(KD1CY); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O3_CY", TotalOwner3CY);
        
        //=====================Owner #1 CY-1 =========================================
        var SWBO1CY1 = 0; 
        var SWBS1CY1 = 0;  
        var SDCG1CY1 = 0; 
        var S_C_I1CY1 = 0;  
        var SER1CY1 = 0;  
        var SCI1CY1 = 0; 
        var OGW1CY1 = 0; 
        var OI1CY1 = 0; 
        var KD1CY1 = 0; 
        var IDI1CY1 = 0; 
        var PID1CY1 = 0;
        var TotalOwner3CY1 = 0;
        
        SWBO1CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O3_CY1");
        SWBO1CY1 = (SWBO1CY1=='Undefined' || SWBO1CY1==null || SWBO1CY1 =='')?'0':SWBO1CY1;
       
        SWBS1CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O3_CY1");  
        SWBS1CY1 = (SWBS1CY1=='Undefined' || SWBS1CY1==null || SWBS1CY1 =='')?'0':SWBS1CY1;
       
        OGW1CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY1"); 
        OGW1CY1 = (OGW1CY1=='Undefined' || OGW1CY1==null || OGW1CY1 =='')?'0':OGW1CY1;
        IDI1CY1 = component.get("v.wrapperData.Interestdividend_Income_O3_CY1");
        IDI1CY1 = (IDI1CY1=='Undefined' || IDI1CY1==null || IDI1CY1 =='')?'0':IDI1CY1;
        OI1CY1 = component.get("v.wrapperData.Other_Income_O3_CY1");
        OI1CY1 = (OI1CY1=='Undefined' || OI1CY1==null || OI1CY1 =='')?'0':OI1CY1;
        PID1CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O3_CY1");
        PID1CY1 = (PID1CY1=='Undefined' || PID1CY1==null || PID1CY1 =='')?'0':PID1CY1;
        SDCG1CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY1");
        SDCG1CY1 = (SDCG1CY1=='Undefined' || SDCG1CY1==null || SDCG1CY1 =='')?'0':SDCG1CY1;
        S_C_I1CY1 = component.get("v.wrapperData.Schedule_C_Income_O3_CY1");
        S_C_I1CY1 = (S_C_I1CY1=='Undefined' || S_C_I1CY1==null || S_C_I1CY1 =='')?'0':S_C_I1CY1;
        SER1CY1 = component.get("v.wrapperData.Schedule_E_Rental_O3_CY1");
        SER1CY1 = (SER1CY1=='Undefined' || SER1CY1==null || SER1CY1 =='')?'0':SER1CY1;
        KD1CY1 =  component.get("v.wrapperData.K1_Distributions_O3_CY1");
        KD1CY1 = (KD1CY1=='Undefined' || KD1CY1==null || KD1CY1 =='')?'0':KD1CY1;
        
        TotalOwner3CY1 = parseFloat(SWBO1CY1) + parseFloat(SWBS1CY1) + parseFloat(OGW1CY1) +  parseFloat(IDI1CY1) + parseFloat(OI1CY1) + parseFloat(PID1CY1) + parseFloat(SDCG1CY1) +  parseFloat(S_C_I1CY1) + parseFloat(SER1CY1) + parseFloat(KD1CY1); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O3_CY1", TotalOwner3CY1);
        
        //==============================Owner #1 CY- 2 ===================================
        var SWBO1CY2 = 0; 
        var SWBS1CY2 = 0;  
        var SDCG1CY2 = 0; 
        var S_C_I1CY2 = 0;  
        var SER1CY2 = 0;  
        var SCI1CY2 = 0; 
        var OGW1CY2 = 0; 
        var OI1CY2 = 0; 
        var KD1CY2 = 0; 
        var IDI1CY2 = 0; 
        var PID1CY2 = 0;
        var TotalOwner3CY2 = 0;
        
        SWBO1CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O3_CY2");
        SWBO1CY2 = (SWBO1CY2=='Undefined' || SWBO1CY2==null || SWBO1CY2 =='')?'0':SWBO1CY2;
       
        SWBS1CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O3_CY2");  
        SWBS1CY2 = (SWBS1CY2=='Undefined' || SWBS1CY2==null || SWBS1CY2 =='')?'0':SWBS1CY2;
       
        OGW1CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY2"); 
        OGW1CY2 = (OGW1CY2=='Undefined' || OGW1CY2==null || OGW1CY2 =='')?'0':OGW1CY2;
        IDI1CY2 = component.get("v.wrapperData.Interestdividend_Income_O3_CY2");
        IDI1CY2 = (IDI1CY2=='Undefined' || IDI1CY2==null || IDI1CY2 =='')?'0':IDI1CY2;
        OI1CY2 = component.get("v.wrapperData.Other_Income_O3_CY2");
        OI1CY2 = (OI1CY2=='Undefined' || OI1CY2==null || OI1CY2 =='')?'0':OI1CY2;
        PID1CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O3_CY2");
        PID1CY2 = (PID1CY2=='Undefined' || PID1CY2==null || PID1CY2 =='')?'0':PID1CY2;
        SDCG1CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY2");
        SDCG1CY2 = (SDCG1CY2=='Undefined' || SDCG1CY2==null || SDCG1CY2 =='')?'0':SDCG1CY2;
        S_C_I1CY2 = component.get("v.wrapperData.Schedule_C_Income_O3_CY2");
        S_C_I1CY2 = (S_C_I1CY2=='Undefined' || S_C_I1CY2==null || S_C_I1CY2 =='')?'0':S_C_I1CY2;
        SER1CY2 = component.get("v.wrapperData.Schedule_E_Rental_O3_CY2");
        SER1CY2 = (SER1CY2=='Undefined' || SER1CY2==null || SER1CY2 =='')?'0':SER1CY2;
        KD1CY2 =  component.get("v.wrapperData.K1_Distributions_O3_CY2");
        KD1CY2 = (KD1CY2=='Undefined' || KD1CY2==null || KD1CY2 =='')?'0':KD1CY2;
        
        TotalOwner3CY2 = parseFloat(SWBO1CY2) + parseFloat(SWBS1CY2) + parseFloat(OGW1CY2) +  parseFloat(IDI1CY2) + parseFloat(OI1CY2) + parseFloat(PID1CY2) + parseFloat(SDCG1CY2) +  parseFloat(S_C_I1CY2) + parseFloat(SER1CY2) + parseFloat(KD1CY2); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O3_CY2", TotalOwner3CY2);
        
        //============================Owner #1  CY-3- ==============================================
        var SWBO1CY3 = 0; 
        var SWBS1CY3 = 0;  
        var SDCG1CY3 = 0; 
        var S_C_I1CY3 = 0;  
        var SER1CY3 = 0;  
        var SCI1CY3 = 0; 
        var OGW1CY3 = 0; 
        var OI1CY3 = 0; 
        var KD1CY3 = 0; 
        var IDI1CY3 = 0; 
        var PID1CY3 = 0;
        var TotalOwner3CY3 = 0;
        
        SWBO1CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O3_CY3");
        SWBO1CY3 = (SWBO1CY3=='Undefined' || SWBO1CY3==null || SWBO1CY3 =='')?'0':SWBO1CY3;
       
        SWBS1CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O3_CY3");  
        SWBS1CY3 = (SWBS1CY3=='Undefined' || SWBS1CY3==null || SWBS1CY3 =='')?'0':SWBS1CY3;
       
        OGW1CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY3"); 
        OGW1CY3 = (OGW1CY3=='Undefined' || OGW1CY3==null || OGW1CY3 =='')?'0':OGW1CY3;
        IDI1CY3 = component.get("v.wrapperData.Interestdividend_Income_O3_CY3");
        IDI1CY3 = (IDI1CY3=='Undefined' || IDI1CY3==null || IDI1CY3 =='')?'0':IDI1CY3;
        OI1CY3 = component.get("v.wrapperData.Other_Income_O3_CY3");
        OI1CY3 = (OI1CY3=='Undefined' || OI1CY3==null || OI1CY3 =='')?'0':OI1CY3;
        PID1CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O3_CY3");
        PID1CY3 = (PID1CY3=='Undefined' || PID1CY3==null || PID1CY3 =='')?'0':PID1CY3;
        SDCG1CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY3");
        SDCG1CY3 = (SDCG1CY3=='Undefined' || SDCG1CY3==null || SDCG1CY3 =='')?'0':SDCG1CY3;
        S_C_I1CY3 = component.get("v.wrapperData.Schedule_C_Income_O3_CY3");
        S_C_I1CY3 = (S_C_I1CY3=='Undefined' || S_C_I1CY3==null || S_C_I1CY3 =='')?'0':S_C_I1CY3;
        SER1CY3 = component.get("v.wrapperData.Schedule_E_Rental_O3_CY3");
        SER1CY3 = (SER1CY3=='Undefined' || SER1CY3==null || SER1CY3 =='')?'0':SER1CY3;
        KD1CY3 =  component.get("v.wrapperData.K1_Distributions_O3_CY3");
        KD1CY3 = (KD1CY3=='Undefined' || KD1CY3==null || KD1CY3 =='')?'0':KD1CY3;
        
        TotalOwner3CY3 = parseFloat(SWBO1CY3) + parseFloat(SWBS1CY3) + parseFloat(OGW1CY3) +  parseFloat(IDI1CY3) + parseFloat(OI1CY3) + parseFloat(PID1CY3) + parseFloat(SDCG1CY3) +  parseFloat(S_C_I1CY3) + parseFloat(SER1CY3) + parseFloat(KD1CY3); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O3_CY3", TotalOwner3CY3);
       
    },
    calculatePersonalOwnerFourth : function(component, event, helper){
       
        
        var SWBO1CY = 0; 
        var SWBS1CY = 0;  
        var SDCG1CY = 0; 
        var S_C_I1CY = 0;  
        var SER1CY = 0;  
        var SCI1CY = 0; 
        var OGW1CY = 0; 
        var OI1CY = 0; 
        var KD1CY = 0; 
        var IDI1CY = 0; 
        var PID1CY = 0;
        var TotalOwner4CY = 0;
        
        SWBO1CY = component.get("v.wrapperData.Salary_Wages_Borrower_O4_CY");
        SWBO1CY = (SWBO1CY=='Undefined' || SWBO1CY==null || SWBO1CY =='')?'0':SWBO1CY;
       
        SWBS1CY = component.get("v.wrapperData.Salary_Wages_Spouse_O4_CY");  
        SWBS1CY = (SWBS1CY=='Undefined' || SWBS1CY==null || SWBS1CY =='')?'0':SWBS1CY;
       
        OGW1CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY"); 
        OGW1CY = (OGW1CY=='Undefined' || OGW1CY==null || OGW1CY =='')?'0':OGW1CY;
        IDI1CY = component.get("v.wrapperData.Interestdividend_Income_O4_CY");
        IDI1CY = (IDI1CY=='Undefined' || IDI1CY==null || IDI1CY =='')?'0':IDI1CY;
        OI1CY = component.get("v.wrapperData.Other_Income_O4_CY");
        OI1CY = (OI1CY=='Undefined' || OI1CY==null || OI1CY =='')?'0':OI1CY;
        PID1CY = component.get("v.wrapperData.PensionIRA_Distributions_O4_CY");
        PID1CY = (PID1CY=='Undefined' || PID1CY==null || PID1CY =='')?'0':PID1CY;
        SDCG1CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY");
        SDCG1CY = (SDCG1CY=='Undefined' || SDCG1CY==null || SDCG1CY =='')?'0':SDCG1CY;
        S_C_I1CY = component.get("v.wrapperData.Schedule_C_Income_O4_CY");
        S_C_I1CY = (S_C_I1CY=='Undefined' || S_C_I1CY==null || S_C_I1CY =='')?'0':S_C_I1CY;
        SER1CY = component.get("v.wrapperData.Schedule_E_Rental_O4_CY");
        SER1CY = (SER1CY=='Undefined' || SER1CY==null || SER1CY =='')?'0':SER1CY;
        KD1CY =  component.get("v.wrapperData.K1_Distributions_O4_CY");
        KD1CY = (KD1CY=='Undefined' || KD1CY==null || KD1CY =='')?'0':KD1CY;
        
        TotalOwner4CY = parseFloat(SWBO1CY) + parseFloat(SWBS1CY) + parseFloat(OGW1CY) +  parseFloat(IDI1CY) + parseFloat(OI1CY) + parseFloat(PID1CY) + parseFloat(SDCG1CY) +  parseFloat(S_C_I1CY) + parseFloat(SER1CY) + parseFloat(KD1CY); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O4_CY", TotalOwner4CY);
        
        //=====================Owner #1 CY-1 =========================================
        var SWBO1CY1 = 0; 
        var SWBS1CY1 = 0;  
        var SDCG1CY1 = 0; 
        var S_C_I1CY1 = 0;  
        var SER1CY1 = 0;  
        var SCI1CY1 = 0; 
        var OGW1CY1 = 0; 
        var OI1CY1 = 0; 
        var KD1CY1 = 0; 
        var IDI1CY1 = 0; 
        var PID1CY1 = 0;
        var TotalOwner4CY1 = 0;
        
        SWBO1CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O4_CY1");
        SWBO1CY1 = (SWBO1CY1=='Undefined' || SWBO1CY1==null || SWBO1CY1 =='')?'0':SWBO1CY1;
       
        SWBS1CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O4_CY1");  
        SWBS1CY1 = (SWBS1CY1=='Undefined' || SWBS1CY1==null || SWBS1CY1 =='')?'0':SWBS1CY1;
       
        OGW1CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY1"); 
        OGW1CY1 = (OGW1CY1=='Undefined' || OGW1CY1==null || OGW1CY1 =='')?'0':OGW1CY1;
        IDI1CY1 = component.get("v.wrapperData.Interestdividend_Income_O4_CY1");
        IDI1CY1 = (IDI1CY1=='Undefined' || IDI1CY1==null || IDI1CY1 =='')?'0':IDI1CY1;
        OI1CY1 = component.get("v.wrapperData.Other_Income_O4_CY1");
        OI1CY1 = (OI1CY1=='Undefined' || OI1CY1==null || OI1CY1 =='')?'0':OI1CY1;
        PID1CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O4_CY1");
        PID1CY1 = (PID1CY1=='Undefined' || PID1CY1==null || PID1CY1 =='')?'0':PID1CY1;
        SDCG1CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY1");
        SDCG1CY1 = (SDCG1CY1=='Undefined' || SDCG1CY1==null || SDCG1CY1 =='')?'0':SDCG1CY1;
        S_C_I1CY1 = component.get("v.wrapperData.Schedule_C_Income_O4_CY1");
        S_C_I1CY1 = (S_C_I1CY1=='Undefined' || S_C_I1CY1==null || S_C_I1CY1 =='')?'0':S_C_I1CY1;
        SER1CY1 = component.get("v.wrapperData.Schedule_E_Rental_O4_CY1");
        SER1CY1 = (SER1CY1=='Undefined' || SER1CY1==null || SER1CY1 =='')?'0':SER1CY1;
        KD1CY1 =  component.get("v.wrapperData.K1_Distributions_O4_CY1");
        KD1CY1 = (KD1CY1=='Undefined' || KD1CY1==null || KD1CY1 =='')?'0':KD1CY1;
        
        TotalOwner4CY1 = parseFloat(SWBO1CY1) + parseFloat(SWBS1CY1) + parseFloat(OGW1CY1) +  parseFloat(IDI1CY1) + parseFloat(OI1CY1) + parseFloat(PID1CY1) + parseFloat(SDCG1CY1) +  parseFloat(S_C_I1CY1) + parseFloat(SER1CY1) + parseFloat(KD1CY1); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O4_CY1", TotalOwner4CY1);
        
        //==============================Owner #1 CY- 2 ===================================
        var SWBO1CY2 = 0; 
        var SWBS1CY2 = 0;  
        var SDCG1CY2 = 0; 
        var S_C_I1CY2 = 0;  
        var SER1CY2 = 0;  
        var SCI1CY2 = 0; 
        var OGW1CY2 = 0; 
        var OI1CY2 = 0; 
        var KD1CY2 = 0; 
        var IDI1CY2 = 0; 
        var PID1CY2 = 0;
        var TotalOwner4CY2 = 0;
        
        SWBO1CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O4_CY2");
        SWBO1CY2 = (SWBO1CY2=='Undefined' || SWBO1CY2==null || SWBO1CY2 =='')?'0':SWBO1CY2;
       
        SWBS1CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O4_CY2");  
        SWBS1CY2 = (SWBS1CY2=='Undefined' || SWBS1CY2==null || SWBS1CY2 =='')?'0':SWBS1CY2;
       
        OGW1CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY2"); 
        OGW1CY2 = (OGW1CY2=='Undefined' || OGW1CY2==null || OGW1CY2 =='')?'0':OGW1CY2;
        IDI1CY2 = component.get("v.wrapperData.Interestdividend_Income_O4_CY2");
        IDI1CY2 = (IDI1CY2=='Undefined' || IDI1CY2==null || IDI1CY2 =='')?'0':IDI1CY2;
        OI1CY2 = component.get("v.wrapperData.Other_Income_O4_CY2");
        OI1CY2 = (OI1CY2=='Undefined' || OI1CY2==null || OI1CY2 =='')?'0':OI1CY2;
        PID1CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O4_CY2");
        PID1CY2 = (PID1CY2=='Undefined' || PID1CY2==null || PID1CY2 =='')?'0':PID1CY2;
        SDCG1CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY2");
        SDCG1CY2 = (SDCG1CY2=='Undefined' || SDCG1CY2==null || SDCG1CY2 =='')?'0':SDCG1CY2;
        S_C_I1CY2 = component.get("v.wrapperData.Schedule_C_Income_O4_CY2");
        S_C_I1CY2 = (S_C_I1CY2=='Undefined' || S_C_I1CY2==null || S_C_I1CY2 =='')?'0':S_C_I1CY2;
        SER1CY2 = component.get("v.wrapperData.Schedule_E_Rental_O4_CY2");
        SER1CY2 = (SER1CY2=='Undefined' || SER1CY2==null || SER1CY2 =='')?'0':SER1CY2;
        KD1CY2 =  component.get("v.wrapperData.K1_Distributions_O4_CY2");
        KD1CY2 = (KD1CY2=='Undefined' || KD1CY2==null || KD1CY2 =='')?'0':KD1CY2;
        
        TotalOwner4CY2 = parseFloat(SWBO1CY2) + parseFloat(SWBS1CY2) + parseFloat(OGW1CY2) +  parseFloat(IDI1CY2) + parseFloat(OI1CY2) + parseFloat(PID1CY2) + parseFloat(SDCG1CY2) +  parseFloat(S_C_I1CY2) + parseFloat(SER1CY2) + parseFloat(KD1CY2); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O4_CY2", TotalOwner4CY2);
        
        //============================Owner #1  CY-3- ==============================================
        var SWBO1CY3 = 0; 
        var SWBS1CY3 = 0;  
        var SDCG1CY3 = 0; 
        var S_C_I1CY3 = 0;  
        var SER1CY3 = 0;  
        var SCI1CY3 = 0; 
        var OGW1CY3 = 0; 
        var OI1CY3 = 0; 
        var KD1CY3 = 0; 
        var IDI1CY3 = 0; 
        var PID1CY3 = 0;
        var TotalOwner4CY3 = 0;
        
        SWBO1CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O4_CY3");
        SWBO1CY3 = (SWBO1CY3=='Undefined' || SWBO1CY3==null || SWBO1CY3 =='')?'0':SWBO1CY3;
       
        SWBS1CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O4_CY3");  
        SWBS1CY3 = (SWBS1CY3=='Undefined' || SWBS1CY3==null || SWBS1CY3 =='')?'0':SWBS1CY3;
       
        OGW1CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY3"); 
        OGW1CY3 = (OGW1CY3=='Undefined' || OGW1CY3==null || OGW1CY3 =='')?'0':OGW1CY3;
        IDI1CY3 = component.get("v.wrapperData.Interestdividend_Income_O4_CY3");
        IDI1CY3 = (IDI1CY3=='Undefined' || IDI1CY3==null || IDI1CY3 =='')?'0':IDI1CY3;
        OI1CY3 = component.get("v.wrapperData.Other_Income_O4_CY3");
        OI1CY3 = (OI1CY3=='Undefined' || OI1CY3==null || OI1CY3 =='')?'0':OI1CY3;
        PID1CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O4_CY3");
        PID1CY3 = (PID1CY3=='Undefined' || PID1CY3==null || PID1CY3 =='')?'0':PID1CY3;
        SDCG1CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY3");
        SDCG1CY3 = (SDCG1CY3=='Undefined' || SDCG1CY3==null || SDCG1CY3 =='')?'0':SDCG1CY3;
        S_C_I1CY3 = component.get("v.wrapperData.Schedule_C_Income_O4_CY3");
        S_C_I1CY3 = (S_C_I1CY3=='Undefined' || S_C_I1CY3==null || S_C_I1CY3 =='')?'0':S_C_I1CY3;
        SER1CY3 = component.get("v.wrapperData.Schedule_E_Rental_O4_CY3");
        SER1CY3 = (SER1CY3=='Undefined' || SER1CY3==null || SER1CY3 =='')?'0':SER1CY3;
        KD1CY3 =  component.get("v.wrapperData.K1_Distributions_O4_CY3");
        KD1CY3 = (KD1CY3=='Undefined' || KD1CY3==null || KD1CY3 =='')?'0':KD1CY3;
        
        TotalOwner4CY3 = parseFloat(SWBO1CY3) + parseFloat(SWBS1CY3) + parseFloat(OGW1CY3) +  parseFloat(IDI1CY3) + parseFloat(OI1CY3) + parseFloat(PID1CY3) + parseFloat(SDCG1CY3) +  parseFloat(S_C_I1CY3) + parseFloat(SER1CY3) + parseFloat(KD1CY3); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O4_CY3", TotalOwner4CY3);
       
    },
    calculatePersonalOwnerFifth : function(component, event, helper){
       
        
        var SWBO1CY = 0; 
        var SWBS1CY = 0;  
        var SDCG1CY = 0; 
        var S_C_I1CY = 0;  
        var SER1CY = 0;  
        var SCI1CY = 0; 
        var OGW1CY = 0; 
        var OI1CY = 0; 
        var KD1CY = 0; 
        var IDI1CY = 0; 
        var PID1CY = 0;
        var TotalOwner5CY = 0;
        
        SWBO1CY = component.get("v.wrapperData.Salary_Wages_Borrower_O5_CY");
        SWBO1CY = (SWBO1CY=='Undefined' || SWBO1CY==null || SWBO1CY =='')?'0':SWBO1CY;
       
        SWBS1CY = component.get("v.wrapperData.Salary_Wages_Spouse_O5_CY");  
        SWBS1CY = (SWBS1CY=='Undefined' || SWBS1CY==null || SWBS1CY =='')?'0':SWBS1CY;
       
        OGW1CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY"); 
        OGW1CY = (OGW1CY=='Undefined' || OGW1CY==null || OGW1CY =='')?'0':OGW1CY;
        IDI1CY = component.get("v.wrapperData.Interestdividend_Income_O5_CY");
        IDI1CY = (IDI1CY=='Undefined' || IDI1CY==null || IDI1CY =='')?'0':IDI1CY;
        OI1CY = component.get("v.wrapperData.Other_Income_O5_CY");
        OI1CY = (OI1CY=='Undefined' || OI1CY==null || OI1CY =='')?'0':OI1CY;
        PID1CY = component.get("v.wrapperData.PensionIRA_Distributions_O5_CY");
        PID1CY = (PID1CY=='Undefined' || PID1CY==null || PID1CY =='')?'0':PID1CY;
        SDCG1CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY");
        SDCG1CY = (SDCG1CY=='Undefined' || SDCG1CY==null || SDCG1CY =='')?'0':SDCG1CY;
        S_C_I1CY = component.get("v.wrapperData.Schedule_C_Income_O5_CY");
        S_C_I1CY = (S_C_I1CY=='Undefined' || S_C_I1CY==null || S_C_I1CY =='')?'0':S_C_I1CY;
        SER1CY = component.get("v.wrapperData.Schedule_E_Rental_O5_CY");
        SER1CY = (SER1CY=='Undefined' || SER1CY==null || SER1CY =='')?'0':SER1CY;
        KD1CY =  component.get("v.wrapperData.K1_Distributions_O5_CY");
        KD1CY = (KD1CY=='Undefined' || KD1CY==null || KD1CY =='')?'0':KD1CY;
        
        TotalOwner5CY = parseFloat(SWBO1CY) + parseFloat(SWBS1CY) + parseFloat(OGW1CY) +  parseFloat(IDI1CY) + parseFloat(OI1CY) + parseFloat(PID1CY) + parseFloat(SDCG1CY) +  parseFloat(S_C_I1CY) + parseFloat(SER1CY) + parseFloat(KD1CY); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O5_CY", TotalOwner5CY);
        
        //=====================Owner #1 CY-1 =========================================
        var SWBO1CY1 = 0; 
        var SWBS1CY1 = 0;  
        var SDCG1CY1 = 0; 
        var S_C_I1CY1 = 0;  
        var SER1CY1 = 0;  
        var SCI1CY1 = 0; 
        var OGW1CY1 = 0; 
        var OI1CY1 = 0; 
        var KD1CY1 = 0; 
        var IDI1CY1 = 0; 
        var PID1CY1 = 0;
        var TotalOwner5CY1 = 0;
        
        SWBO1CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O5_CY1");
        SWBO1CY1 = (SWBO1CY1=='Undefined' || SWBO1CY1==null || SWBO1CY1 =='')?'0':SWBO1CY1;
       
        SWBS1CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O5_CY1");  
        SWBS1CY1 = (SWBS1CY1=='Undefined' || SWBS1CY1==null || SWBS1CY1 =='')?'0':SWBS1CY1;
       
        OGW1CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY1"); 
        OGW1CY1 = (OGW1CY1=='Undefined' || OGW1CY1==null || OGW1CY1 =='')?'0':OGW1CY1;
        IDI1CY1 = component.get("v.wrapperData.Interestdividend_Income_O5_CY1");
        IDI1CY1 = (IDI1CY1=='Undefined' || IDI1CY1==null || IDI1CY1 =='')?'0':IDI1CY1;
        OI1CY1 = component.get("v.wrapperData.Other_Income_O5_CY1");
        OI1CY1 = (OI1CY1=='Undefined' || OI1CY1==null || OI1CY1 =='')?'0':OI1CY1;
        PID1CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O5_CY1");
        PID1CY1 = (PID1CY1=='Undefined' || PID1CY1==null || PID1CY1 =='')?'0':PID1CY1;
        SDCG1CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY1");
        SDCG1CY1 = (SDCG1CY1=='Undefined' || SDCG1CY1==null || SDCG1CY1 =='')?'0':SDCG1CY1;
        S_C_I1CY1 = component.get("v.wrapperData.Schedule_C_Income_O5_CY1");
        S_C_I1CY1 = (S_C_I1CY1=='Undefined' || S_C_I1CY1==null || S_C_I1CY1 =='')?'0':S_C_I1CY1;
        SER1CY1 = component.get("v.wrapperData.Schedule_E_Rental_O5_CY1");
        SER1CY1 = (SER1CY1=='Undefined' || SER1CY1==null || SER1CY1 =='')?'0':SER1CY1;
        KD1CY1 =  component.get("v.wrapperData.K1_Distributions_O5_CY1");
        KD1CY1 = (KD1CY1=='Undefined' || KD1CY1==null || KD1CY1 =='')?'0':KD1CY1;
        
        TotalOwner5CY1 = parseFloat(SWBO1CY1) + parseFloat(SWBS1CY1) + parseFloat(OGW1CY1) +  parseFloat(IDI1CY1) + parseFloat(OI1CY1) + parseFloat(PID1CY1) + parseFloat(SDCG1CY1) +  parseFloat(S_C_I1CY1) + parseFloat(SER1CY1) + parseFloat(KD1CY1); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O5_CY1", TotalOwner5CY1);
        
        //==============================Owner #1 CY- 2 ===================================
        var SWBO1CY2 = 0; 
        var SWBS1CY2 = 0;  
        var SDCG1CY2 = 0; 
        var S_C_I1CY2 = 0;  
        var SER1CY2 = 0;  
        var SCI1CY2 = 0; 
        var OGW1CY2 = 0; 
        var OI1CY2 = 0; 
        var KD1CY2 = 0; 
        var IDI1CY2 = 0; 
        var PID1CY2 = 0;
        var TotalOwner5CY2 = 0;
        
        SWBO1CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O5_CY2");
        SWBO1CY2 = (SWBO1CY2=='Undefined' || SWBO1CY2==null || SWBO1CY2 =='')?'0':SWBO1CY2;
       
        SWBS1CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O5_CY2");  
        SWBS1CY2 = (SWBS1CY2=='Undefined' || SWBS1CY2==null || SWBS1CY2 =='')?'0':SWBS1CY2;
       
        OGW1CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY2"); 
        OGW1CY2 = (OGW1CY2=='Undefined' || OGW1CY2==null || OGW1CY2 =='')?'0':OGW1CY2;
        IDI1CY2 = component.get("v.wrapperData.Interestdividend_Income_O5_CY2");
        IDI1CY2 = (IDI1CY2=='Undefined' || IDI1CY2==null || IDI1CY2 =='')?'0':IDI1CY2;
        OI1CY2 = component.get("v.wrapperData.Other_Income_O5_CY2");
        OI1CY2 = (OI1CY2=='Undefined' || OI1CY2==null || OI1CY2 =='')?'0':OI1CY2;
        PID1CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O5_CY2");
        PID1CY2 = (PID1CY2=='Undefined' || PID1CY2==null || PID1CY2 =='')?'0':PID1CY2;
        SDCG1CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY2");
        SDCG1CY2 = (SDCG1CY2=='Undefined' || SDCG1CY2==null || SDCG1CY2 =='')?'0':SDCG1CY2;
        S_C_I1CY2 = component.get("v.wrapperData.Schedule_C_Income_O5_CY2");
        S_C_I1CY2 = (S_C_I1CY2=='Undefined' || S_C_I1CY2==null || S_C_I1CY2 =='')?'0':S_C_I1CY2;
        SER1CY2 = component.get("v.wrapperData.Schedule_E_Rental_O5_CY2");
        SER1CY2 = (SER1CY2=='Undefined' || SER1CY2==null || SER1CY2 =='')?'0':SER1CY2;
        KD1CY2 =  component.get("v.wrapperData.K1_Distributions_O5_CY2");
        KD1CY2 = (KD1CY2=='Undefined' || KD1CY2==null || KD1CY2 =='')?'0':KD1CY2;
        
        TotalOwner5CY2 = parseFloat(SWBO1CY2) + parseFloat(SWBS1CY2) + parseFloat(OGW1CY2) +  parseFloat(IDI1CY2) + parseFloat(OI1CY2) + parseFloat(PID1CY2) + parseFloat(SDCG1CY2) +  parseFloat(S_C_I1CY2) + parseFloat(SER1CY2) + parseFloat(KD1CY2); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O5_CY2", TotalOwner5CY2);
        
        //============================Owner #1  CY-3- ==============================================
        var SWBO1CY3 = 0; 
        var SWBS1CY3 = 0;  
        var SDCG1CY3 = 0; 
        var S_C_I1CY3 = 0;  
        var SER1CY3 = 0;  
        var SCI1CY3 = 0; 
        var OGW1CY3 = 0; 
        var OI1CY3 = 0; 
        var KD1CY3 = 0; 
        var IDI1CY3 = 0; 
        var PID1CY3 = 0;
        var TotalOwner5CY3 = 0;
        
        SWBO1CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O5_CY3");
        SWBO1CY3 = (SWBO1CY3=='Undefined' || SWBO1CY3==null || SWBO1CY3 =='')?'0':SWBO1CY3;
       
        SWBS1CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O5_CY3");  
        SWBS1CY3 = (SWBS1CY3=='Undefined' || SWBS1CY3==null || SWBS1CY3 =='')?'0':SWBS1CY3;
       
        OGW1CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY3"); 
        OGW1CY3 = (OGW1CY3=='Undefined' || OGW1CY3==null || OGW1CY3 =='')?'0':OGW1CY3;
        IDI1CY3 = component.get("v.wrapperData.Interestdividend_Income_O5_CY3");
        IDI1CY3 = (IDI1CY3=='Undefined' || IDI1CY3==null || IDI1CY3 =='')?'0':IDI1CY3;
        OI1CY3 = component.get("v.wrapperData.Other_Income_O5_CY3");
        OI1CY3 = (OI1CY3=='Undefined' || OI1CY3==null || OI1CY3 =='')?'0':OI1CY3;
        PID1CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O5_CY3");
        PID1CY3 = (PID1CY3=='Undefined' || PID1CY3==null || PID1CY3 =='')?'0':PID1CY3;
        SDCG1CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY3");
        SDCG1CY3 = (SDCG1CY3=='Undefined' || SDCG1CY3==null || SDCG1CY3 =='')?'0':SDCG1CY3;
        S_C_I1CY3 = component.get("v.wrapperData.Schedule_C_Income_O5_CY3");
        S_C_I1CY3 = (S_C_I1CY3=='Undefined' || S_C_I1CY3==null || S_C_I1CY3 =='')?'0':S_C_I1CY3;
        SER1CY3 = component.get("v.wrapperData.Schedule_E_Rental_O5_CY3");
        SER1CY3 = (SER1CY3=='Undefined' || SER1CY3==null || SER1CY3 =='')?'0':SER1CY3;
        KD1CY3 =  component.get("v.wrapperData.K1_Distributions_O5_CY3");
        KD1CY3 = (KD1CY3=='Undefined' || KD1CY3==null || KD1CY3 =='')?'0':KD1CY3;
        
        TotalOwner5CY3 = parseFloat(SWBO1CY3) + parseFloat(SWBS1CY3) + parseFloat(OGW1CY3) +  parseFloat(IDI1CY3) + parseFloat(OI1CY3) + parseFloat(PID1CY3) + parseFloat(SDCG1CY3) +  parseFloat(S_C_I1CY3) + parseFloat(SER1CY3) + parseFloat(KD1CY3); 
      
      
        
        component.set("v.wrapperData.Total_Estimated_Personal_O5_CY3", TotalOwner5CY3);
       
    },
    IndustryHighRisk : function(component, event, helper){
        var IndustryHighRisk = component.find("IndustryHighRisk").get("v.checked");
        //"{!v.wrapperData.Industry_High_Risk}";
        component.set("v.wrapperData.Industry_High_Risk", IndustryHighRisk);
    }
    
})