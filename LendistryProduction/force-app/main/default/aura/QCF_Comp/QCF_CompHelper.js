({
    loadQCFData: function (component, event,helper) {
        var leadID = component.get("v.recordId");
        var action = component.get("c.getQuickCashFlowData");
        action.setParams({mainWrapperData : component.get("v.wrapperData"), leadID : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                component.set("v.wrapperData", response.getReturnValue());
                console.log("Success Call leadID : " +leadID);
                component.set("v.HighestCreditScore", component.get("v.wrapperData.Highest_Credit_Score"));
            }
            else {
                console.log("Failed with state: " + state + v.wrapperData);
            }
        });
        $A.enqueueAction(action);
    },
    
    RunQuickCashFlow : function(component, event,helper){
        var leadID = component.get("v.recordId");
        helper.showSpinner(component);
        var action = component.get("c.runQuickCashFlow");
        
        // Check implemented to send Zero for mandatory fields when user haven't entered any value on those fields
        var Months_CY3 = component.get("v.wrapperData.Months_CY3");
        Months_CY3 = (Months_CY3=='Undefined' || Months_CY3==null || Months_CY3 =='')?0:Months_CY3;
        component.set("v.wrapperData.Months_CY3", Months_CY3);
        
        var Months_CY2 = component.get("v.wrapperData.Months_CY2");
        Months_CY2 = (Months_CY2=='Undefined' || Months_CY2==null || Months_CY2 =='')?0:Months_CY2;
        component.set("v.wrapperData.Months_CY2", Months_CY2);
        
        var Months_CY1 = component.get("v.wrapperData.Months_CY1");
        Months_CY1 = (Months_CY1=='Undefined' || Months_CY1==null || Months_CY1 =='')?0:Months_CY1;
        component.set("v.wrapperData.Months_CY1", Months_CY1);
        
        var Months_CY = component.get("v.wrapperData.Months_CY");
        Months_CY = (Months_CY=='Undefined' || Months_CY==null || Months_CY =='')?0:Months_CY;
        component.set("v.wrapperData.Months_CY", Months_CY); 
        
        var SalesCY3 = component.get("v.wrapperData.Sales_CY3");
        SalesCY3 = (SalesCY3=='Undefined' || SalesCY3==null || SalesCY3 =='')?0:SalesCY3;
        component.set("v.wrapperData.Sales_CY3", SalesCY3);
        
        var Sales_CY2 = component.get("v.wrapperData.Sales_CY2");
        Sales_CY2 = (Sales_CY2=='Undefined' || Sales_CY2==null || Sales_CY2 =='')?0:Sales_CY2;
        component.set("v.wrapperData.Sales_CY2", Sales_CY2);
        
        var Sales_CY1 = component.get("v.wrapperData.Sales_CY1");
        Sales_CY1 = (Sales_CY1=='Undefined' || Sales_CY1==null || Sales_CY1 =='')?0:Sales_CY1;
        component.set("v.wrapperData.Sales_CY1", Sales_CY1);
        
        var Sales_CY = component.get("v.wrapperData.Sales_CY");
        Sales_CY = (Sales_CY=='Undefined' || Sales_CY==null || Sales_CY =='')?0:Sales_CY;
        component.set("v.wrapperData.Sales_CY", Sales_CY);
        
        var Net_Profit_CY3 = component.get("v.wrapperData.Net_Profit_CY3");
        Net_Profit_CY3 = (Net_Profit_CY3=='Undefined' || Net_Profit_CY3==null || Net_Profit_CY3 =='')?0:Net_Profit_CY3;
        component.set("v.wrapperData.Net_Profit_CY3", Net_Profit_CY3);
        
        var Net_Profit_CY2 = component.get("v.wrapperData.Net_Profit_CY2");
        Net_Profit_CY2 = (Net_Profit_CY2=='Undefined' || Net_Profit_CY2==null || Net_Profit_CY2 =='')?0:Net_Profit_CY2;
        component.set("v.wrapperData.Net_Profit_CY2", Net_Profit_CY2);
        
        var Net_Profit_CY1 = component.get("v.wrapperData.Net_Profit_CY1");
        Net_Profit_CY1 = (Net_Profit_CY1=='Undefined' || Net_Profit_CY1==null || Net_Profit_CY1 =='')?0:Net_Profit_CY1;
        component.set("v.wrapperData.Net_Profit_CY1", Net_Profit_CY1);
        
        var Net_Profit_CY = component.get("v.wrapperData.Net_Profit_CY");
        Net_Profit_CY = (Net_Profit_CY=='Undefined' || Net_Profit_CY==null || Net_Profit_CY =='')?0:Net_Profit_CY;
        component.set("v.wrapperData.Net_Profit_CY", Net_Profit_CY);
        
        var New_Rents_CY3 = component.get("v.wrapperData.New_Rents_CY3");
        New_Rents_CY3 = (New_Rents_CY3=='Undefined' || New_Rents_CY3==null || New_Rents_CY3 =='')?0:New_Rents_CY3;
        component.set("v.wrapperData.New_Rents_CY3", New_Rents_CY3);
        
        var New_Rents_CY2 = component.get("v.wrapperData.New_Rents_CY2");
        New_Rents_CY2 = (New_Rents_CY2=='Undefined' || New_Rents_CY2==null || New_Rents_CY2 =='')?0:New_Rents_CY2;
        component.set("v.wrapperData.New_Rents_CY2", New_Rents_CY2);
        
        var New_Rents_CY1 = component.get("v.wrapperData.New_Rents_CY1");
        New_Rents_CY1 = (New_Rents_CY1=='Undefined' || New_Rents_CY1==null || New_Rents_CY1 =='')?0:New_Rents_CY1;
        component.set("v.wrapperData.New_Rents_CY1", New_Rents_CY1);
        
        var New_Rents_CY = component.get("v.wrapperData.New_Rents_CY");
        New_Rents_CY = (New_Rents_CY=='Undefined' || New_Rents_CY==null || New_Rents_CY =='')?0:New_Rents_CY;
        component.set("v.wrapperData.New_Rents_CY", New_Rents_CY);
        
        var Interest_Exp_CY3 = component.get("v.wrapperData.Interest_Exp_CY3");
        Interest_Exp_CY3 = (Interest_Exp_CY3=='Undefined' || Interest_Exp_CY3==null || Interest_Exp_CY3 =='')?0:Interest_Exp_CY3;
        component.set("v.wrapperData.Interest_Exp_CY3", Interest_Exp_CY3);
        
        var Interest_Exp_CY2 = component.get("v.wrapperData.Interest_Exp_CY2");
        Interest_Exp_CY2 = (Interest_Exp_CY2=='Undefined' || Interest_Exp_CY2==null || Interest_Exp_CY2 =='')?0:Interest_Exp_CY2;
        component.set("v.wrapperData.Interest_Exp_CY2", Interest_Exp_CY2);
        
        var Interest_Exp_CY1 = component.get("v.wrapperData.Interest_Exp_CY1");
        Interest_Exp_CY1 = (Interest_Exp_CY1=='Undefined' || Interest_Exp_CY1==null || Interest_Exp_CY1 =='')?0:Interest_Exp_CY1;
        component.set("v.wrapperData.Interest_Exp_CY1", Interest_Exp_CY1);
        
        var Interest_Exp_CY = component.get("v.wrapperData.Interest_Exp_CY");
        Interest_Exp_CY = (Interest_Exp_CY=='Undefined' || Interest_Exp_CY==null || Interest_Exp_CY =='')?0:Interest_Exp_CY;
        component.set("v.wrapperData.Interest_Exp_CY", Interest_Exp_CY);
        
        var Non_Recurring_Expenses_CY3 = component.get("v.wrapperData.Non_Recurring_Expenses_CY3");
        Non_Recurring_Expenses_CY3 = (Non_Recurring_Expenses_CY3=='Undefined' || Non_Recurring_Expenses_CY3==null || Non_Recurring_Expenses_CY3 =='')?0:Non_Recurring_Expenses_CY3;
        component.set("v.wrapperData.Non_Recurring_Expenses_CY3", Non_Recurring_Expenses_CY3);
        
        var Non_Recurring_Expenses_CY2 = component.get("v.wrapperData.Non_Recurring_Expenses_CY2");
        Non_Recurring_Expenses_CY2 = (Non_Recurring_Expenses_CY2=='Undefined' || Non_Recurring_Expenses_CY2==null || Non_Recurring_Expenses_CY2 =='')?0:Non_Recurring_Expenses_CY2;
        component.set("v.wrapperData.Non_Recurring_Expenses_CY2", Non_Recurring_Expenses_CY2);
        
        var Non_Recurring_Expenses_CY1 = component.get("v.wrapperData.Non_Recurring_Expenses_CY1");
        Non_Recurring_Expenses_CY1 = (Non_Recurring_Expenses_CY1=='Undefined' || Non_Recurring_Expenses_CY1==null || Non_Recurring_Expenses_CY1 =='')?0:Non_Recurring_Expenses_CY1;
        component.set("v.wrapperData.Non_Recurring_Expenses_CY1", Non_Recurring_Expenses_CY1);
        
        var Non_Recurring_Expenses_CY = component.get("v.wrapperData.Non_Recurring_Expenses_CY");
        Non_Recurring_Expenses_CY = (Non_Recurring_Expenses_CY=='Undefined' || Non_Recurring_Expenses_CY==null || Non_Recurring_Expenses_CY =='')?0:Non_Recurring_Expenses_CY;
        component.set("v.wrapperData.Non_Recurring_Expenses_CY", Non_Recurring_Expenses_CY);
        
        var Affilliate_Income_CY3 = component.get("v.wrapperData.Affilliate_Income_CY3");
        Affilliate_Income_CY3 = (Affilliate_Income_CY3=='Undefined' || Affilliate_Income_CY3==null || Affilliate_Income_CY3 =='')?0:Affilliate_Income_CY3;
        component.set("v.wrapperData.Affilliate_Income_CY3", Affilliate_Income_CY3);
        
        var Affilliate_Income_CY2 = component.get("v.wrapperData.Affilliate_Income_CY2");
        Affilliate_Income_CY2 = (Affilliate_Income_CY2=='Undefined' || Affilliate_Income_CY2==null || Affilliate_Income_CY2 =='')?0:Affilliate_Income_CY2;
        component.set("v.wrapperData.Affilliate_Income_CY2", Affilliate_Income_CY2);
        
        var Affilliate_Income_CY1 = component.get("v.wrapperData.Affilliate_Income_CY1");
        Affilliate_Income_CY1 = (Affilliate_Income_CY1=='Undefined' || Affilliate_Income_CY1==null || Affilliate_Income_CY1 =='')?0:Affilliate_Income_CY1;
        component.set("v.wrapperData.Affilliate_Income_CY1", Affilliate_Income_CY1);
        
        var Affilliate_Income_CY = component.get("v.wrapperData.Affilliate_Income_CY");
        Affilliate_Income_CY = (Affilliate_Income_CY=='Undefined' || Affilliate_Income_CY==null || Affilliate_Income_CY =='')?0:Affilliate_Income_CY;
        component.set("v.wrapperData.Affilliate_Income_CY", Affilliate_Income_CY);
        
        var Monthly_Existing_Installment_Debt_CY3 = component.get("v.wrapperData.Monthly_Existing_Installment_Debt_CY3");
        Monthly_Existing_Installment_Debt_CY3 = (Monthly_Existing_Installment_Debt_CY3=='Undefined' || Monthly_Existing_Installment_Debt_CY3==null || Monthly_Existing_Installment_Debt_CY3 =='')?0:Monthly_Existing_Installment_Debt_CY3;
        component.set("v.wrapperData.Monthly_Existing_Installment_Debt_CY3", Monthly_Existing_Installment_Debt_CY3);
        
        var Monthly_Existing_Installment_Debt_CY2 = component.get("v.wrapperData.Monthly_Existing_Installment_Debt_CY2");
        Monthly_Existing_Installment_Debt_CY2 = (Monthly_Existing_Installment_Debt_CY2=='Undefined' || Monthly_Existing_Installment_Debt_CY2==null || Monthly_Existing_Installment_Debt_CY2 =='')?0:Monthly_Existing_Installment_Debt_CY2;
        component.set("v.wrapperData.Monthly_Existing_Installment_Debt_CY2", Monthly_Existing_Installment_Debt_CY2);
        
        var Monthly_Existing_Installment_Debt_CY1 = component.get("v.wrapperData.Monthly_Existing_Installment_Debt_CY1");
        Monthly_Existing_Installment_Debt_CY1 = (Monthly_Existing_Installment_Debt_CY1=='Undefined' || Monthly_Existing_Installment_Debt_CY1==null || Monthly_Existing_Installment_Debt_CY1 =='')?0:Monthly_Existing_Installment_Debt_CY1;
        component.set("v.wrapperData.Monthly_Existing_Installment_Debt_CY1", Monthly_Existing_Installment_Debt_CY1);
        
        var Monthly_Existing_Installment_Debt_CY = component.get("v.wrapperData.Monthly_Existing_Installment_Debt_CY");
        Monthly_Existing_Installment_Debt_CY = (Monthly_Existing_Installment_Debt_CY=='Undefined' || Monthly_Existing_Installment_Debt_CY==null || Monthly_Existing_Installment_Debt_CY =='')?0:Monthly_Existing_Installment_Debt_CY;
        component.set("v.wrapperData.Monthly_Existing_Installment_Debt_CY", Monthly_Existing_Installment_Debt_CY);
        
        var Loan_Amount_Actual = component.get("v.wrapperData.Loan_Amount_Actual");
        Loan_Amount_Actual = (Loan_Amount_Actual=='Undefined' || Loan_Amount_Actual==null || Loan_Amount_Actual =='')?0:Loan_Amount_Actual;
        component.set("v.wrapperData.Loan_Amount_Actual", Loan_Amount_Actual);
        
        var Interest_Rate_Actual = component.get("v.wrapperData.Interest_Rate_Actual");
        Interest_Rate_Actual = (Interest_Rate_Actual=='Undefined' || Interest_Rate_Actual==null || Interest_Rate_Actual =='')?0:Interest_Rate_Actual;
        component.set("v.wrapperData.Interest_Rate_Actual", Interest_Rate_Actual);
        
        var DueIn_Months_Actual = component.get("v.wrapperData.DueIn_Months_Actual");
        DueIn_Months_Actual = (DueIn_Months_Actual=='Undefined' || DueIn_Months_Actual==null || DueIn_Months_Actual =='')?0:DueIn_Months_Actual;
        component.set("v.wrapperData.DueIn_Months_Actual", DueIn_Months_Actual);
        
        var Taxes_O1_CY = component.get("v.wrapperData.Taxes_O1_CY");
        Taxes_O1_CY = (Taxes_O1_CY=='Undefined' || Taxes_O1_CY==null || Taxes_O1_CY =='')?0:Taxes_O1_CY;
        component.set("v.wrapperData.Taxes_O1_CY", Taxes_O1_CY);
		
		var Taxes_O1_CY1 = component.get("v.wrapperData.Taxes_O1_CY1");
        Taxes_O1_CY1 = (Taxes_O1_CY1=='Undefined' || Taxes_O1_CY1==null || Taxes_O1_CY1 =='')?0:Taxes_O1_CY1;
        component.set("v.wrapperData.Taxes_O1_CY1", Taxes_O1_CY1);
		
		var Taxes_O1_CY2 = component.get("v.wrapperData.Taxes_O1_CY2");
        Taxes_O1_CY2 = (Taxes_O1_CY2=='Undefined' || Taxes_O1_CY2==null || Taxes_O1_CY2 =='')?0:Taxes_O1_CY2;
        component.set("v.wrapperData.Taxes_O1_CY2", Taxes_O1_CY2);
		
		var Taxes_O1_CY3 = component.get("v.wrapperData.Taxes_O1_CY3");
        Taxes_O1_CY3 = (Taxes_O1_CY3=='Undefined' || Taxes_O1_CY3==null || Taxes_O1_CY3 =='')?0:Taxes_O1_CY3;
        component.set("v.wrapperData.Taxes_O1_CY3", Taxes_O1_CY3);
		
		var Taxes_O2_CY = component.get("v.wrapperData.Taxes_O2_CY");
        Taxes_O2_CY = (Taxes_O2_CY=='Undefined' || Taxes_O2_CY==null || Taxes_O2_CY =='')?0:Taxes_O2_CY;
        component.set("v.wrapperData.Taxes_O2_CY", Taxes_O2_CY);
		
		var Taxes_O2_CY1 = component.get("v.wrapperData.Taxes_O2_CY1");
        Taxes_O2_CY1 = (Taxes_O2_CY1=='Undefined' || Taxes_O2_CY1==null || Taxes_O2_CY1 =='')?0:Taxes_O2_CY1;
        component.set("v.wrapperData.Taxes_O2_CY1", Taxes_O2_CY1);
		
		var Taxes_O2_CY2 = component.get("v.wrapperData.Taxes_O2_CY2");
        Taxes_O2_CY2 = (Taxes_O2_CY2=='Undefined' || Taxes_O2_CY2==null || Taxes_O2_CY2 =='')?0:Taxes_O2_CY2;
        component.set("v.wrapperData.Taxes_O2_CY2", Taxes_O2_CY2);
		
		var Taxes_O2_CY3 = component.get("v.wrapperData.Taxes_O2_CY3");
        Taxes_O2_CY3 = (Taxes_O2_CY3=='Undefined' || Taxes_O2_CY3==null || Taxes_O2_CY3 =='')?0:Taxes_O2_CY3;
        component.set("v.wrapperData.Taxes_O2_CY3", Taxes_O2_CY3);
		
		var Taxes_O3_CY = component.get("v.wrapperData.Taxes_O3_CY");
        Taxes_O3_CY = (Taxes_O3_CY=='Undefined' || Taxes_O3_CY==null || Taxes_O3_CY =='')?0:Taxes_O3_CY;
        component.set("v.wrapperData.Taxes_O3_CY", Taxes_O3_CY);
		
		var Taxes_O3_CY1 = component.get("v.wrapperData.Taxes_O3_CY1");
        Taxes_O3_CY1 = (Taxes_O3_CY1=='Undefined' || Taxes_O3_CY1==null || Taxes_O3_CY1 =='')?0:Taxes_O3_CY1;
        component.set("v.wrapperData.Taxes_O3_CY1", Taxes_O3_CY1);
		
		var Taxes_O3_CY2 = component.get("v.wrapperData.Taxes_O3_CY2");
        Taxes_O3_CY2 = (Taxes_O3_CY2=='Undefined' || Taxes_O3_CY2==null || Taxes_O3_CY2 =='')?0:Taxes_O3_CY2;
        component.set("v.wrapperData.Taxes_O3_CY2", Taxes_O3_CY2);
		
		var Taxes_O3_CY3 = component.get("v.wrapperData.Taxes_O3_CY3");
        Taxes_O3_CY3 = (Taxes_O3_CY3=='Undefined' || Taxes_O3_CY3==null || Taxes_O3_CY3 =='')?0:Taxes_O3_CY3;
        component.set("v.wrapperData.Taxes_O3_CY3", Taxes_O3_CY3);
		
		var Taxes_O4_CY = component.get("v.wrapperData.Taxes_O4_CY");
        Taxes_O4_CY = (Taxes_O4_CY=='Undefined' || Taxes_O4_CY==null || Taxes_O4_CY =='')?0:Taxes_O4_CY;
        component.set("v.wrapperData.Taxes_O4_CY", Taxes_O4_CY);
		
		var Taxes_O4_CY1 = component.get("v.wrapperData.Taxes_O4_CY1");
        Taxes_O4_CY1 = (Taxes_O4_CY1=='Undefined' || Taxes_O4_CY1==null || Taxes_O4_CY1 =='')?0:Taxes_O4_CY1;
        component.set("v.wrapperData.Taxes_O4_CY1", Taxes_O4_CY1);
		
		var Taxes_O4_CY2 = component.get("v.wrapperData.Taxes_O4_CY2");
        Taxes_O4_CY2 = (Taxes_O4_CY2=='Undefined' || Taxes_O4_CY2==null || Taxes_O4_CY2 =='')?0:Taxes_O4_CY2;
        component.set("v.wrapperData.Taxes_O4_CY2", Taxes_O4_CY2);
		
		var Taxes_O4_CY3 = component.get("v.wrapperData.Taxes_O4_CY3");
        Taxes_O4_CY3 = (Taxes_O4_CY3=='Undefined' || Taxes_O4_CY3==null || Taxes_O4_CY3 =='')?0:Taxes_O4_CY3;
        component.set("v.wrapperData.Taxes_O4_CY3", Taxes_O4_CY3);
        
        var Taxes_O5_CY = component.get("v.wrapperData.Taxes_O5_CY");
        Taxes_O5_CY = (Taxes_O5_CY=='Undefined' || Taxes_O5_CY==null || Taxes_O5_CY =='')?0:Taxes_O5_CY;
        component.set("v.wrapperData.Taxes_O5_CY", Taxes_O5_CY);
		
		var Taxes_O5_CY1 = component.get("v.wrapperData.Taxes_O5_CY1");
        Taxes_O5_CY1 = (Taxes_O5_CY1=='Undefined' || Taxes_O5_CY1==null || Taxes_O5_CY1 =='')?0:Taxes_O5_CY1;
        component.set("v.wrapperData.Taxes_O5_CY1", Taxes_O5_CY1);
		
		var Taxes_O5_CY2 = component.get("v.wrapperData.Taxes_O5_CY2");
        Taxes_O5_CY2 = (Taxes_O5_CY2=='Undefined' || Taxes_O5_CY2==null || Taxes_O5_CY2 =='')?0:Taxes_O5_CY2;
        component.set("v.wrapperData.Taxes_O5_CY2", Taxes_O5_CY2);
		
		var Taxes_O5_CY3 = component.get("v.wrapperData.Taxes_O5_CY3");
        Taxes_O5_CY3 = (Taxes_O5_CY3=='Undefined' || Taxes_O5_CY3==null || Taxes_O5_CY3 =='')?0:Taxes_O5_CY3;
        component.set("v.wrapperData.Taxes_O5_CY3", Taxes_O5_CY3);
        
        var RETaxes_O1_CY = component.get("v.wrapperData.RETaxes_O1_CY");
        RETaxes_O1_CY = (RETaxes_O1_CY=='Undefined' || RETaxes_O1_CY==null || RETaxes_O1_CY =='')?0:RETaxes_O1_CY;
        component.set("v.wrapperData.RETaxes_O1_CY", RETaxes_O1_CY);
		
		var RETaxes_O1_CY1 = component.get("v.wrapperData.RETaxes_O1_CY1");
        RETaxes_O1_CY1 = (RETaxes_O1_CY1=='Undefined' || RETaxes_O1_CY1==null || RETaxes_O1_CY1 =='')?0:RETaxes_O1_CY1;
        component.set("v.wrapperData.RETaxes_O1_CY1", RETaxes_O1_CY1);
		
		var RETaxes_O1_CY2 = component.get("v.wrapperData.RETaxes_O1_CY2");
        RETaxes_O1_CY2 = (RETaxes_O1_CY2=='Undefined' || RETaxes_O1_CY2==null || RETaxes_O1_CY2 =='')?0:RETaxes_O1_CY2;
        component.set("v.wrapperData.RETaxes_O1_CY2", RETaxes_O1_CY2);
		
		var RETaxes_O1_CY3 = component.get("v.wrapperData.RETaxes_O1_CY3");
        RETaxes_O1_CY3 = (RETaxes_O1_CY3=='Undefined' || RETaxes_O1_CY3==null || RETaxes_O1_CY3 =='')?0:RETaxes_O1_CY3;
        component.set("v.wrapperData.RETaxes_O1_CY3", RETaxes_O1_CY3);
		
		var RETaxes_O2_CY = component.get("v.wrapperData.RETaxes_O2_CY");
        RETaxes_O2_CY = (RETaxes_O2_CY=='Undefined' || RETaxes_O2_CY==null || RETaxes_O2_CY =='')?0:RETaxes_O2_CY;
        component.set("v.wrapperData.RETaxes_O2_CY", RETaxes_O2_CY);
		
		var RETaxes_O2_CY1 = component.get("v.wrapperData.RETaxes_O2_CY1");
        RETaxes_O2_CY1 = (RETaxes_O2_CY1=='Undefined' || RETaxes_O2_CY1==null || RETaxes_O2_CY1 =='')?0:RETaxes_O2_CY1;
        component.set("v.wrapperData.RETaxes_O2_CY1", RETaxes_O2_CY1);
		
		var RETaxes_O2_CY2 = component.get("v.wrapperData.RETaxes_O2_CY2");
        RETaxes_O2_CY2 = (RETaxes_O2_CY2=='Undefined' || RETaxes_O2_CY2==null || RETaxes_O2_CY2 =='')?0:RETaxes_O2_CY2;
        component.set("v.wrapperData.RETaxes_O2_CY2", RETaxes_O2_CY2);
		
		var RETaxes_O2_CY3 = component.get("v.wrapperData.RETaxes_O2_CY3");
        RETaxes_O2_CY3 = (RETaxes_O2_CY3=='Undefined' || RETaxes_O2_CY3==null || RETaxes_O2_CY3 =='')?0:RETaxes_O2_CY3;
        component.set("v.wrapperData.RETaxes_O2_CY3", RETaxes_O2_CY3);
		
		var RETaxes_O3_CY = component.get("v.wrapperData.RETaxes_O3_CY");
        RETaxes_O3_CY = (RETaxes_O3_CY=='Undefined' || RETaxes_O3_CY==null || RETaxes_O3_CY =='')?0:RETaxes_O3_CY;
        component.set("v.wrapperData.RETaxes_O3_CY", RETaxes_O3_CY);
		
		var RETaxes_O3_CY1 = component.get("v.wrapperData.RETaxes_O3_CY1");
        RETaxes_O3_CY1 = (RETaxes_O3_CY1=='Undefined' || RETaxes_O3_CY1==null || RETaxes_O3_CY1 =='')?0:RETaxes_O3_CY1;
        component.set("v.wrapperData.RETaxes_O3_CY1", RETaxes_O3_CY1);
		
		var RETaxes_O3_CY2 = component.get("v.wrapperData.RETaxes_O3_CY2");
        RETaxes_O3_CY2 = (RETaxes_O3_CY2=='Undefined' || RETaxes_O3_CY2==null || RETaxes_O3_CY2 =='')?0:RETaxes_O3_CY2;
        component.set("v.wrapperData.RETaxes_O3_CY2", RETaxes_O3_CY2);
		
		var RETaxes_O3_CY3 = component.get("v.wrapperData.RETaxes_O3_CY3");
        RETaxes_O3_CY3 = (RETaxes_O3_CY3=='Undefined' || RETaxes_O3_CY3==null || RETaxes_O3_CY3 =='')?0:RETaxes_O3_CY3;
        component.set("v.wrapperData.RETaxes_O3_CY3", RETaxes_O3_CY3);
		
		var RETaxes_O4_CY = component.get("v.wrapperData.RETaxes_O4_CY");
        RETaxes_O4_CY = (RETaxes_O4_CY=='Undefined' || RETaxes_O4_CY==null || RETaxes_O4_CY =='')?0:RETaxes_O4_CY;
        component.set("v.wrapperData.RETaxes_O4_CY", RETaxes_O4_CY);
		
		var RETaxes_O4_CY1 = component.get("v.wrapperData.RETaxes_O4_CY1");
        RETaxes_O4_CY1 = (RETaxes_O4_CY1=='Undefined' || RETaxes_O4_CY1==null || RETaxes_O4_CY1 =='')?0:RETaxes_O4_CY1;
        component.set("v.wrapperData.RETaxes_O4_CY1", RETaxes_O4_CY1);
		
		var RETaxes_O4_CY2 = component.get("v.wrapperData.RETaxes_O4_CY2");
        RETaxes_O4_CY2 = (RETaxes_O4_CY2=='Undefined' || RETaxes_O4_CY2==null || RETaxes_O4_CY2 =='')?0:RETaxes_O4_CY2;
        component.set("v.wrapperData.RETaxes_O4_CY2", RETaxes_O4_CY2);
		
		var RETaxes_O4_CY3 = component.get("v.wrapperData.RETaxes_O4_CY3");
        RETaxes_O4_CY3 = (RETaxes_O4_CY3=='Undefined' || RETaxes_O4_CY3==null || RETaxes_O4_CY3 =='')?0:RETaxes_O4_CY3;
        component.set("v.wrapperData.RETaxes_O4_CY3", RETaxes_O4_CY3);
        
        var RETaxes_O5_CY = component.get("v.wrapperData.RETaxes_O5_CY");
        RETaxes_O5_CY = (RETaxes_O5_CY=='Undefined' || RETaxes_O5_CY==null || RETaxes_O5_CY =='')?0:RETaxes_O5_CY;
        component.set("v.wrapperData.RETaxes_O5_CY", RETaxes_O5_CY);
		
		var RETaxes_O5_CY1 = component.get("v.wrapperData.RETaxes_O5_CY1");
        RETaxes_O5_CY1 = (RETaxes_O5_CY1=='Undefined' || RETaxes_O5_CY1==null || RETaxes_O5_CY1 =='')?0:RETaxes_O5_CY1;
        component.set("v.wrapperData.RETaxes_O5_CY1", RETaxes_O5_CY1);
		
		var RETaxes_O5_CY2 = component.get("v.wrapperData.RETaxes_O5_CY2");
        RETaxes_O5_CY2 = (RETaxes_O5_CY2=='Undefined' || RETaxes_O5_CY2==null || RETaxes_O5_CY2 =='')?0:RETaxes_O5_CY2;
        component.set("v.wrapperData.RETaxes_O5_CY2", RETaxes_O5_CY2);
		
		var RETaxes_O5_CY3 = component.get("v.wrapperData.RETaxes_O5_CY3");
        RETaxes_O5_CY3 = (RETaxes_O5_CY3=='Undefined' || RETaxes_O5_CY3==null || RETaxes_O5_CY3 =='')?0:RETaxes_O5_CY3;
        component.set("v.wrapperData.RETaxes_O5_CY3", RETaxes_O5_CY3);
        
        // Null Check for all Owner on personal Analysis
        var Salary_Wages_Borrower_O1_CY = component.get("v.wrapperData.Salary_Wages_Borrower_O1_CY");
        Salary_Wages_Borrower_O1_CY = (Salary_Wages_Borrower_O1_CY=='Undefined' || Salary_Wages_Borrower_O1_CY==null || Salary_Wages_Borrower_O1_CY =='')?0:Salary_Wages_Borrower_O1_CY;
        component.set("v.wrapperData.Salary_Wages_Borrower_O1_CY", Salary_Wages_Borrower_O1_CY);
		
		var Salary_Wages_Borrower_O1_CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O1_CY1");
        Salary_Wages_Borrower_O1_CY1 = (Salary_Wages_Borrower_O1_CY1=='Undefined' || Salary_Wages_Borrower_O1_CY1==null || Salary_Wages_Borrower_O1_CY1 =='')?0:Salary_Wages_Borrower_O1_CY1;
        component.set("v.wrapperData.Salary_Wages_Borrower_O1_CY1", Salary_Wages_Borrower_O1_CY1);
		
		var Salary_Wages_Borrower_O1_CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O1_CY2");
        Salary_Wages_Borrower_O1_CY2 = (Salary_Wages_Borrower_O1_CY2=='Undefined' || Salary_Wages_Borrower_O1_CY2==null || Salary_Wages_Borrower_O1_CY2 =='')?0:Salary_Wages_Borrower_O1_CY2;
        component.set("v.wrapperData.Salary_Wages_Borrower_O1_CY2", Salary_Wages_Borrower_O1_CY2);
		
		var Salary_Wages_Borrower_O1_CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O1_CY3");
        Salary_Wages_Borrower_O1_CY3 = (Salary_Wages_Borrower_O1_CY3=='Undefined' || Salary_Wages_Borrower_O1_CY3==null || Salary_Wages_Borrower_O1_CY3 =='')?0:Salary_Wages_Borrower_O1_CY3;
        component.set("v.wrapperData.Salary_Wages_Borrower_O1_CY3", Salary_Wages_Borrower_O1_CY3);
		
		var Salary_Wages_Borrower_O2_CY = component.get("v.wrapperData.Salary_Wages_Borrower_O2_CY");
        Salary_Wages_Borrower_O2_CY = (Salary_Wages_Borrower_O2_CY=='Undefined' || Salary_Wages_Borrower_O2_CY==null || Salary_Wages_Borrower_O2_CY =='')?0:Salary_Wages_Borrower_O2_CY;
        component.set("v.wrapperData.Salary_Wages_Borrower_O2_CY", Salary_Wages_Borrower_O2_CY);
		
		var Salary_Wages_Borrower_O2_CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O2_CY1");
        Salary_Wages_Borrower_O2_CY1 = (Salary_Wages_Borrower_O2_CY1=='Undefined' || Salary_Wages_Borrower_O2_CY1==null || Salary_Wages_Borrower_O2_CY1 =='')?0:Salary_Wages_Borrower_O2_CY1;
        component.set("v.wrapperData.Salary_Wages_Borrower_O2_CY1", Salary_Wages_Borrower_O2_CY1);
		
		var Salary_Wages_Borrower_O2_CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O2_CY2");
        Salary_Wages_Borrower_O2_CY2 = (Salary_Wages_Borrower_O2_CY2=='Undefined' || Salary_Wages_Borrower_O2_CY2==null || Salary_Wages_Borrower_O2_CY2 =='')?0:Salary_Wages_Borrower_O2_CY2;
        component.set("v.wrapperData.Salary_Wages_Borrower_O2_CY2", Salary_Wages_Borrower_O2_CY2);
		
		var Salary_Wages_Borrower_O2_CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O2_CY3");
        Salary_Wages_Borrower_O2_CY3 = (Salary_Wages_Borrower_O2_CY3=='Undefined' || Salary_Wages_Borrower_O2_CY3==null || Salary_Wages_Borrower_O2_CY3 =='')?0:Salary_Wages_Borrower_O2_CY3;
        component.set("v.wrapperData.Salary_Wages_Borrower_O2_CY3", Salary_Wages_Borrower_O2_CY3);
		
		var Salary_Wages_Borrower_O3_CY = component.get("v.wrapperData.Salary_Wages_Borrower_O3_CY");
        Salary_Wages_Borrower_O3_CY = (Salary_Wages_Borrower_O3_CY=='Undefined' || Salary_Wages_Borrower_O3_CY==null || Salary_Wages_Borrower_O3_CY =='')?0:Salary_Wages_Borrower_O3_CY;
        component.set("v.wrapperData.Salary_Wages_Borrower_O3_CY", Salary_Wages_Borrower_O3_CY);
		
		var Salary_Wages_Borrower_O3_CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O3_CY1");
        Salary_Wages_Borrower_O3_CY1 = (Salary_Wages_Borrower_O3_CY1=='Undefined' || Salary_Wages_Borrower_O3_CY1==null || Salary_Wages_Borrower_O3_CY1 =='')?0:Salary_Wages_Borrower_O3_CY1;
        component.set("v.wrapperData.Salary_Wages_Borrower_O3_CY1", Salary_Wages_Borrower_O3_CY1);
		
		var Salary_Wages_Borrower_O3_CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O3_CY2");
        Salary_Wages_Borrower_O3_CY2 = (Salary_Wages_Borrower_O3_CY2=='Undefined' || Salary_Wages_Borrower_O3_CY2==null || Salary_Wages_Borrower_O3_CY2 =='')?0:Salary_Wages_Borrower_O3_CY2;
        component.set("v.wrapperData.Salary_Wages_Borrower_O3_CY2", Salary_Wages_Borrower_O3_CY2);
		
		var Salary_Wages_Borrower_O3_CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O3_CY3");
        Salary_Wages_Borrower_O3_CY3 = (Salary_Wages_Borrower_O3_CY3=='Undefined' || Salary_Wages_Borrower_O3_CY3==null || Salary_Wages_Borrower_O3_CY3 =='')?0:Salary_Wages_Borrower_O3_CY3;
        component.set("v.wrapperData.Salary_Wages_Borrower_O3_CY3", Salary_Wages_Borrower_O3_CY3);
		
		var Salary_Wages_Borrower_O4_CY = component.get("v.wrapperData.Salary_Wages_Borrower_O4_CY");
        Salary_Wages_Borrower_O4_CY = (Salary_Wages_Borrower_O4_CY=='Undefined' || Salary_Wages_Borrower_O4_CY==null || Salary_Wages_Borrower_O4_CY =='')?0:Salary_Wages_Borrower_O4_CY;
        component.set("v.wrapperData.Salary_Wages_Borrower_O4_CY", Salary_Wages_Borrower_O4_CY);
		
		var Salary_Wages_Borrower_O4_CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O4_CY1");
        Salary_Wages_Borrower_O4_CY1 = (Salary_Wages_Borrower_O4_CY1=='Undefined' || Salary_Wages_Borrower_O4_CY1==null || Salary_Wages_Borrower_O4_CY1 =='')?0:Salary_Wages_Borrower_O4_CY1;
        component.set("v.wrapperData.Salary_Wages_Borrower_O4_CY1", Salary_Wages_Borrower_O4_CY1);
		
		var Salary_Wages_Borrower_O4_CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O4_CY2");
        Salary_Wages_Borrower_O4_CY2 = (Salary_Wages_Borrower_O4_CY2=='Undefined' || Salary_Wages_Borrower_O4_CY2==null || Salary_Wages_Borrower_O4_CY2 =='')?0:Salary_Wages_Borrower_O4_CY2;
        component.set("v.wrapperData.Salary_Wages_Borrower_O4_CY2", Salary_Wages_Borrower_O4_CY2);
		
		var Salary_Wages_Borrower_O4_CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O4_CY3");
        Salary_Wages_Borrower_O4_CY3 = (Salary_Wages_Borrower_O4_CY3=='Undefined' || Salary_Wages_Borrower_O4_CY3==null || Salary_Wages_Borrower_O4_CY3 =='')?0:Salary_Wages_Borrower_O4_CY3;
        component.set("v.wrapperData.Salary_Wages_Borrower_O4_CY3", Salary_Wages_Borrower_O4_CY3);
		
		var Salary_Wages_Borrower_O5_CY = component.get("v.wrapperData.Salary_Wages_Borrower_O5_CY");
        Salary_Wages_Borrower_O5_CY = (Salary_Wages_Borrower_O5_CY=='Undefined' || Salary_Wages_Borrower_O5_CY==null || Salary_Wages_Borrower_O5_CY =='')?0:Salary_Wages_Borrower_O5_CY;
        component.set("v.wrapperData.Salary_Wages_Borrower_O5_CY", Salary_Wages_Borrower_O5_CY);
		
		var Salary_Wages_Borrower_O5_CY1 = component.get("v.wrapperData.Salary_Wages_Borrower_O5_CY1");
        Salary_Wages_Borrower_O5_CY1 = (Salary_Wages_Borrower_O5_CY1=='Undefined' || Salary_Wages_Borrower_O5_CY1==null || Salary_Wages_Borrower_O5_CY1 =='')?0:Salary_Wages_Borrower_O5_CY1;
        component.set("v.wrapperData.Salary_Wages_Borrower_O5_CY1", Salary_Wages_Borrower_O5_CY1);
		
		var Salary_Wages_Borrower_O5_CY2 = component.get("v.wrapperData.Salary_Wages_Borrower_O5_CY2");
        Salary_Wages_Borrower_O5_CY2 = (Salary_Wages_Borrower_O5_CY2=='Undefined' || Salary_Wages_Borrower_O5_CY2==null || Salary_Wages_Borrower_O5_CY2 =='')?0:Salary_Wages_Borrower_O5_CY2;
        component.set("v.wrapperData.Salary_Wages_Borrower_O5_CY2", Salary_Wages_Borrower_O5_CY2);
		
		var Salary_Wages_Borrower_O5_CY3 = component.get("v.wrapperData.Salary_Wages_Borrower_O5_CY3");
        Salary_Wages_Borrower_O5_CY3 = (Salary_Wages_Borrower_O5_CY3=='Undefined' || Salary_Wages_Borrower_O5_CY3==null || Salary_Wages_Borrower_O5_CY3 =='')?0:Salary_Wages_Borrower_O5_CY3;
        component.set("v.wrapperData.Salary_Wages_Borrower_O5_CY3", Salary_Wages_Borrower_O5_CY3);
        
        var Salary_Wages_Spouse_O1_CY = component.get("v.wrapperData.Salary_Wages_Spouse_O1_CY");
        Salary_Wages_Spouse_O1_CY = (Salary_Wages_Spouse_O1_CY=='Undefined' || Salary_Wages_Spouse_O1_CY==null || Salary_Wages_Spouse_O1_CY =='')?0:Salary_Wages_Spouse_O1_CY;
        component.set("v.wrapperData.Salary_Wages_Spouse_O1_CY", Salary_Wages_Spouse_O1_CY);
		
		var Salary_Wages_Spouse_O1_CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O1_CY1");
        Salary_Wages_Spouse_O1_CY1 = (Salary_Wages_Spouse_O1_CY1=='Undefined' || Salary_Wages_Spouse_O1_CY1==null || Salary_Wages_Spouse_O1_CY1 =='')?0:Salary_Wages_Spouse_O1_CY1;
        component.set("v.wrapperData.Salary_Wages_Spouse_O1_CY1", Salary_Wages_Spouse_O1_CY1);
		
		var Salary_Wages_Spouse_O1_CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O1_CY2");
        Salary_Wages_Spouse_O1_CY2 = (Salary_Wages_Spouse_O1_CY2=='Undefined' || Salary_Wages_Spouse_O1_CY2==null || Salary_Wages_Spouse_O1_CY2 =='')?0:Salary_Wages_Spouse_O1_CY2;
        component.set("v.wrapperData.Salary_Wages_Spouse_O1_CY2", Salary_Wages_Spouse_O1_CY2);
		
		var Salary_Wages_Spouse_O1_CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O1_CY3");
        Salary_Wages_Spouse_O1_CY3 = (Salary_Wages_Spouse_O1_CY3=='Undefined' || Salary_Wages_Spouse_O1_CY3==null || Salary_Wages_Spouse_O1_CY3 =='')?0:Salary_Wages_Spouse_O1_CY3;
        component.set("v.wrapperData.Salary_Wages_Spouse_O1_CY3", Salary_Wages_Spouse_O1_CY3);
		
		var Salary_Wages_Spouse_O2_CY = component.get("v.wrapperData.Salary_Wages_Spouse_O2_CY");
        Salary_Wages_Spouse_O2_CY = (Salary_Wages_Spouse_O2_CY=='Undefined' || Salary_Wages_Spouse_O2_CY==null || Salary_Wages_Spouse_O2_CY =='')?0:Salary_Wages_Spouse_O2_CY;
        component.set("v.wrapperData.Salary_Wages_Spouse_O2_CY", Salary_Wages_Spouse_O2_CY);
		
		var Salary_Wages_Spouse_O2_CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O2_CY1");
        Salary_Wages_Spouse_O2_CY1 = (Salary_Wages_Spouse_O2_CY1=='Undefined' || Salary_Wages_Spouse_O2_CY1==null || Salary_Wages_Spouse_O2_CY1 =='')?0:Salary_Wages_Spouse_O2_CY1;
        component.set("v.wrapperData.Salary_Wages_Spouse_O2_CY1", Salary_Wages_Spouse_O2_CY1);
		
		var Salary_Wages_Spouse_O2_CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O2_CY2");
        Salary_Wages_Spouse_O2_CY2 = (Salary_Wages_Spouse_O2_CY2=='Undefined' || Salary_Wages_Spouse_O2_CY2==null || Salary_Wages_Spouse_O2_CY2 =='')?0:Salary_Wages_Spouse_O2_CY2;
        component.set("v.wrapperData.Salary_Wages_Spouse_O2_CY2", Salary_Wages_Spouse_O2_CY2);
		
		var Salary_Wages_Spouse_O2_CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O2_CY3");
        Salary_Wages_Spouse_O2_CY3 = (Salary_Wages_Spouse_O2_CY3=='Undefined' || Salary_Wages_Spouse_O2_CY3==null || Salary_Wages_Spouse_O2_CY3 =='')?0:Salary_Wages_Spouse_O2_CY3;
        component.set("v.wrapperData.Salary_Wages_Spouse_O2_CY3", Salary_Wages_Spouse_O2_CY3);
		
		var Salary_Wages_Spouse_O3_CY = component.get("v.wrapperData.Salary_Wages_Spouse_O3_CY");
        Salary_Wages_Spouse_O3_CY = (Salary_Wages_Spouse_O3_CY=='Undefined' || Salary_Wages_Spouse_O3_CY==null || Salary_Wages_Spouse_O3_CY =='')?0:Salary_Wages_Spouse_O3_CY;
        component.set("v.wrapperData.Salary_Wages_Spouse_O3_CY", Salary_Wages_Spouse_O3_CY);
		
		var Salary_Wages_Spouse_O3_CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O3_CY1");
        Salary_Wages_Spouse_O3_CY1 = (Salary_Wages_Spouse_O3_CY1=='Undefined' || Salary_Wages_Spouse_O3_CY1==null || Salary_Wages_Spouse_O3_CY1 =='')?0:Salary_Wages_Spouse_O3_CY1;
        component.set("v.wrapperData.Salary_Wages_Spouse_O3_CY1", Salary_Wages_Spouse_O3_CY1);
		
		var Salary_Wages_Spouse_O3_CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O3_CY2");
        Salary_Wages_Spouse_O3_CY2 = (Salary_Wages_Spouse_O3_CY2=='Undefined' || Salary_Wages_Spouse_O3_CY2==null || Salary_Wages_Spouse_O3_CY2 =='')?0:Salary_Wages_Spouse_O3_CY2;
        component.set("v.wrapperData.Salary_Wages_Spouse_O3_CY2", Salary_Wages_Spouse_O3_CY2);
		
		var Salary_Wages_Spouse_O3_CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O3_CY3");
        Salary_Wages_Spouse_O3_CY3 = (Salary_Wages_Spouse_O3_CY3=='Undefined' || Salary_Wages_Spouse_O3_CY3==null || Salary_Wages_Spouse_O3_CY3 =='')?0:Salary_Wages_Spouse_O3_CY3;
        component.set("v.wrapperData.Salary_Wages_Spouse_O3_CY3", Salary_Wages_Spouse_O3_CY3);
		
		var Salary_Wages_Spouse_O4_CY = component.get("v.wrapperData.Salary_Wages_Spouse_O4_CY");
        Salary_Wages_Spouse_O4_CY = (Salary_Wages_Spouse_O4_CY=='Undefined' || Salary_Wages_Spouse_O4_CY==null || Salary_Wages_Spouse_O4_CY =='')?0:Salary_Wages_Spouse_O4_CY;
        component.set("v.wrapperData.Salary_Wages_Spouse_O4_CY", Salary_Wages_Spouse_O4_CY);
		
		var Salary_Wages_Spouse_O4_CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O4_CY1");
        Salary_Wages_Spouse_O4_CY1 = (Salary_Wages_Spouse_O4_CY1=='Undefined' || Salary_Wages_Spouse_O4_CY1==null || Salary_Wages_Spouse_O4_CY1 =='')?0:Salary_Wages_Spouse_O4_CY1;
        component.set("v.wrapperData.Salary_Wages_Spouse_O4_CY1", Salary_Wages_Spouse_O4_CY1);
		
		var Salary_Wages_Spouse_O4_CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O4_CY2");
        Salary_Wages_Spouse_O4_CY2 = (Salary_Wages_Spouse_O4_CY2=='Undefined' || Salary_Wages_Spouse_O4_CY2==null || Salary_Wages_Spouse_O4_CY2 =='')?0:Salary_Wages_Spouse_O4_CY2;
        component.set("v.wrapperData.Salary_Wages_Spouse_O4_CY2", Salary_Wages_Spouse_O4_CY2);
		
		var Salary_Wages_Spouse_O4_CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O4_CY3");
        Salary_Wages_Spouse_O4_CY3 = (Salary_Wages_Spouse_O4_CY3=='Undefined' || Salary_Wages_Spouse_O4_CY3==null || Salary_Wages_Spouse_O4_CY3 =='')?0:Salary_Wages_Spouse_O4_CY3;
        component.set("v.wrapperData.Salary_Wages_Spouse_O4_CY3", Salary_Wages_Spouse_O4_CY3);
        
        var Salary_Wages_Spouse_O5_CY = component.get("v.wrapperData.Salary_Wages_Spouse_O5_CY");
        Salary_Wages_Spouse_O5_CY = (Salary_Wages_Spouse_O5_CY=='Undefined' || Salary_Wages_Spouse_O5_CY==null || Salary_Wages_Spouse_O5_CY =='')?0:Salary_Wages_Spouse_O5_CY;
        component.set("v.wrapperData.Salary_Wages_Spouse_O5_CY", Salary_Wages_Spouse_O5_CY);
		
		var Salary_Wages_Spouse_O5_CY1 = component.get("v.wrapperData.Salary_Wages_Spouse_O5_CY1");
        Salary_Wages_Spouse_O5_CY1 = (Salary_Wages_Spouse_O5_CY1=='Undefined' || Salary_Wages_Spouse_O5_CY1==null || Salary_Wages_Spouse_O5_CY1 =='')?0:Salary_Wages_Spouse_O5_CY1;
        component.set("v.wrapperData.Salary_Wages_Spouse_O5_CY1", Salary_Wages_Spouse_O5_CY1);
		
		var Salary_Wages_Spouse_O5_CY2 = component.get("v.wrapperData.Salary_Wages_Spouse_O5_CY2");
        Salary_Wages_Spouse_O5_CY2 = (Salary_Wages_Spouse_O5_CY2=='Undefined' || Salary_Wages_Spouse_O5_CY2==null || Salary_Wages_Spouse_O5_CY2 =='')?0:Salary_Wages_Spouse_O5_CY2;
        component.set("v.wrapperData.Salary_Wages_Spouse_O5_CY2", Salary_Wages_Spouse_O5_CY2);
		
		var Salary_Wages_Spouse_O5_CY3 = component.get("v.wrapperData.Salary_Wages_Spouse_O5_CY3");
        Salary_Wages_Spouse_O5_CY3 = (Salary_Wages_Spouse_O5_CY3=='Undefined' || Salary_Wages_Spouse_O5_CY3==null || Salary_Wages_Spouse_O5_CY3 =='')?0:Salary_Wages_Spouse_O5_CY3;
        component.set("v.wrapperData.Salary_Wages_Spouse_O5_CY3", Salary_Wages_Spouse_O5_CY3);
        
        var Other_GuaranteedwagesaffiliatesO1CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY");
        Other_GuaranteedwagesaffiliatesO1CY = (Other_GuaranteedwagesaffiliatesO1CY=='Undefined' || Other_GuaranteedwagesaffiliatesO1CY==null || Other_GuaranteedwagesaffiliatesO1CY =='')?0:Other_GuaranteedwagesaffiliatesO1CY;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY", Other_GuaranteedwagesaffiliatesO1CY);
		
		var Other_GuaranteedwagesaffiliatesO1CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY1");
        Other_GuaranteedwagesaffiliatesO1CY1 = (Other_GuaranteedwagesaffiliatesO1CY1=='Undefined' || Other_GuaranteedwagesaffiliatesO1CY1==null || Other_GuaranteedwagesaffiliatesO1CY1 =='')?0:Other_GuaranteedwagesaffiliatesO1CY1;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY1", Other_GuaranteedwagesaffiliatesO1CY1);
		
		var Other_GuaranteedwagesaffiliatesO1CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY2");
        Other_GuaranteedwagesaffiliatesO1CY2 = (Other_GuaranteedwagesaffiliatesO1CY2=='Undefined' || Other_GuaranteedwagesaffiliatesO1CY2==null || Other_GuaranteedwagesaffiliatesO1CY2 =='')?0:Other_GuaranteedwagesaffiliatesO1CY2;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY2", Other_GuaranteedwagesaffiliatesO1CY2);
		
		var Other_GuaranteedwagesaffiliatesO1CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY3");
        Other_GuaranteedwagesaffiliatesO1CY3 = (Other_GuaranteedwagesaffiliatesO1CY3=='Undefined' || Other_GuaranteedwagesaffiliatesO1CY3==null || Other_GuaranteedwagesaffiliatesO1CY3 =='')?0:Other_GuaranteedwagesaffiliatesO1CY3;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO1CY3", Other_GuaranteedwagesaffiliatesO1CY3);
		
		var Other_GuaranteedwagesaffiliatesO2CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY");
        Other_GuaranteedwagesaffiliatesO2CY = (Other_GuaranteedwagesaffiliatesO2CY=='Undefined' || Other_GuaranteedwagesaffiliatesO2CY==null || Other_GuaranteedwagesaffiliatesO2CY =='')?0:Other_GuaranteedwagesaffiliatesO2CY;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY", Other_GuaranteedwagesaffiliatesO2CY);
		
		var Other_GuaranteedwagesaffiliatesO2CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY1");
        Other_GuaranteedwagesaffiliatesO2CY1 = (Other_GuaranteedwagesaffiliatesO2CY1=='Undefined' || Other_GuaranteedwagesaffiliatesO2CY1==null || Other_GuaranteedwagesaffiliatesO2CY1 =='')?0:Other_GuaranteedwagesaffiliatesO2CY1;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY1", Other_GuaranteedwagesaffiliatesO2CY1);
		
		var Other_GuaranteedwagesaffiliatesO2CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY2");
        Other_GuaranteedwagesaffiliatesO2CY2 = (Other_GuaranteedwagesaffiliatesO2CY2=='Undefined' || Other_GuaranteedwagesaffiliatesO2CY2==null || Other_GuaranteedwagesaffiliatesO2CY2 =='')?0:Other_GuaranteedwagesaffiliatesO2CY2;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY2", Other_GuaranteedwagesaffiliatesO2CY2);
		
		var Other_GuaranteedwagesaffiliatesO2CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY3");
        Other_GuaranteedwagesaffiliatesO2CY3 = (Other_GuaranteedwagesaffiliatesO2CY3=='Undefined' || Other_GuaranteedwagesaffiliatesO2CY3==null || Other_GuaranteedwagesaffiliatesO2CY3 =='')?0:Other_GuaranteedwagesaffiliatesO2CY3;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO2CY3", Other_GuaranteedwagesaffiliatesO2CY3);
		
		var Other_GuaranteedwagesaffiliatesO3CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY");
        Other_GuaranteedwagesaffiliatesO3CY = (Other_GuaranteedwagesaffiliatesO3CY=='Undefined' || Other_GuaranteedwagesaffiliatesO3CY==null || Other_GuaranteedwagesaffiliatesO3CY =='')?0:Other_GuaranteedwagesaffiliatesO3CY;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY", Other_GuaranteedwagesaffiliatesO3CY);
		
		var Other_GuaranteedwagesaffiliatesO3CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY1");
        Other_GuaranteedwagesaffiliatesO3CY1 = (Other_GuaranteedwagesaffiliatesO3CY1=='Undefined' || Other_GuaranteedwagesaffiliatesO3CY1==null || Other_GuaranteedwagesaffiliatesO3CY1 =='')?0:Other_GuaranteedwagesaffiliatesO3CY1;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY1", Other_GuaranteedwagesaffiliatesO3CY1);
		
		var Other_GuaranteedwagesaffiliatesO3CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY2");
        Other_GuaranteedwagesaffiliatesO3CY2 = (Other_GuaranteedwagesaffiliatesO3CY2=='Undefined' || Other_GuaranteedwagesaffiliatesO3CY2==null || Other_GuaranteedwagesaffiliatesO3CY2 =='')?0:Other_GuaranteedwagesaffiliatesO3CY2;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY2", Other_GuaranteedwagesaffiliatesO3CY2);
		
		var Other_GuaranteedwagesaffiliatesO3CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY3");
        Other_GuaranteedwagesaffiliatesO3CY3 = (Other_GuaranteedwagesaffiliatesO3CY3=='Undefined' || Other_GuaranteedwagesaffiliatesO3CY3==null || Other_GuaranteedwagesaffiliatesO3CY3 =='')?0:Other_GuaranteedwagesaffiliatesO3CY3;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO3CY3", Other_GuaranteedwagesaffiliatesO3CY3);
		
		var Other_GuaranteedwagesaffiliatesO4CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY");
        Other_GuaranteedwagesaffiliatesO4CY = (Other_GuaranteedwagesaffiliatesO4CY=='Undefined' || Other_GuaranteedwagesaffiliatesO4CY==null || Other_GuaranteedwagesaffiliatesO4CY =='')?0:Other_GuaranteedwagesaffiliatesO4CY;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY", Other_GuaranteedwagesaffiliatesO4CY);
		
		var Other_GuaranteedwagesaffiliatesO4CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY1");
        Other_GuaranteedwagesaffiliatesO4CY1 = (Other_GuaranteedwagesaffiliatesO4CY1=='Undefined' || Other_GuaranteedwagesaffiliatesO4CY1==null || Other_GuaranteedwagesaffiliatesO4CY1 =='')?0:Other_GuaranteedwagesaffiliatesO4CY1;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY1", Other_GuaranteedwagesaffiliatesO4CY1);
		
		var Other_GuaranteedwagesaffiliatesO4CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY2");
        Other_GuaranteedwagesaffiliatesO4CY2 = (Other_GuaranteedwagesaffiliatesO4CY2=='Undefined' || Other_GuaranteedwagesaffiliatesO4CY2==null || Other_GuaranteedwagesaffiliatesO4CY2 =='')?0:Other_GuaranteedwagesaffiliatesO4CY2;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY2", Other_GuaranteedwagesaffiliatesO4CY2);
		
		var Other_GuaranteedwagesaffiliatesO4CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY3");
        Other_GuaranteedwagesaffiliatesO4CY3 = (Other_GuaranteedwagesaffiliatesO4CY3=='Undefined' || Other_GuaranteedwagesaffiliatesO4CY3==null || Other_GuaranteedwagesaffiliatesO4CY3 =='')?0:Other_GuaranteedwagesaffiliatesO4CY3;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO4CY3", Other_GuaranteedwagesaffiliatesO4CY3);
        
        var Other_GuaranteedwagesaffiliatesO5CY = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY");
        Other_GuaranteedwagesaffiliatesO5CY = (Other_GuaranteedwagesaffiliatesO5CY=='Undefined' || Other_GuaranteedwagesaffiliatesO5CY==null || Other_GuaranteedwagesaffiliatesO5CY =='')?0:Other_GuaranteedwagesaffiliatesO5CY;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY", Other_GuaranteedwagesaffiliatesO5CY);
		
		var Other_GuaranteedwagesaffiliatesO5CY1 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY1");
        Other_GuaranteedwagesaffiliatesO5CY1 = (Other_GuaranteedwagesaffiliatesO5CY1=='Undefined' || Other_GuaranteedwagesaffiliatesO5CY1==null || Other_GuaranteedwagesaffiliatesO5CY1 =='')?0:Other_GuaranteedwagesaffiliatesO5CY1;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY1", Other_GuaranteedwagesaffiliatesO5CY1);
		
		var Other_GuaranteedwagesaffiliatesO5CY2 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY2");
        Other_GuaranteedwagesaffiliatesO5CY2 = (Other_GuaranteedwagesaffiliatesO5CY2=='Undefined' || Other_GuaranteedwagesaffiliatesO5CY2==null || Other_GuaranteedwagesaffiliatesO5CY2 =='')?0:Other_GuaranteedwagesaffiliatesO5CY2;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY2", Other_GuaranteedwagesaffiliatesO5CY2);
		
		var Other_GuaranteedwagesaffiliatesO5CY3 = component.get("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY3");
        Other_GuaranteedwagesaffiliatesO5CY3 = (Other_GuaranteedwagesaffiliatesO5CY3=='Undefined' || Other_GuaranteedwagesaffiliatesO5CY3==null || Other_GuaranteedwagesaffiliatesO5CY3 =='')?0:Other_GuaranteedwagesaffiliatesO5CY3;
        component.set("v.wrapperData.Other_GuaranteedwagesaffiliatesO5CY3", Other_GuaranteedwagesaffiliatesO5CY3);
        
        var Interestdividend_Income_O1_CY = component.get("v.wrapperData.Interestdividend_Income_O1_CY");
        Interestdividend_Income_O1_CY = (Interestdividend_Income_O1_CY=='Undefined' || Interestdividend_Income_O1_CY==null || Interestdividend_Income_O1_CY =='')?0:Interestdividend_Income_O1_CY;
        component.set("v.wrapperData.Interestdividend_Income_O1_CY", Interestdividend_Income_O1_CY);
		
		var Interestdividend_Income_O1_CY1 = component.get("v.wrapperData.Interestdividend_Income_O1_CY1");
        Interestdividend_Income_O1_CY1 = (Interestdividend_Income_O1_CY1=='Undefined' || Interestdividend_Income_O1_CY1==null || Interestdividend_Income_O1_CY1 =='')?0:Interestdividend_Income_O1_CY1;
        component.set("v.wrapperData.Interestdividend_Income_O1_CY1", Interestdividend_Income_O1_CY1);
		
		var Interestdividend_Income_O1_CY2 = component.get("v.wrapperData.Interestdividend_Income_O1_CY2");
        Interestdividend_Income_O1_CY2 = (Interestdividend_Income_O1_CY2=='Undefined' || Interestdividend_Income_O1_CY2==null || Interestdividend_Income_O1_CY2 =='')?0:Interestdividend_Income_O1_CY2;
        component.set("v.wrapperData.Interestdividend_Income_O1_CY2", Interestdividend_Income_O1_CY2);
		
		var Interestdividend_Income_O1_CY3 = component.get("v.wrapperData.Interestdividend_Income_O1_CY3");
        Interestdividend_Income_O1_CY3 = (Interestdividend_Income_O1_CY3=='Undefined' || Interestdividend_Income_O1_CY3==null || Interestdividend_Income_O1_CY3 =='')?0:Interestdividend_Income_O1_CY3;
        component.set("v.wrapperData.Interestdividend_Income_O1_CY3", Interestdividend_Income_O1_CY3);
		
		var Interestdividend_Income_O2_CY = component.get("v.wrapperData.Interestdividend_Income_O2_CY");
        Interestdividend_Income_O2_CY = (Interestdividend_Income_O2_CY=='Undefined' || Interestdividend_Income_O2_CY==null || Interestdividend_Income_O2_CY =='')?0:Interestdividend_Income_O2_CY;
        component.set("v.wrapperData.Interestdividend_Income_O2_CY", Interestdividend_Income_O2_CY);
		
		var Interestdividend_Income_O2_CY1 = component.get("v.wrapperData.Interestdividend_Income_O2_CY1");
        Interestdividend_Income_O2_CY1 = (Interestdividend_Income_O2_CY1=='Undefined' || Interestdividend_Income_O2_CY1==null || Interestdividend_Income_O2_CY1 =='')?0:Interestdividend_Income_O2_CY1;
        component.set("v.wrapperData.Interestdividend_Income_O2_CY1", Interestdividend_Income_O2_CY1);
		
		var Interestdividend_Income_O2_CY2 = component.get("v.wrapperData.Interestdividend_Income_O2_CY2");
        Interestdividend_Income_O2_CY2 = (Interestdividend_Income_O2_CY2=='Undefined' || Interestdividend_Income_O2_CY2==null || Interestdividend_Income_O2_CY2 =='')?0:Interestdividend_Income_O2_CY2;
        component.set("v.wrapperData.Interestdividend_Income_O2_CY2", Interestdividend_Income_O2_CY2);
		
		var Interestdividend_Income_O2_CY3 = component.get("v.wrapperData.Interestdividend_Income_O2_CY3");
        Interestdividend_Income_O2_CY3 = (Interestdividend_Income_O2_CY3=='Undefined' || Interestdividend_Income_O2_CY3==null || Interestdividend_Income_O2_CY3 =='')?0:Interestdividend_Income_O2_CY3;
        component.set("v.wrapperData.Interestdividend_Income_O2_CY3", Interestdividend_Income_O2_CY3);
		
		var Interestdividend_Income_O3_CY = component.get("v.wrapperData.Interestdividend_Income_O3_CY");
        Interestdividend_Income_O3_CY = (Interestdividend_Income_O3_CY=='Undefined' || Interestdividend_Income_O3_CY==null || Interestdividend_Income_O3_CY =='')?0:Interestdividend_Income_O3_CY;
        component.set("v.wrapperData.Interestdividend_Income_O3_CY", Interestdividend_Income_O3_CY);
		
		var Interestdividend_Income_O3_CY1 = component.get("v.wrapperData.Interestdividend_Income_O3_CY1");
        Interestdividend_Income_O3_CY1 = (Interestdividend_Income_O3_CY1=='Undefined' || Interestdividend_Income_O3_CY1==null || Interestdividend_Income_O3_CY1 =='')?0:Interestdividend_Income_O3_CY1;
        component.set("v.wrapperData.Interestdividend_Income_O3_CY1", Interestdividend_Income_O3_CY1);
		
		var Interestdividend_Income_O3_CY2 = component.get("v.wrapperData.Interestdividend_Income_O3_CY2");
        Interestdividend_Income_O3_CY2 = (Interestdividend_Income_O3_CY2=='Undefined' || Interestdividend_Income_O3_CY2==null || Interestdividend_Income_O3_CY2 =='')?0:Interestdividend_Income_O3_CY2;
        component.set("v.wrapperData.Interestdividend_Income_O3_CY2", Interestdividend_Income_O3_CY2);
		
		var Interestdividend_Income_O3_CY3 = component.get("v.wrapperData.Interestdividend_Income_O3_CY3");
        Interestdividend_Income_O3_CY3 = (Interestdividend_Income_O3_CY3=='Undefined' || Interestdividend_Income_O3_CY3==null || Interestdividend_Income_O3_CY3 =='')?0:Interestdividend_Income_O3_CY3;
        component.set("v.wrapperData.Interestdividend_Income_O3_CY3", Interestdividend_Income_O3_CY3);
		
		var Interestdividend_Income_O4_CY = component.get("v.wrapperData.Interestdividend_Income_O4_CY");
        Interestdividend_Income_O4_CY = (Interestdividend_Income_O4_CY=='Undefined' || Interestdividend_Income_O4_CY==null || Interestdividend_Income_O4_CY =='')?0:Interestdividend_Income_O4_CY;
        component.set("v.wrapperData.Interestdividend_Income_O4_CY", Interestdividend_Income_O4_CY);
		
		var Interestdividend_Income_O4_CY1 = component.get("v.wrapperData.Interestdividend_Income_O4_CY1");
        Interestdividend_Income_O4_CY1 = (Interestdividend_Income_O4_CY1=='Undefined' || Interestdividend_Income_O4_CY1==null || Interestdividend_Income_O4_CY1 =='')?0:Interestdividend_Income_O4_CY1;
        component.set("v.wrapperData.Interestdividend_Income_O4_CY1", Interestdividend_Income_O4_CY1);
		
		var Interestdividend_Income_O4_CY2 = component.get("v.wrapperData.Interestdividend_Income_O4_CY2");
        Interestdividend_Income_O4_CY2 = (Interestdividend_Income_O4_CY2=='Undefined' || Interestdividend_Income_O4_CY2==null || Interestdividend_Income_O4_CY2 =='')?0:Interestdividend_Income_O4_CY2;
        component.set("v.wrapperData.Interestdividend_Income_O4_CY2", Interestdividend_Income_O4_CY2);
		
		var Interestdividend_Income_O4_CY3 = component.get("v.wrapperData.Interestdividend_Income_O4_CY3");
        Interestdividend_Income_O4_CY3 = (Interestdividend_Income_O4_CY3=='Undefined' || Interestdividend_Income_O4_CY3==null || Interestdividend_Income_O4_CY3 =='')?0:Interestdividend_Income_O4_CY3;
        component.set("v.wrapperData.Interestdividend_Income_O4_CY3", Interestdividend_Income_O4_CY3);
        
        var Interestdividend_Income_O5_CY = component.get("v.wrapperData.Interestdividend_Income_O5_CY");
        Interestdividend_Income_O5_CY = (Interestdividend_Income_O5_CY=='Undefined' || Interestdividend_Income_O5_CY==null || Interestdividend_Income_O5_CY =='')?0:Interestdividend_Income_O5_CY;
        component.set("v.wrapperData.Interestdividend_Income_O5_CY", Interestdividend_Income_O5_CY);
		
		var Interestdividend_Income_O5_CY1 = component.get("v.wrapperData.Interestdividend_Income_O5_CY1");
        Interestdividend_Income_O5_CY1 = (Interestdividend_Income_O5_CY1=='Undefined' || Interestdividend_Income_O5_CY1==null || Interestdividend_Income_O5_CY1 =='')?0:Interestdividend_Income_O5_CY1;
        component.set("v.wrapperData.Interestdividend_Income_O5_CY1", Interestdividend_Income_O5_CY1);
		
		var Interestdividend_Income_O5_CY2 = component.get("v.wrapperData.Interestdividend_Income_O5_CY2");
        Interestdividend_Income_O5_CY2 = (Interestdividend_Income_O5_CY2=='Undefined' || Interestdividend_Income_O5_CY2==null || Interestdividend_Income_O5_CY2 =='')?0:Interestdividend_Income_O5_CY2;
        component.set("v.wrapperData.Interestdividend_Income_O5_CY2", Interestdividend_Income_O5_CY2);
		
		var Interestdividend_Income_O5_CY3 = component.get("v.wrapperData.Interestdividend_Income_O5_CY3");
        Interestdividend_Income_O5_CY3 = (Interestdividend_Income_O5_CY3=='Undefined' || Interestdividend_Income_O5_CY3==null || Interestdividend_Income_O5_CY3 =='')?0:Interestdividend_Income_O5_CY3;
        component.set("v.wrapperData.Interestdividend_Income_O5_CY3", Interestdividend_Income_O5_CY3);
        
        var Other_Income_O1_CY = component.get("v.wrapperData.Other_Income_O1_CY");
        Other_Income_O1_CY = (Other_Income_O1_CY=='Undefined' || Other_Income_O1_CY==null || Other_Income_O1_CY =='')?0:Other_Income_O1_CY;
        component.set("v.wrapperData.Other_Income_O1_CY", Other_Income_O1_CY);
		
		var Other_Income_O1_CY1 = component.get("v.wrapperData.Other_Income_O1_CY1");
        Other_Income_O1_CY1 = (Other_Income_O1_CY1=='Undefined' || Other_Income_O1_CY1==null || Other_Income_O1_CY1 =='')?0:Other_Income_O1_CY1;
        component.set("v.wrapperData.Other_Income_O1_CY1", Other_Income_O1_CY1);
		
		var Other_Income_O1_CY2 = component.get("v.wrapperData.Other_Income_O1_CY2");
        Other_Income_O1_CY2 = (Other_Income_O1_CY2=='Undefined' || Other_Income_O1_CY2==null || Other_Income_O1_CY2 =='')?0:Other_Income_O1_CY2;
        component.set("v.wrapperData.Other_Income_O1_CY2", Other_Income_O1_CY2);
		
		var Other_Income_O1_CY3 = component.get("v.wrapperData.Other_Income_O1_CY3");
        Other_Income_O1_CY3 = (Other_Income_O1_CY3=='Undefined' || Other_Income_O1_CY3==null || Other_Income_O1_CY3 =='')?0:Other_Income_O1_CY3;
        component.set("v.wrapperData.Other_Income_O1_CY3", Other_Income_O1_CY3);
		
		var Other_Income_O2_CY = component.get("v.wrapperData.Other_Income_O2_CY");
        Other_Income_O2_CY = (Other_Income_O2_CY=='Undefined' || Other_Income_O2_CY==null || Other_Income_O2_CY =='')?0:Other_Income_O2_CY;
        component.set("v.wrapperData.Other_Income_O2_CY", Other_Income_O2_CY);
		
		var Other_Income_O2_CY1 = component.get("v.wrapperData.Other_Income_O2_CY1");
        Other_Income_O2_CY1 = (Other_Income_O2_CY1=='Undefined' || Other_Income_O2_CY1==null || Other_Income_O2_CY1 =='')?0:Other_Income_O2_CY1;
        component.set("v.wrapperData.Other_Income_O2_CY1", Other_Income_O2_CY1);
		
		var Other_Income_O2_CY2 = component.get("v.wrapperData.Other_Income_O2_CY2");
        Other_Income_O2_CY2 = (Other_Income_O2_CY2=='Undefined' || Other_Income_O2_CY2==null || Other_Income_O2_CY2 =='')?0:Other_Income_O2_CY2;
        component.set("v.wrapperData.Other_Income_O2_CY2", Other_Income_O2_CY2);
		
		var Other_Income_O2_CY3 = component.get("v.wrapperData.Other_Income_O2_CY3");
        Other_Income_O2_CY3 = (Other_Income_O2_CY3=='Undefined' || Other_Income_O2_CY3==null || Other_Income_O2_CY3 =='')?0:Other_Income_O2_CY3;
        component.set("v.wrapperData.Other_Income_O2_CY3", Other_Income_O2_CY3);
		
		var Other_Income_O3_CY = component.get("v.wrapperData.Other_Income_O3_CY");
        Other_Income_O3_CY = (Other_Income_O3_CY=='Undefined' || Other_Income_O3_CY==null || Other_Income_O3_CY =='')?0:Other_Income_O3_CY;
        component.set("v.wrapperData.Other_Income_O3_CY", Other_Income_O3_CY);
		
		var Other_Income_O3_CY1 = component.get("v.wrapperData.Other_Income_O3_CY1");
        Other_Income_O3_CY1 = (Other_Income_O3_CY1=='Undefined' || Other_Income_O3_CY1==null || Other_Income_O3_CY1 =='')?0:Other_Income_O3_CY1;
        component.set("v.wrapperData.Other_Income_O3_CY1", Other_Income_O3_CY1);
		
		var Other_Income_O3_CY2 = component.get("v.wrapperData.Other_Income_O3_CY2");
        Other_Income_O3_CY2 = (Other_Income_O3_CY2=='Undefined' || Other_Income_O3_CY2==null || Other_Income_O3_CY2 =='')?0:Other_Income_O3_CY2;
        component.set("v.wrapperData.Other_Income_O3_CY2", Other_Income_O3_CY2);
		
		var Other_Income_O3_CY3 = component.get("v.wrapperData.Other_Income_O3_CY3");
        Other_Income_O3_CY3 = (Other_Income_O3_CY3=='Undefined' || Other_Income_O3_CY3==null || Other_Income_O3_CY3 =='')?0:Other_Income_O3_CY3;
        component.set("v.wrapperData.Other_Income_O3_CY3", Other_Income_O3_CY3);
		
		var Other_Income_O4_CY = component.get("v.wrapperData.Other_Income_O4_CY");
        Other_Income_O4_CY = (Other_Income_O4_CY=='Undefined' || Other_Income_O4_CY==null || Other_Income_O4_CY =='')?0:Other_Income_O4_CY;
        component.set("v.wrapperData.Other_Income_O4_CY", Other_Income_O4_CY);
		
		var Other_Income_O4_CY1 = component.get("v.wrapperData.Other_Income_O4_CY1");
        Other_Income_O4_CY1 = (Other_Income_O4_CY1=='Undefined' || Other_Income_O4_CY1==null || Other_Income_O4_CY1 =='')?0:Other_Income_O4_CY1;
        component.set("v.wrapperData.Other_Income_O4_CY1", Other_Income_O4_CY1);
		
		var Other_Income_O4_CY2 = component.get("v.wrapperData.Other_Income_O4_CY2");
        Other_Income_O4_CY2 = (Other_Income_O4_CY2=='Undefined' || Other_Income_O4_CY2==null || Other_Income_O4_CY2 =='')?0:Other_Income_O4_CY2;
        component.set("v.wrapperData.Other_Income_O4_CY2", Other_Income_O4_CY2);
		
		var Other_Income_O4_CY3 = component.get("v.wrapperData.Other_Income_O4_CY3");
        Other_Income_O4_CY3 = (Other_Income_O4_CY3=='Undefined' || Other_Income_O4_CY3==null || Other_Income_O4_CY3 =='')?0:Other_Income_O4_CY3;
        component.set("v.wrapperData.Other_Income_O4_CY3", Other_Income_O4_CY3);
        
        var Other_Income_O5_CY = component.get("v.wrapperData.Other_Income_O5_CY");
        Other_Income_O5_CY = (Other_Income_O5_CY=='Undefined' || Other_Income_O5_CY==null || Other_Income_O5_CY =='')?0:Other_Income_O5_CY;
        component.set("v.wrapperData.Other_Income_O5_CY", Other_Income_O5_CY);
		
		var Other_Income_O5_CY1 = component.get("v.wrapperData.Other_Income_O5_CY1");
        Other_Income_O5_CY1 = (Other_Income_O5_CY1=='Undefined' || Other_Income_O5_CY1==null || Other_Income_O5_CY1 =='')?0:Other_Income_O5_CY1;
        component.set("v.wrapperData.Other_Income_O5_CY1", Other_Income_O5_CY1);
		
		var Other_Income_O5_CY2 = component.get("v.wrapperData.Other_Income_O5_CY2");
        Other_Income_O5_CY2 = (Other_Income_O5_CY2=='Undefined' || Other_Income_O5_CY2==null || Other_Income_O5_CY2 =='')?0:Other_Income_O5_CY2;
        component.set("v.wrapperData.Other_Income_O5_CY2", Other_Income_O5_CY2);
		
		var Other_Income_O5_CY3 = component.get("v.wrapperData.Other_Income_O5_CY3");
        Other_Income_O5_CY3 = (Other_Income_O5_CY3=='Undefined' || Other_Income_O5_CY3==null || Other_Income_O5_CY3 =='')?0:Other_Income_O5_CY3;
        component.set("v.wrapperData.Other_Income_O5_CY3", Other_Income_O5_CY3);
        
        var PensionIRA_Distributions_O1_CY = component.get("v.wrapperData.PensionIRA_Distributions_O1_CY");
        PensionIRA_Distributions_O1_CY = (PensionIRA_Distributions_O1_CY=='Undefined' || PensionIRA_Distributions_O1_CY==null || PensionIRA_Distributions_O1_CY =='')?0:PensionIRA_Distributions_O1_CY;
        component.set("v.wrapperData.PensionIRA_Distributions_O1_CY", PensionIRA_Distributions_O1_CY);
		
		var PensionIRA_Distributions_O1_CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O1_CY1");
        PensionIRA_Distributions_O1_CY1 = (PensionIRA_Distributions_O1_CY1=='Undefined' || PensionIRA_Distributions_O1_CY1==null || PensionIRA_Distributions_O1_CY1 =='')?0:PensionIRA_Distributions_O1_CY1;
        component.set("v.wrapperData.PensionIRA_Distributions_O1_CY1", PensionIRA_Distributions_O1_CY1);
		
		var PensionIRA_Distributions_O1_CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O1_CY2");
        PensionIRA_Distributions_O1_CY2 = (PensionIRA_Distributions_O1_CY2=='Undefined' || PensionIRA_Distributions_O1_CY2==null || PensionIRA_Distributions_O1_CY2 =='')?0:PensionIRA_Distributions_O1_CY2;
        component.set("v.wrapperData.PensionIRA_Distributions_O1_CY2", PensionIRA_Distributions_O1_CY2);
		
		var PensionIRA_Distributions_O1_CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O1_CY3");
        PensionIRA_Distributions_O1_CY3 = (PensionIRA_Distributions_O1_CY3=='Undefined' || PensionIRA_Distributions_O1_CY3==null || PensionIRA_Distributions_O1_CY3 =='')?0:PensionIRA_Distributions_O1_CY3;
        component.set("v.wrapperData.PensionIRA_Distributions_O1_CY3", PensionIRA_Distributions_O1_CY3);
		
		var PensionIRA_Distributions_O2_CY = component.get("v.wrapperData.PensionIRA_Distributions_O2_CY");
        PensionIRA_Distributions_O2_CY = (PensionIRA_Distributions_O2_CY=='Undefined' || PensionIRA_Distributions_O2_CY==null || PensionIRA_Distributions_O2_CY =='')?0:PensionIRA_Distributions_O2_CY;
        component.set("v.wrapperData.PensionIRA_Distributions_O2_CY", PensionIRA_Distributions_O2_CY);
		
		var PensionIRA_Distributions_O2_CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O2_CY1");
        PensionIRA_Distributions_O2_CY1 = (PensionIRA_Distributions_O2_CY1=='Undefined' || PensionIRA_Distributions_O2_CY1==null || PensionIRA_Distributions_O2_CY1 =='')?0:PensionIRA_Distributions_O2_CY1;
        component.set("v.wrapperData.PensionIRA_Distributions_O2_CY1", PensionIRA_Distributions_O2_CY1);
		
		var PensionIRA_Distributions_O2_CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O2_CY2");
        PensionIRA_Distributions_O2_CY2 = (PensionIRA_Distributions_O2_CY2=='Undefined' || PensionIRA_Distributions_O2_CY2==null || PensionIRA_Distributions_O2_CY2 =='')?0:PensionIRA_Distributions_O2_CY2;
        component.set("v.wrapperData.PensionIRA_Distributions_O2_CY2", PensionIRA_Distributions_O2_CY2);
		
		var PensionIRA_Distributions_O2_CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O2_CY3");
        PensionIRA_Distributions_O2_CY3 = (PensionIRA_Distributions_O2_CY3=='Undefined' || PensionIRA_Distributions_O2_CY3==null || PensionIRA_Distributions_O2_CY3 =='')?0:PensionIRA_Distributions_O2_CY3;
        component.set("v.wrapperData.PensionIRA_Distributions_O2_CY3", PensionIRA_Distributions_O2_CY3);
		
		var PensionIRA_Distributions_O3_CY = component.get("v.wrapperData.PensionIRA_Distributions_O3_CY");
        PensionIRA_Distributions_O3_CY = (PensionIRA_Distributions_O3_CY=='Undefined' || PensionIRA_Distributions_O3_CY==null || PensionIRA_Distributions_O3_CY =='')?0:PensionIRA_Distributions_O3_CY;
        component.set("v.wrapperData.PensionIRA_Distributions_O3_CY", PensionIRA_Distributions_O3_CY);
		
		var PensionIRA_Distributions_O3_CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O3_CY1");
        PensionIRA_Distributions_O3_CY1 = (PensionIRA_Distributions_O3_CY1=='Undefined' || PensionIRA_Distributions_O3_CY1==null || PensionIRA_Distributions_O3_CY1 =='')?0:PensionIRA_Distributions_O3_CY1;
        component.set("v.wrapperData.PensionIRA_Distributions_O3_CY1", PensionIRA_Distributions_O3_CY1);
		
		var PensionIRA_Distributions_O3_CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O3_CY2");
        PensionIRA_Distributions_O3_CY2 = (PensionIRA_Distributions_O3_CY2=='Undefined' || PensionIRA_Distributions_O3_CY2==null || PensionIRA_Distributions_O3_CY2 =='')?0:PensionIRA_Distributions_O3_CY2;
        component.set("v.wrapperData.PensionIRA_Distributions_O3_CY2", PensionIRA_Distributions_O3_CY2);
		
		var PensionIRA_Distributions_O3_CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O3_CY3");
        PensionIRA_Distributions_O3_CY3 = (PensionIRA_Distributions_O3_CY3=='Undefined' || PensionIRA_Distributions_O3_CY3==null || PensionIRA_Distributions_O3_CY3 =='')?0:PensionIRA_Distributions_O3_CY3;
        component.set("v.wrapperData.PensionIRA_Distributions_O3_CY3", PensionIRA_Distributions_O3_CY3);
		
		var PensionIRA_Distributions_O4_CY = component.get("v.wrapperData.PensionIRA_Distributions_O4_CY");
        PensionIRA_Distributions_O4_CY = (PensionIRA_Distributions_O4_CY=='Undefined' || PensionIRA_Distributions_O4_CY==null || PensionIRA_Distributions_O4_CY =='')?0:PensionIRA_Distributions_O4_CY;
        component.set("v.wrapperData.PensionIRA_Distributions_O4_CY", PensionIRA_Distributions_O4_CY);
		
		var PensionIRA_Distributions_O4_CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O4_CY1");
        PensionIRA_Distributions_O4_CY1 = (PensionIRA_Distributions_O4_CY1=='Undefined' || PensionIRA_Distributions_O4_CY1==null || PensionIRA_Distributions_O4_CY1 =='')?0:PensionIRA_Distributions_O4_CY1;
        component.set("v.wrapperData.PensionIRA_Distributions_O4_CY1", PensionIRA_Distributions_O4_CY1);
		
		var PensionIRA_Distributions_O4_CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O4_CY2");
        PensionIRA_Distributions_O4_CY2 = (PensionIRA_Distributions_O4_CY2=='Undefined' || PensionIRA_Distributions_O4_CY2==null || PensionIRA_Distributions_O4_CY2 =='')?0:PensionIRA_Distributions_O4_CY2;
        component.set("v.wrapperData.PensionIRA_Distributions_O4_CY2", PensionIRA_Distributions_O4_CY2);
		
		var PensionIRA_Distributions_O4_CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O4_CY3");
        PensionIRA_Distributions_O4_CY3 = (PensionIRA_Distributions_O4_CY3=='Undefined' || PensionIRA_Distributions_O4_CY3==null || PensionIRA_Distributions_O4_CY3 =='')?0:PensionIRA_Distributions_O4_CY3;
        component.set("v.wrapperData.PensionIRA_Distributions_O4_CY3", PensionIRA_Distributions_O4_CY3);
        
        var PensionIRA_Distributions_O5_CY = component.get("v.wrapperData.PensionIRA_Distributions_O5_CY");
        PensionIRA_Distributions_O5_CY = (PensionIRA_Distributions_O5_CY=='Undefined' || PensionIRA_Distributions_O5_CY==null || PensionIRA_Distributions_O5_CY =='')?0:PensionIRA_Distributions_O5_CY;
        component.set("v.wrapperData.PensionIRA_Distributions_O5_CY", PensionIRA_Distributions_O5_CY);
		
		var PensionIRA_Distributions_O5_CY1 = component.get("v.wrapperData.PensionIRA_Distributions_O5_CY1");
        PensionIRA_Distributions_O5_CY1 = (PensionIRA_Distributions_O5_CY1=='Undefined' || PensionIRA_Distributions_O5_CY1==null || PensionIRA_Distributions_O5_CY1 =='')?0:PensionIRA_Distributions_O5_CY1;
        component.set("v.wrapperData.PensionIRA_Distributions_O5_CY1", PensionIRA_Distributions_O5_CY1);
		
		var PensionIRA_Distributions_O5_CY2 = component.get("v.wrapperData.PensionIRA_Distributions_O5_CY2");
        PensionIRA_Distributions_O5_CY2 = (PensionIRA_Distributions_O5_CY2=='Undefined' || PensionIRA_Distributions_O5_CY2==null || PensionIRA_Distributions_O5_CY2 =='')?0:PensionIRA_Distributions_O5_CY2;
        component.set("v.wrapperData.PensionIRA_Distributions_O5_CY2", PensionIRA_Distributions_O5_CY2);
		
		var PensionIRA_Distributions_O5_CY3 = component.get("v.wrapperData.PensionIRA_Distributions_O5_CY3");
        PensionIRA_Distributions_O5_CY3 = (PensionIRA_Distributions_O5_CY3=='Undefined' || PensionIRA_Distributions_O5_CY3==null || PensionIRA_Distributions_O5_CY3 =='')?0:PensionIRA_Distributions_O5_CY3;
        component.set("v.wrapperData.PensionIRA_Distributions_O5_CY3", PensionIRA_Distributions_O5_CY3);
        
        var Sch_D_Capital_gainslosses_O1_CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY");
        Sch_D_Capital_gainslosses_O1_CY = (Sch_D_Capital_gainslosses_O1_CY=='Undefined' || Sch_D_Capital_gainslosses_O1_CY==null || Sch_D_Capital_gainslosses_O1_CY =='')?0:Sch_D_Capital_gainslosses_O1_CY;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY", Sch_D_Capital_gainslosses_O1_CY);
		
		var Sch_D_Capital_gainslosses_O1_CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY1");
        Sch_D_Capital_gainslosses_O1_CY1 = (Sch_D_Capital_gainslosses_O1_CY1=='Undefined' || Sch_D_Capital_gainslosses_O1_CY1==null || Sch_D_Capital_gainslosses_O1_CY1 =='')?0:Sch_D_Capital_gainslosses_O1_CY1;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY1", Sch_D_Capital_gainslosses_O1_CY1);
		
		var Sch_D_Capital_gainslosses_O1_CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY2");
        Sch_D_Capital_gainslosses_O1_CY2 = (Sch_D_Capital_gainslosses_O1_CY2=='Undefined' || Sch_D_Capital_gainslosses_O1_CY2==null || Sch_D_Capital_gainslosses_O1_CY2 =='')?0:Sch_D_Capital_gainslosses_O1_CY2;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY2", Sch_D_Capital_gainslosses_O1_CY2);
		
		var Sch_D_Capital_gainslosses_O1_CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY3");
        Sch_D_Capital_gainslosses_O1_CY3 = (Sch_D_Capital_gainslosses_O1_CY3=='Undefined' || Sch_D_Capital_gainslosses_O1_CY3==null || Sch_D_Capital_gainslosses_O1_CY3 =='')?0:Sch_D_Capital_gainslosses_O1_CY3;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O1_CY3", Sch_D_Capital_gainslosses_O1_CY3);
		
		var Sch_D_Capital_gainslosses_O2_CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY");
        Sch_D_Capital_gainslosses_O2_CY = (Sch_D_Capital_gainslosses_O2_CY=='Undefined' || Sch_D_Capital_gainslosses_O2_CY==null || Sch_D_Capital_gainslosses_O2_CY =='')?0:Sch_D_Capital_gainslosses_O2_CY;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY", Sch_D_Capital_gainslosses_O2_CY);
		
		var Sch_D_Capital_gainslosses_O2_CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY1");
        Sch_D_Capital_gainslosses_O2_CY1 = (Sch_D_Capital_gainslosses_O2_CY1=='Undefined' || Sch_D_Capital_gainslosses_O2_CY1==null || Sch_D_Capital_gainslosses_O2_CY1 =='')?0:Sch_D_Capital_gainslosses_O2_CY1;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY1", Sch_D_Capital_gainslosses_O2_CY1);
		
		var Sch_D_Capital_gainslosses_O2_CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY2");
        Sch_D_Capital_gainslosses_O2_CY2 = (Sch_D_Capital_gainslosses_O2_CY2=='Undefined' || Sch_D_Capital_gainslosses_O2_CY2==null || Sch_D_Capital_gainslosses_O2_CY2 =='')?0:Sch_D_Capital_gainslosses_O2_CY2;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY2", Sch_D_Capital_gainslosses_O2_CY2);
		
		var Sch_D_Capital_gainslosses_O2_CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY3");
        Sch_D_Capital_gainslosses_O2_CY3 = (Sch_D_Capital_gainslosses_O2_CY3=='Undefined' || Sch_D_Capital_gainslosses_O2_CY3==null || Sch_D_Capital_gainslosses_O2_CY3 =='')?0:Sch_D_Capital_gainslosses_O2_CY3;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O2_CY3", Sch_D_Capital_gainslosses_O2_CY3);
		
		var Sch_D_Capital_gainslosses_O3_CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY");
        Sch_D_Capital_gainslosses_O3_CY = (Sch_D_Capital_gainslosses_O3_CY=='Undefined' || Sch_D_Capital_gainslosses_O3_CY==null || Sch_D_Capital_gainslosses_O3_CY =='')?0:Sch_D_Capital_gainslosses_O3_CY;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY", Sch_D_Capital_gainslosses_O3_CY);
		
		var Sch_D_Capital_gainslosses_O3_CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY1");
        Sch_D_Capital_gainslosses_O3_CY1 = (Sch_D_Capital_gainslosses_O3_CY1=='Undefined' || Sch_D_Capital_gainslosses_O3_CY1==null || Sch_D_Capital_gainslosses_O3_CY1 =='')?0:Sch_D_Capital_gainslosses_O3_CY1;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY1", Sch_D_Capital_gainslosses_O3_CY1);
		
		var Sch_D_Capital_gainslosses_O3_CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY2");
        Sch_D_Capital_gainslosses_O3_CY2 = (Sch_D_Capital_gainslosses_O3_CY2=='Undefined' || Sch_D_Capital_gainslosses_O3_CY2==null || Sch_D_Capital_gainslosses_O3_CY2 =='')?0:Sch_D_Capital_gainslosses_O3_CY2;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY2", Sch_D_Capital_gainslosses_O3_CY2);
		
		var Sch_D_Capital_gainslosses_O3_CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY3");
        Sch_D_Capital_gainslosses_O3_CY3 = (Sch_D_Capital_gainslosses_O3_CY3=='Undefined' || Sch_D_Capital_gainslosses_O3_CY3==null || Sch_D_Capital_gainslosses_O3_CY3 =='')?0:Sch_D_Capital_gainslosses_O3_CY3;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O3_CY3", Sch_D_Capital_gainslosses_O3_CY3);
		
		var Sch_D_Capital_gainslosses_O4_CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY");
        Sch_D_Capital_gainslosses_O4_CY = (Sch_D_Capital_gainslosses_O4_CY=='Undefined' || Sch_D_Capital_gainslosses_O4_CY==null || Sch_D_Capital_gainslosses_O4_CY =='')?0:Sch_D_Capital_gainslosses_O4_CY;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY", Sch_D_Capital_gainslosses_O4_CY);
		
		var Sch_D_Capital_gainslosses_O4_CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY1");
        Sch_D_Capital_gainslosses_O4_CY1 = (Sch_D_Capital_gainslosses_O4_CY1=='Undefined' || Sch_D_Capital_gainslosses_O4_CY1==null || Sch_D_Capital_gainslosses_O4_CY1 =='')?0:Sch_D_Capital_gainslosses_O4_CY1;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY1", Sch_D_Capital_gainslosses_O4_CY1);
		
		var Sch_D_Capital_gainslosses_O4_CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY2");
        Sch_D_Capital_gainslosses_O4_CY2 = (Sch_D_Capital_gainslosses_O4_CY2=='Undefined' || Sch_D_Capital_gainslosses_O4_CY2==null || Sch_D_Capital_gainslosses_O4_CY2 =='')?0:Sch_D_Capital_gainslosses_O4_CY2;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY2", Sch_D_Capital_gainslosses_O4_CY2);
		
		var Sch_D_Capital_gainslosses_O4_CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY3");
        Sch_D_Capital_gainslosses_O4_CY3 = (Sch_D_Capital_gainslosses_O4_CY3=='Undefined' || Sch_D_Capital_gainslosses_O4_CY3==null || Sch_D_Capital_gainslosses_O4_CY3 =='')?0:Sch_D_Capital_gainslosses_O4_CY3;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O4_CY3", Sch_D_Capital_gainslosses_O4_CY3);
        
        var Sch_D_Capital_gainslosses_O5_CY = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY");
        Sch_D_Capital_gainslosses_O5_CY = (Sch_D_Capital_gainslosses_O5_CY=='Undefined' || Sch_D_Capital_gainslosses_O5_CY==null || Sch_D_Capital_gainslosses_O5_CY =='')?0:Sch_D_Capital_gainslosses_O5_CY;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY", Sch_D_Capital_gainslosses_O5_CY);
		
		var Sch_D_Capital_gainslosses_O5_CY1 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY1");
        Sch_D_Capital_gainslosses_O5_CY1 = (Sch_D_Capital_gainslosses_O5_CY1=='Undefined' || Sch_D_Capital_gainslosses_O5_CY1==null || Sch_D_Capital_gainslosses_O5_CY1 =='')?0:Sch_D_Capital_gainslosses_O5_CY1;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY1", Sch_D_Capital_gainslosses_O5_CY1);
		
		var Sch_D_Capital_gainslosses_O5_CY2 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY2");
        Sch_D_Capital_gainslosses_O5_CY2 = (Sch_D_Capital_gainslosses_O5_CY2=='Undefined' || Sch_D_Capital_gainslosses_O5_CY2==null || Sch_D_Capital_gainslosses_O5_CY2 =='')?0:Sch_D_Capital_gainslosses_O5_CY2;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY2", Sch_D_Capital_gainslosses_O5_CY2);
		
		var Sch_D_Capital_gainslosses_O5_CY3 = component.get("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY3");
        Sch_D_Capital_gainslosses_O5_CY3 = (Sch_D_Capital_gainslosses_O5_CY3=='Undefined' || Sch_D_Capital_gainslosses_O5_CY3==null || Sch_D_Capital_gainslosses_O5_CY3 =='')?0:Sch_D_Capital_gainslosses_O5_CY3;
        component.set("v.wrapperData.Sch_D_Capital_gainslosses_O5_CY3", Sch_D_Capital_gainslosses_O5_CY3);
        
        var Schedule_C_Income_O1_CY = component.get("v.wrapperData.Schedule_C_Income_O1_CY");
        Schedule_C_Income_O1_CY = (Schedule_C_Income_O1_CY=='Undefined' || Schedule_C_Income_O1_CY==null || Schedule_C_Income_O1_CY =='')?0:Schedule_C_Income_O1_CY;
        component.set("v.wrapperData.Schedule_C_Income_O1_CY", Schedule_C_Income_O1_CY);
		
		var Schedule_C_Income_O1_CY1 = component.get("v.wrapperData.Schedule_C_Income_O1_CY1");
        Schedule_C_Income_O1_CY1 = (Schedule_C_Income_O1_CY1=='Undefined' || Schedule_C_Income_O1_CY1==null || Schedule_C_Income_O1_CY1 =='')?0:Schedule_C_Income_O1_CY1;
        component.set("v.wrapperData.Schedule_C_Income_O1_CY1", Schedule_C_Income_O1_CY1);
		
		var Schedule_C_Income_O1_CY2 = component.get("v.wrapperData.Schedule_C_Income_O1_CY2");
        Schedule_C_Income_O1_CY2 = (Schedule_C_Income_O1_CY2=='Undefined' || Schedule_C_Income_O1_CY2==null || Schedule_C_Income_O1_CY2 =='')?0:Schedule_C_Income_O1_CY2;
        component.set("v.wrapperData.Schedule_C_Income_O1_CY2", Schedule_C_Income_O1_CY2);
		
		var Schedule_C_Income_O1_CY3 = component.get("v.wrapperData.Schedule_C_Income_O1_CY3");
        Schedule_C_Income_O1_CY3 = (Schedule_C_Income_O1_CY3=='Undefined' || Schedule_C_Income_O1_CY3==null || Schedule_C_Income_O1_CY3 =='')?0:Schedule_C_Income_O1_CY3;
        component.set("v.wrapperData.Schedule_C_Income_O1_CY3", Schedule_C_Income_O1_CY3);
		
		var Schedule_C_Income_O2_CY = component.get("v.wrapperData.Schedule_C_Income_O2_CY");
        Schedule_C_Income_O2_CY = (Schedule_C_Income_O2_CY=='Undefined' || Schedule_C_Income_O2_CY==null || Schedule_C_Income_O2_CY =='')?0:Schedule_C_Income_O2_CY;
        component.set("v.wrapperData.Schedule_C_Income_O2_CY", Schedule_C_Income_O2_CY);
		
		var Schedule_C_Income_O2_CY1 = component.get("v.wrapperData.Schedule_C_Income_O2_CY1");
        Schedule_C_Income_O2_CY1 = (Schedule_C_Income_O2_CY1=='Undefined' || Schedule_C_Income_O2_CY1==null || Schedule_C_Income_O2_CY1 =='')?0:Schedule_C_Income_O2_CY1;
        component.set("v.wrapperData.Schedule_C_Income_O2_CY1", Schedule_C_Income_O2_CY1);
		
		var Schedule_C_Income_O2_CY2 = component.get("v.wrapperData.Schedule_C_Income_O2_CY2");
        Schedule_C_Income_O2_CY2 = (Schedule_C_Income_O2_CY2=='Undefined' || Schedule_C_Income_O2_CY2==null || Schedule_C_Income_O2_CY2 =='')?0:Schedule_C_Income_O2_CY2;
        component.set("v.wrapperData.Schedule_C_Income_O2_CY2", Schedule_C_Income_O2_CY2);
		
		var Schedule_C_Income_O2_CY3 = component.get("v.wrapperData.Schedule_C_Income_O2_CY3");
        Schedule_C_Income_O2_CY3 = (Schedule_C_Income_O2_CY3=='Undefined' || Schedule_C_Income_O2_CY3==null || Schedule_C_Income_O2_CY3 =='')?0:Schedule_C_Income_O2_CY3;
        component.set("v.wrapperData.Schedule_C_Income_O2_CY3", Schedule_C_Income_O2_CY3);
		
		var Schedule_C_Income_O3_CY = component.get("v.wrapperData.Schedule_C_Income_O3_CY");
        Schedule_C_Income_O3_CY = (Schedule_C_Income_O3_CY=='Undefined' || Schedule_C_Income_O3_CY==null || Schedule_C_Income_O3_CY =='')?0:Schedule_C_Income_O3_CY;
        component.set("v.wrapperData.Schedule_C_Income_O3_CY", Schedule_C_Income_O3_CY);
		
		var Schedule_C_Income_O3_CY1 = component.get("v.wrapperData.Schedule_C_Income_O3_CY1");
        Schedule_C_Income_O3_CY1 = (Schedule_C_Income_O3_CY1=='Undefined' || Schedule_C_Income_O3_CY1==null || Schedule_C_Income_O3_CY1 =='')?0:Schedule_C_Income_O3_CY1;
        component.set("v.wrapperData.Schedule_C_Income_O3_CY1", Schedule_C_Income_O3_CY1);
		
		var Schedule_C_Income_O3_CY2 = component.get("v.wrapperData.Schedule_C_Income_O3_CY2");
        Schedule_C_Income_O3_CY2 = (Schedule_C_Income_O3_CY2=='Undefined' || Schedule_C_Income_O3_CY2==null || Schedule_C_Income_O3_CY2 =='')?0:Schedule_C_Income_O3_CY2;
        component.set("v.wrapperData.Schedule_C_Income_O3_CY2", Schedule_C_Income_O3_CY2);
		
		var Schedule_C_Income_O3_CY3 = component.get("v.wrapperData.Schedule_C_Income_O3_CY3");
        Schedule_C_Income_O3_CY3 = (Schedule_C_Income_O3_CY3=='Undefined' || Schedule_C_Income_O3_CY3==null || Schedule_C_Income_O3_CY3 =='')?0:Schedule_C_Income_O3_CY3;
        component.set("v.wrapperData.Schedule_C_Income_O3_CY3", Schedule_C_Income_O3_CY3);
		
		var Schedule_C_Income_O4_CY = component.get("v.wrapperData.Schedule_C_Income_O4_CY");
        Schedule_C_Income_O4_CY = (Schedule_C_Income_O4_CY=='Undefined' || Schedule_C_Income_O4_CY==null || Schedule_C_Income_O4_CY =='')?0:Schedule_C_Income_O4_CY;
        component.set("v.wrapperData.Schedule_C_Income_O4_CY", Schedule_C_Income_O4_CY);
		
		var Schedule_C_Income_O4_CY1 = component.get("v.wrapperData.Schedule_C_Income_O4_CY1");
        Schedule_C_Income_O4_CY1 = (Schedule_C_Income_O4_CY1=='Undefined' || Schedule_C_Income_O4_CY1==null || Schedule_C_Income_O4_CY1 =='')?0:Schedule_C_Income_O4_CY1;
        component.set("v.wrapperData.Schedule_C_Income_O4_CY1", Schedule_C_Income_O4_CY1);
		
		var Schedule_C_Income_O4_CY2 = component.get("v.wrapperData.Schedule_C_Income_O4_CY2");
        Schedule_C_Income_O4_CY2 = (Schedule_C_Income_O4_CY2=='Undefined' || Schedule_C_Income_O4_CY2==null || Schedule_C_Income_O4_CY2 =='')?0:Schedule_C_Income_O4_CY2;
        component.set("v.wrapperData.Schedule_C_Income_O4_CY2", Schedule_C_Income_O4_CY2);
		
		var Schedule_C_Income_O4_CY3 = component.get("v.wrapperData.Schedule_C_Income_O4_CY3");
        Schedule_C_Income_O4_CY3 = (Schedule_C_Income_O4_CY3=='Undefined' || Schedule_C_Income_O4_CY3==null || Schedule_C_Income_O4_CY3 =='')?0:Schedule_C_Income_O4_CY3;
        component.set("v.wrapperData.Schedule_C_Income_O4_CY3", Schedule_C_Income_O4_CY3);
        
        var Schedule_C_Income_O5_CY = component.get("v.wrapperData.Schedule_C_Income_O5_CY");
        Schedule_C_Income_O5_CY = (Schedule_C_Income_O5_CY=='Undefined' || Schedule_C_Income_O5_CY==null || Schedule_C_Income_O5_CY =='')?0:Schedule_C_Income_O5_CY;
        component.set("v.wrapperData.Schedule_C_Income_O5_CY", Schedule_C_Income_O5_CY);
		
		var Schedule_C_Income_O5_CY1 = component.get("v.wrapperData.Schedule_C_Income_O5_CY1");
        Schedule_C_Income_O5_CY1 = (Schedule_C_Income_O5_CY1=='Undefined' || Schedule_C_Income_O5_CY1==null || Schedule_C_Income_O5_CY1 =='')?0:Schedule_C_Income_O5_CY1;
        component.set("v.wrapperData.Schedule_C_Income_O5_CY1", Schedule_C_Income_O5_CY1);
		
		var Schedule_C_Income_O5_CY2 = component.get("v.wrapperData.Schedule_C_Income_O5_CY2");
        Schedule_C_Income_O5_CY2 = (Schedule_C_Income_O5_CY2=='Undefined' || Schedule_C_Income_O5_CY2==null || Schedule_C_Income_O5_CY2 =='')?0:Schedule_C_Income_O5_CY2;
        component.set("v.wrapperData.Schedule_C_Income_O5_CY2", Schedule_C_Income_O5_CY2);
		
		var Schedule_C_Income_O5_CY3 = component.get("v.wrapperData.Schedule_C_Income_O5_CY3");
        Schedule_C_Income_O5_CY3 = (Schedule_C_Income_O5_CY3=='Undefined' || Schedule_C_Income_O5_CY3==null || Schedule_C_Income_O5_CY3 =='')?0:Schedule_C_Income_O5_CY3;
        component.set("v.wrapperData.Schedule_C_Income_O5_CY3", Schedule_C_Income_O5_CY3);
        
        var Schedule_E_Rental_O1_CY = component.get("v.wrapperData.Schedule_E_Rental_O1_CY");
        Schedule_E_Rental_O1_CY = (Schedule_E_Rental_O1_CY=='Undefined' || Schedule_E_Rental_O1_CY==null || Schedule_E_Rental_O1_CY =='')?0:Schedule_E_Rental_O1_CY;
        component.set("v.wrapperData.Schedule_E_Rental_O1_CY", Schedule_E_Rental_O1_CY);
		
		var Schedule_E_Rental_O1_CY1 = component.get("v.wrapperData.Schedule_E_Rental_O1_CY1");
        Schedule_E_Rental_O1_CY1 = (Schedule_E_Rental_O1_CY1=='Undefined' || Schedule_E_Rental_O1_CY1==null || Schedule_E_Rental_O1_CY1 =='')?0:Schedule_E_Rental_O1_CY1;
        component.set("v.wrapperData.Schedule_E_Rental_O1_CY1", Schedule_E_Rental_O1_CY1);
		
		var Schedule_E_Rental_O1_CY2 = component.get("v.wrapperData.Schedule_E_Rental_O1_CY2");
        Schedule_E_Rental_O1_CY2 = (Schedule_E_Rental_O1_CY2=='Undefined' || Schedule_E_Rental_O1_CY2==null || Schedule_E_Rental_O1_CY2 =='')?0:Schedule_E_Rental_O1_CY2;
        component.set("v.wrapperData.Schedule_E_Rental_O1_CY2", Schedule_E_Rental_O1_CY2);
		
		var Schedule_E_Rental_O1_CY3 = component.get("v.wrapperData.Schedule_E_Rental_O1_CY3");
        Schedule_E_Rental_O1_CY3 = (Schedule_E_Rental_O1_CY3=='Undefined' || Schedule_E_Rental_O1_CY3==null || Schedule_E_Rental_O1_CY3 =='')?0:Schedule_E_Rental_O1_CY3;
        component.set("v.wrapperData.Schedule_E_Rental_O1_CY3", Schedule_E_Rental_O1_CY3);
		
		var Schedule_E_Rental_O2_CY = component.get("v.wrapperData.Schedule_E_Rental_O2_CY");
        Schedule_E_Rental_O2_CY = (Schedule_E_Rental_O2_CY=='Undefined' || Schedule_E_Rental_O2_CY==null || Schedule_E_Rental_O2_CY =='')?0:Schedule_E_Rental_O2_CY;
        component.set("v.wrapperData.Schedule_E_Rental_O2_CY", Schedule_E_Rental_O2_CY);
		
		var Schedule_E_Rental_O2_CY1 = component.get("v.wrapperData.Schedule_E_Rental_O2_CY1");
        Schedule_E_Rental_O2_CY1 = (Schedule_E_Rental_O2_CY1=='Undefined' || Schedule_E_Rental_O2_CY1==null || Schedule_E_Rental_O2_CY1 =='')?0:Schedule_E_Rental_O2_CY1;
        component.set("v.wrapperData.Schedule_E_Rental_O2_CY1", Schedule_E_Rental_O2_CY1);
		
		var Schedule_E_Rental_O2_CY2 = component.get("v.wrapperData.Schedule_E_Rental_O2_CY2");
        Schedule_E_Rental_O2_CY2 = (Schedule_E_Rental_O2_CY2=='Undefined' || Schedule_E_Rental_O2_CY2==null || Schedule_E_Rental_O2_CY2 =='')?0:Schedule_E_Rental_O2_CY2;
        component.set("v.wrapperData.Schedule_E_Rental_O2_CY2", Schedule_E_Rental_O2_CY2);
		
		var Schedule_E_Rental_O2_CY3 = component.get("v.wrapperData.Schedule_E_Rental_O2_CY3");
        Schedule_E_Rental_O2_CY3 = (Schedule_E_Rental_O2_CY3=='Undefined' || Schedule_E_Rental_O2_CY3==null || Schedule_E_Rental_O2_CY3 =='')?0:Schedule_E_Rental_O2_CY3;
        component.set("v.wrapperData.Schedule_E_Rental_O2_CY3", Schedule_E_Rental_O2_CY3);
		
		var Schedule_E_Rental_O3_CY = component.get("v.wrapperData.Schedule_E_Rental_O3_CY");
        Schedule_E_Rental_O3_CY = (Schedule_E_Rental_O3_CY=='Undefined' || Schedule_E_Rental_O3_CY==null || Schedule_E_Rental_O3_CY =='')?0:Schedule_E_Rental_O3_CY;
        component.set("v.wrapperData.Schedule_E_Rental_O3_CY", Schedule_E_Rental_O3_CY);
		
		var Schedule_E_Rental_O3_CY1 = component.get("v.wrapperData.Schedule_E_Rental_O3_CY1");
        Schedule_E_Rental_O3_CY1 = (Schedule_E_Rental_O3_CY1=='Undefined' || Schedule_E_Rental_O3_CY1==null || Schedule_E_Rental_O3_CY1 =='')?0:Schedule_E_Rental_O3_CY1;
        component.set("v.wrapperData.Schedule_E_Rental_O3_CY1", Schedule_E_Rental_O3_CY1);
		
		var Schedule_E_Rental_O3_CY2 = component.get("v.wrapperData.Schedule_E_Rental_O3_CY2");
        Schedule_E_Rental_O3_CY2 = (Schedule_E_Rental_O3_CY2=='Undefined' || Schedule_E_Rental_O3_CY2==null || Schedule_E_Rental_O3_CY2 =='')?0:Schedule_E_Rental_O3_CY2;
        component.set("v.wrapperData.Schedule_E_Rental_O3_CY2", Schedule_E_Rental_O3_CY2);
		
		var Schedule_E_Rental_O3_CY3 = component.get("v.wrapperData.Schedule_E_Rental_O3_CY3");
        Schedule_E_Rental_O3_CY3 = (Schedule_E_Rental_O3_CY3=='Undefined' || Schedule_E_Rental_O3_CY3==null || Schedule_E_Rental_O3_CY3 =='')?0:Schedule_E_Rental_O3_CY3;
        component.set("v.wrapperData.Schedule_E_Rental_O3_CY3", Schedule_E_Rental_O3_CY3);
		
		var Schedule_E_Rental_O4_CY = component.get("v.wrapperData.Schedule_E_Rental_O4_CY");
        Schedule_E_Rental_O4_CY = (Schedule_E_Rental_O4_CY=='Undefined' || Schedule_E_Rental_O4_CY==null || Schedule_E_Rental_O4_CY =='')?0:Schedule_E_Rental_O4_CY;
        component.set("v.wrapperData.Schedule_E_Rental_O4_CY", Schedule_E_Rental_O4_CY);
		
		var Schedule_E_Rental_O4_CY1 = component.get("v.wrapperData.Schedule_E_Rental_O4_CY1");
        Schedule_E_Rental_O4_CY1 = (Schedule_E_Rental_O4_CY1=='Undefined' || Schedule_E_Rental_O4_CY1==null || Schedule_E_Rental_O4_CY1 =='')?0:Schedule_E_Rental_O4_CY1;
        component.set("v.wrapperData.Schedule_E_Rental_O4_CY1", Schedule_E_Rental_O4_CY1);
		
		var Schedule_E_Rental_O4_CY2 = component.get("v.wrapperData.Schedule_E_Rental_O4_CY2");
        Schedule_E_Rental_O4_CY2 = (Schedule_E_Rental_O4_CY2=='Undefined' || Schedule_E_Rental_O4_CY2==null || Schedule_E_Rental_O4_CY2 =='')?0:Schedule_E_Rental_O4_CY2;
        component.set("v.wrapperData.Schedule_E_Rental_O4_CY2", Schedule_E_Rental_O4_CY2);
		
		var Schedule_E_Rental_O4_CY3 = component.get("v.wrapperData.Schedule_E_Rental_O4_CY3");
        Schedule_E_Rental_O4_CY3 = (Schedule_E_Rental_O4_CY3=='Undefined' || Schedule_E_Rental_O4_CY3==null || Schedule_E_Rental_O4_CY3 =='')?0:Schedule_E_Rental_O4_CY3;
        component.set("v.wrapperData.Schedule_E_Rental_O4_CY3", Schedule_E_Rental_O4_CY3);
        
        var Schedule_E_Rental_O5_CY = component.get("v.wrapperData.Schedule_E_Rental_O5_CY");
        Schedule_E_Rental_O5_CY = (Schedule_E_Rental_O5_CY=='Undefined' || Schedule_E_Rental_O5_CY==null || Schedule_E_Rental_O5_CY =='')?0:Schedule_E_Rental_O5_CY;
        component.set("v.wrapperData.Schedule_E_Rental_O5_CY", Schedule_E_Rental_O5_CY);
		
		var Schedule_E_Rental_O5_CY1 = component.get("v.wrapperData.Schedule_E_Rental_O5_CY1");
        Schedule_E_Rental_O5_CY1 = (Schedule_E_Rental_O5_CY1=='Undefined' || Schedule_E_Rental_O5_CY1==null || Schedule_E_Rental_O5_CY1 =='')?0:Schedule_E_Rental_O5_CY1;
        component.set("v.wrapperData.Schedule_E_Rental_O5_CY1", Schedule_E_Rental_O5_CY1);
		
		var Schedule_E_Rental_O5_CY2 = component.get("v.wrapperData.Schedule_E_Rental_O5_CY2");
        Schedule_E_Rental_O5_CY2 = (Schedule_E_Rental_O5_CY2=='Undefined' || Schedule_E_Rental_O5_CY2==null || Schedule_E_Rental_O5_CY2 =='')?0:Schedule_E_Rental_O5_CY2;
        component.set("v.wrapperData.Schedule_E_Rental_O5_CY2", Schedule_E_Rental_O5_CY2);
		
		var Schedule_E_Rental_O5_CY3 = component.get("v.wrapperData.Schedule_E_Rental_O5_CY3");
        Schedule_E_Rental_O5_CY3 = (Schedule_E_Rental_O5_CY3=='Undefined' || Schedule_E_Rental_O5_CY3==null || Schedule_E_Rental_O5_CY3 =='')?0:Schedule_E_Rental_O5_CY3;
        component.set("v.wrapperData.Schedule_E_Rental_O5_CY3", Schedule_E_Rental_O5_CY3);
        
        var K1_Distributions_O1_CY = component.get("v.wrapperData.K1_Distributions_O1_CY");
        K1_Distributions_O1_CY = (K1_Distributions_O1_CY=='Undefined' || K1_Distributions_O1_CY==null || K1_Distributions_O1_CY =='')?0:K1_Distributions_O1_CY;
        component.set("v.wrapperData.K1_Distributions_O1_CY", K1_Distributions_O1_CY);
		
		var K1_Distributions_O1_CY1 = component.get("v.wrapperData.K1_Distributions_O1_CY1");
        K1_Distributions_O1_CY1 = (K1_Distributions_O1_CY1=='Undefined' || K1_Distributions_O1_CY1==null || K1_Distributions_O1_CY1 =='')?0:K1_Distributions_O1_CY1;
        component.set("v.wrapperData.K1_Distributions_O1_CY1", K1_Distributions_O1_CY1);
		
		var K1_Distributions_O1_CY2 = component.get("v.wrapperData.K1_Distributions_O1_CY2");
        K1_Distributions_O1_CY2 = (K1_Distributions_O1_CY2=='Undefined' || K1_Distributions_O1_CY2==null || K1_Distributions_O1_CY2 =='')?0:K1_Distributions_O1_CY2;
        component.set("v.wrapperData.K1_Distributions_O1_CY2", K1_Distributions_O1_CY2);
		
		var K1_Distributions_O1_CY3 = component.get("v.wrapperData.K1_Distributions_O1_CY3");
        K1_Distributions_O1_CY3 = (K1_Distributions_O1_CY3=='Undefined' || K1_Distributions_O1_CY3==null || K1_Distributions_O1_CY3 =='')?0:K1_Distributions_O1_CY3;
        component.set("v.wrapperData.K1_Distributions_O1_CY3", K1_Distributions_O1_CY3);
		
		var K1_Distributions_O2_CY = component.get("v.wrapperData.K1_Distributions_O2_CY");
        K1_Distributions_O2_CY = (K1_Distributions_O2_CY=='Undefined' || K1_Distributions_O2_CY==null || K1_Distributions_O2_CY =='')?0:K1_Distributions_O2_CY;
        component.set("v.wrapperData.K1_Distributions_O2_CY", K1_Distributions_O2_CY);
		
		var K1_Distributions_O2_CY1 = component.get("v.wrapperData.K1_Distributions_O2_CY1");
        K1_Distributions_O2_CY1 = (K1_Distributions_O2_CY1=='Undefined' || K1_Distributions_O2_CY1==null || K1_Distributions_O2_CY1 =='')?0:K1_Distributions_O2_CY1;
        component.set("v.wrapperData.K1_Distributions_O2_CY1", K1_Distributions_O2_CY1);
		
		var K1_Distributions_O2_CY2 = component.get("v.wrapperData.K1_Distributions_O2_CY2");
        K1_Distributions_O2_CY2 = (K1_Distributions_O2_CY2=='Undefined' || K1_Distributions_O2_CY2==null || K1_Distributions_O2_CY2 =='')?0:K1_Distributions_O2_CY2;
        component.set("v.wrapperData.K1_Distributions_O2_CY2", K1_Distributions_O2_CY2);
		
		var K1_Distributions_O2_CY3 = component.get("v.wrapperData.K1_Distributions_O2_CY3");
        K1_Distributions_O2_CY3 = (K1_Distributions_O2_CY3=='Undefined' || K1_Distributions_O2_CY3==null || K1_Distributions_O2_CY3 =='')?0:K1_Distributions_O2_CY3;
        component.set("v.wrapperData.K1_Distributions_O2_CY3", K1_Distributions_O2_CY3);
		
		var K1_Distributions_O3_CY = component.get("v.wrapperData.K1_Distributions_O3_CY");
        K1_Distributions_O3_CY = (K1_Distributions_O3_CY=='Undefined' || K1_Distributions_O3_CY==null || K1_Distributions_O3_CY =='')?0:K1_Distributions_O3_CY;
        component.set("v.wrapperData.K1_Distributions_O3_CY", K1_Distributions_O3_CY);
		
		var K1_Distributions_O3_CY1 = component.get("v.wrapperData.K1_Distributions_O3_CY1");
        K1_Distributions_O3_CY1 = (K1_Distributions_O3_CY1=='Undefined' || K1_Distributions_O3_CY1==null || K1_Distributions_O3_CY1 =='')?0:K1_Distributions_O3_CY1;
        component.set("v.wrapperData.K1_Distributions_O3_CY1", K1_Distributions_O3_CY1);
		
		var K1_Distributions_O3_CY2 = component.get("v.wrapperData.K1_Distributions_O3_CY2");
        K1_Distributions_O3_CY2 = (K1_Distributions_O3_CY2=='Undefined' || K1_Distributions_O3_CY2==null || K1_Distributions_O3_CY2 =='')?0:K1_Distributions_O3_CY2;
        component.set("v.wrapperData.K1_Distributions_O3_CY2", K1_Distributions_O3_CY2);
		
		var K1_Distributions_O3_CY3 = component.get("v.wrapperData.K1_Distributions_O3_CY3");
        K1_Distributions_O3_CY3 = (K1_Distributions_O3_CY3=='Undefined' || K1_Distributions_O3_CY3==null || K1_Distributions_O3_CY3 =='')?0:K1_Distributions_O3_CY3;
        component.set("v.wrapperData.K1_Distributions_O3_CY3", K1_Distributions_O3_CY3);
		
		var K1_Distributions_O4_CY = component.get("v.wrapperData.K1_Distributions_O4_CY");
        K1_Distributions_O4_CY = (K1_Distributions_O4_CY=='Undefined' || K1_Distributions_O4_CY==null || K1_Distributions_O4_CY =='')?0:K1_Distributions_O4_CY;
        component.set("v.wrapperData.K1_Distributions_O4_CY", K1_Distributions_O4_CY);
		
		var K1_Distributions_O4_CY1 = component.get("v.wrapperData.K1_Distributions_O4_CY1");
        K1_Distributions_O4_CY1 = (K1_Distributions_O4_CY1=='Undefined' || K1_Distributions_O4_CY1==null || K1_Distributions_O4_CY1 =='')?0:K1_Distributions_O4_CY1;
        component.set("v.wrapperData.K1_Distributions_O4_CY1", K1_Distributions_O4_CY1);
		
		var K1_Distributions_O4_CY2 = component.get("v.wrapperData.K1_Distributions_O4_CY2");
        K1_Distributions_O4_CY2 = (K1_Distributions_O4_CY2=='Undefined' || K1_Distributions_O4_CY2==null || K1_Distributions_O4_CY2 =='')?0:K1_Distributions_O4_CY2;
        component.set("v.wrapperData.K1_Distributions_O4_CY2", K1_Distributions_O4_CY2);
		
		var K1_Distributions_O4_CY3 = component.get("v.wrapperData.K1_Distributions_O4_CY3");
        K1_Distributions_O4_CY3 = (K1_Distributions_O4_CY3=='Undefined' || K1_Distributions_O4_CY3==null || K1_Distributions_O4_CY3 =='')?0:K1_Distributions_O4_CY3;
        component.set("v.wrapperData.K1_Distributions_O4_CY3", K1_Distributions_O4_CY3);
        
        var K1_Distributions_O5_CY = component.get("v.wrapperData.K1_Distributions_O5_CY");
        K1_Distributions_O5_CY = (K1_Distributions_O5_CY=='Undefined' || K1_Distributions_O5_CY==null || K1_Distributions_O5_CY =='')?0:K1_Distributions_O5_CY;
        component.set("v.wrapperData.K1_Distributions_O5_CY", K1_Distributions_O5_CY);
		
		var K1_Distributions_O5_CY1 = component.get("v.wrapperData.K1_Distributions_O5_CY1");
        K1_Distributions_O5_CY1 = (K1_Distributions_O5_CY1=='Undefined' || K1_Distributions_O5_CY1==null || K1_Distributions_O5_CY1 =='')?0:K1_Distributions_O5_CY1;
        component.set("v.wrapperData.K1_Distributions_O5_CY1", K1_Distributions_O5_CY1);
		
		var K1_Distributions_O5_CY2 = component.get("v.wrapperData.K1_Distributions_O5_CY2");
        K1_Distributions_O5_CY2 = (K1_Distributions_O5_CY2=='Undefined' || K1_Distributions_O5_CY2==null || K1_Distributions_O5_CY2 =='')?0:K1_Distributions_O5_CY2;
        component.set("v.wrapperData.K1_Distributions_O5_CY2", K1_Distributions_O5_CY2);
		
		var K1_Distributions_O5_CY3 = component.get("v.wrapperData.K1_Distributions_O5_CY3");
        K1_Distributions_O5_CY3 = (K1_Distributions_O5_CY3=='Undefined' || K1_Distributions_O5_CY3==null || K1_Distributions_O5_CY3 =='')?0:K1_Distributions_O5_CY3;
        component.set("v.wrapperData.K1_Distributions_O5_CY3", K1_Distributions_O5_CY3);
        
        var Residence_Mortgage_Owner_1 = component.get("v.wrapperData.Residence_Mortgage_Owner_1");
        Residence_Mortgage_Owner_1 = (Residence_Mortgage_Owner_1=='Undefined' || Residence_Mortgage_Owner_1==null || Residence_Mortgage_Owner_1 =='')?0:Residence_Mortgage_Owner_1;
        component.set("v.wrapperData.Residence_Mortgage_Owner_1", Residence_Mortgage_Owner_1);
		
		var Rental_Payment_Owner_1 = component.get("v.wrapperData.Rental_Payment_Owner_1");
        Rental_Payment_Owner_1 = (Rental_Payment_Owner_1=='Undefined' || Rental_Payment_Owner_1==null || Rental_Payment_Owner_1 =='')?0:Rental_Payment_Owner_1;
        component.set("v.wrapperData.Rental_Payment_Owner_1", Rental_Payment_Owner_1);
		
		var HELOC_Owner_1 = component.get("v.wrapperData.HELOC_Owner_1");
        HELOC_Owner_1 = (HELOC_Owner_1=='Undefined' || HELOC_Owner_1==null || HELOC_Owner_1 =='')?0:HELOC_Owner_1;
        component.set("v.wrapperData.HELOC_Owner_1", HELOC_Owner_1);
		
		var Installment_Debt_Owner_1 = component.get("v.wrapperData.Installment_Debt_Owner_1");
        Installment_Debt_Owner_1 = (Installment_Debt_Owner_1=='Undefined' || Installment_Debt_Owner_1==null || Installment_Debt_Owner_1 =='')?0:Installment_Debt_Owner_1;
        component.set("v.wrapperData.Installment_Debt_Owner_1", Installment_Debt_Owner_1);
		
		var Credit_Card_Debt_Owner_1 = component.get("v.wrapperData.Credit_Card_Debt_Owner_1");
        Credit_Card_Debt_Owner_1 = (Credit_Card_Debt_Owner_1=='Undefined' || Credit_Card_Debt_Owner_1==null || Credit_Card_Debt_Owner_1 =='')?0:Credit_Card_Debt_Owner_1;
        component.set("v.wrapperData.Credit_Card_Debt_Owner_1", Credit_Card_Debt_Owner_1);
		
		var Other_debt_Owner_1 = component.get("v.wrapperData.Other_debt_Owner_1");
        Other_debt_Owner_1 = (Other_debt_Owner_1=='Undefined' || Other_debt_Owner_1==null || Other_debt_Owner_1 =='')?0:Other_debt_Owner_1;
        component.set("v.wrapperData.Other_debt_Owner_1", Other_debt_Owner_1);
        
        var Residence_Mortgage_Owner_2 = component.get("v.wrapperData.Residence_Mortgage_Owner_2");
        Residence_Mortgage_Owner_2 = (Residence_Mortgage_Owner_2=='Undefined' || Residence_Mortgage_Owner_2==null || Residence_Mortgage_Owner_2 =='')?0:Residence_Mortgage_Owner_2;
        component.set("v.wrapperData.Residence_Mortgage_Owner_2", Residence_Mortgage_Owner_2);
		
		var Rental_Payment_Owner_2 = component.get("v.wrapperData.Rental_Payment_Owner_2");
        Rental_Payment_Owner_2 = (Rental_Payment_Owner_2=='Undefined' || Rental_Payment_Owner_2==null || Rental_Payment_Owner_2 =='')?0:Rental_Payment_Owner_2;
        component.set("v.wrapperData.Rental_Payment_Owner_2", Rental_Payment_Owner_2);
		
		var HELOC_Owner_2 = component.get("v.wrapperData.HELOC_Owner_2");
        HELOC_Owner_2 = (HELOC_Owner_2=='Undefined' || HELOC_Owner_2==null || HELOC_Owner_2 =='')?0:HELOC_Owner_2;
        component.set("v.wrapperData.HELOC_Owner_2", HELOC_Owner_2);
		
		var Installment_Debt_Owner_2 = component.get("v.wrapperData.Installment_Debt_Owner_2");
        Installment_Debt_Owner_2 = (Installment_Debt_Owner_2=='Undefined' || Installment_Debt_Owner_2==null || Installment_Debt_Owner_2 =='')?0:Installment_Debt_Owner_2;
        component.set("v.wrapperData.Installment_Debt_Owner_2", Installment_Debt_Owner_2);
		
		var Credit_Card_Debt_Owner_2 = component.get("v.wrapperData.Credit_Card_Debt_Owner_2");
        Credit_Card_Debt_Owner_2 = (Credit_Card_Debt_Owner_2=='Undefined' || Credit_Card_Debt_Owner_2==null || Credit_Card_Debt_Owner_2 =='')?0:Credit_Card_Debt_Owner_2;
        component.set("v.wrapperData.Credit_Card_Debt_Owner_2", Credit_Card_Debt_Owner_2);
		
		var Other_debt_Owner_2 = component.get("v.wrapperData.Other_debt_Owner_2");
        Other_debt_Owner_2 = (Other_debt_Owner_2=='Undefined' || Other_debt_Owner_2==null || Other_debt_Owner_2 =='')?0:Other_debt_Owner_2;
        component.set("v.wrapperData.Other_debt_Owner_2", Other_debt_Owner_2);
        
        var Residence_Mortgage_Owner_3 = component.get("v.wrapperData.Residence_Mortgage_Owner_3");
        Residence_Mortgage_Owner_3 = (Residence_Mortgage_Owner_3=='Undefined' || Residence_Mortgage_Owner_3==null || Residence_Mortgage_Owner_3 =='')?0:Residence_Mortgage_Owner_3;
        component.set("v.wrapperData.Residence_Mortgage_Owner_3", Residence_Mortgage_Owner_3);
		
		var Rental_Payment_Owner_3 = component.get("v.wrapperData.Rental_Payment_Owner_3");
        Rental_Payment_Owner_3 = (Rental_Payment_Owner_3=='Undefined' || Rental_Payment_Owner_3==null || Rental_Payment_Owner_3 =='')?0:Rental_Payment_Owner_3;
        component.set("v.wrapperData.Rental_Payment_Owner_3", Rental_Payment_Owner_3);
		
		var HELOC_Owner_3 = component.get("v.wrapperData.HELOC_Owner_3");
        HELOC_Owner_3 = (HELOC_Owner_3=='Undefined' || HELOC_Owner_3==null || HELOC_Owner_3 =='')?0:HELOC_Owner_3;
        component.set("v.wrapperData.HELOC_Owner_3", HELOC_Owner_3);
		
		var Installment_Debt_Owner_3 = component.get("v.wrapperData.Installment_Debt_Owner_3");
        Installment_Debt_Owner_3 = (Installment_Debt_Owner_3=='Undefined' || Installment_Debt_Owner_3==null || Installment_Debt_Owner_3 =='')?0:Installment_Debt_Owner_3;
        component.set("v.wrapperData.Installment_Debt_Owner_3", Installment_Debt_Owner_3);
		
		var Credit_Card_Debt_Owner_3 = component.get("v.wrapperData.Credit_Card_Debt_Owner_3");
        Credit_Card_Debt_Owner_3 = (Credit_Card_Debt_Owner_3=='Undefined' || Credit_Card_Debt_Owner_3==null || Credit_Card_Debt_Owner_3 =='')?0:Credit_Card_Debt_Owner_3;
        component.set("v.wrapperData.Credit_Card_Debt_Owner_3", Credit_Card_Debt_Owner_3);
		
		var Other_debt_Owner_3 = component.get("v.wrapperData.Other_debt_Owner_3");
        Other_debt_Owner_3 = (Other_debt_Owner_3=='Undefined' || Other_debt_Owner_3==null || Other_debt_Owner_3 =='')?0:Other_debt_Owner_3;
        component.set("v.wrapperData.Other_debt_Owner_3", Other_debt_Owner_3);
        
        var Residence_Mortgage_Owner_4 = component.get("v.wrapperData.Residence_Mortgage_Owner_4");
        Residence_Mortgage_Owner_4 = (Residence_Mortgage_Owner_4=='Undefined' || Residence_Mortgage_Owner_4==null || Residence_Mortgage_Owner_4 =='')?0:Residence_Mortgage_Owner_4;
        component.set("v.wrapperData.Residence_Mortgage_Owner_4", Residence_Mortgage_Owner_4);
		
		var Rental_Payment_Owner_4 = component.get("v.wrapperData.Rental_Payment_Owner_4");
        Rental_Payment_Owner_4 = (Rental_Payment_Owner_4=='Undefined' || Rental_Payment_Owner_4==null || Rental_Payment_Owner_4 =='')?0:Rental_Payment_Owner_4;
        component.set("v.wrapperData.Rental_Payment_Owner_4", Rental_Payment_Owner_4);
		
		var HELOC_Owner_4 = component.get("v.wrapperData.HELOC_Owner_4");
        HELOC_Owner_4 = (HELOC_Owner_4=='Undefined' || HELOC_Owner_4==null || HELOC_Owner_4 =='')?0:HELOC_Owner_4;
        component.set("v.wrapperData.HELOC_Owner_4", HELOC_Owner_4);
		
		var Installment_Debt_Owner_4 = component.get("v.wrapperData.Installment_Debt_Owner_4");
        Installment_Debt_Owner_4 = (Installment_Debt_Owner_4=='Undefined' || Installment_Debt_Owner_4==null || Installment_Debt_Owner_4 =='')?0:Installment_Debt_Owner_4;
        component.set("v.wrapperData.Installment_Debt_Owner_4", Installment_Debt_Owner_4);
		
		var Credit_Card_Debt_Owner_4 = component.get("v.wrapperData.Credit_Card_Debt_Owner_4");
        Credit_Card_Debt_Owner_4 = (Credit_Card_Debt_Owner_4=='Undefined' || Credit_Card_Debt_Owner_4==null || Credit_Card_Debt_Owner_4 =='')?0:Credit_Card_Debt_Owner_4;
        component.set("v.wrapperData.Credit_Card_Debt_Owner_4", Credit_Card_Debt_Owner_4);
		
		var Other_debt_Owner_4 = component.get("v.wrapperData.Other_debt_Owner_4");
        Other_debt_Owner_4 = (Other_debt_Owner_4=='Undefined' || Other_debt_Owner_4==null || Other_debt_Owner_4 =='')?0:Other_debt_Owner_4;
        component.set("v.wrapperData.Other_debt_Owner_4", Other_debt_Owner_4);
        
        var Residence_Mortgage_Owner_5 = component.get("v.wrapperData.Residence_Mortgage_Owner_5");
        Residence_Mortgage_Owner_5 = (Residence_Mortgage_Owner_5=='Undefined' || Residence_Mortgage_Owner_5==null || Residence_Mortgage_Owner_5 =='')?0:Residence_Mortgage_Owner_5;
        component.set("v.wrapperData.Residence_Mortgage_Owner_5", Residence_Mortgage_Owner_5);
		
		var Rental_Payment_Owner_5 = component.get("v.wrapperData.Rental_Payment_Owner_5");
        Rental_Payment_Owner_5 = (Rental_Payment_Owner_5=='Undefined' || Rental_Payment_Owner_5==null || Rental_Payment_Owner_5 =='')?0:Rental_Payment_Owner_5;
        component.set("v.wrapperData.Rental_Payment_Owner_5", Rental_Payment_Owner_5);
		
		var HELOC_Owner_5 = component.get("v.wrapperData.HELOC_Owner_5");
        HELOC_Owner_5 = (HELOC_Owner_5=='Undefined' || HELOC_Owner_5==null || HELOC_Owner_5 =='')?0:HELOC_Owner_5;
        component.set("v.wrapperData.HELOC_Owner_5", HELOC_Owner_5);
		
		var Installment_Debt_Owner_5 = component.get("v.wrapperData.Installment_Debt_Owner_5");
        Installment_Debt_Owner_5 = (Installment_Debt_Owner_5=='Undefined' || Installment_Debt_Owner_5==null || Installment_Debt_Owner_5 =='')?0:Installment_Debt_Owner_5;
        component.set("v.wrapperData.Installment_Debt_Owner_5", Installment_Debt_Owner_5);
		
		var Credit_Card_Debt_Owner_5 = component.get("v.wrapperData.Credit_Card_Debt_Owner_5");
        Credit_Card_Debt_Owner_5 = (Credit_Card_Debt_Owner_5=='Undefined' || Credit_Card_Debt_Owner_5==null || Credit_Card_Debt_Owner_5 =='')?0:Credit_Card_Debt_Owner_5;
        component.set("v.wrapperData.Credit_Card_Debt_Owner_5", Credit_Card_Debt_Owner_5);
		
		var Other_debt_Owner_5 = component.get("v.wrapperData.Other_debt_Owner_5");
        Other_debt_Owner_5 = (Other_debt_Owner_5=='Undefined' || Other_debt_Owner_5==null || Other_debt_Owner_5 =='')?0:Other_debt_Owner_5;
        component.set("v.wrapperData.Other_debt_Owner_5", Other_debt_Owner_5);
        
        // Null check for Adults and Kids currency
        var AdultCurrency_Owner1 = component.get("v.wrapperData.AdultCurrency_Owner1");
        AdultCurrency_Owner1 = (AdultCurrency_Owner1=='Undefined' || AdultCurrency_Owner1==null || AdultCurrency_Owner1 =='')?0:AdultCurrency_Owner1;
        component.set("v.wrapperData.AdultCurrency_Owner1", AdultCurrency_Owner1);
		
		var KidCurrency_Owner1 = component.get("v.wrapperData.KidCurrency_Owner1");
        KidCurrency_Owner1 = (KidCurrency_Owner1=='Undefined' || KidCurrency_Owner1==null || KidCurrency_Owner1 =='')?0:KidCurrency_Owner1;
        component.set("v.wrapperData.KidCurrency_Owner1", KidCurrency_Owner1);
        
        var AdultCurrency_Owner2 = component.get("v.wrapperData.AdultCurrency_Owner2");
        AdultCurrency_Owner2 = (AdultCurrency_Owner2=='Undefined' || AdultCurrency_Owner2==null || AdultCurrency_Owner2 =='')?0:AdultCurrency_Owner2;
        component.set("v.wrapperData.AdultCurrency_Owner2", AdultCurrency_Owner2);
		
		var KidCurrency_Owner2 = component.get("v.wrapperData.KidCurrency_Owner2");
        KidCurrency_Owner2 = (KidCurrency_Owner2=='Undefined' || KidCurrency_Owner2==null || KidCurrency_Owner2 =='')?0:KidCurrency_Owner2;
        component.set("v.wrapperData.KidCurrency_Owner2", KidCurrency_Owner2);
        
        var AdultCurrency_Owner3 = component.get("v.wrapperData.AdultCurrency_Owner3");
        AdultCurrency_Owner3 = (AdultCurrency_Owner3=='Undefined' || AdultCurrency_Owner3==null || AdultCurrency_Owner3 =='')?0:AdultCurrency_Owner3;
        component.set("v.wrapperData.AdultCurrency_Owner3", AdultCurrency_Owner3);
		
		var KidCurrency_Owner3 = component.get("v.wrapperData.KidCurrency_Owner3");
        KidCurrency_Owner3 = (KidCurrency_Owner3=='Undefined' || KidCurrency_Owner3==null || KidCurrency_Owner3 =='')?0:KidCurrency_Owner3;
        component.set("v.wrapperData.KidCurrency_Owner3", KidCurrency_Owner3);
        
        var AdultCurrency_Owner4 = component.get("v.wrapperData.AdultCurrency_Owner4");
        AdultCurrency_Owner4 = (AdultCurrency_Owner4=='Undefined' || AdultCurrency_Owner4==null || AdultCurrency_Owner4 =='')?0:AdultCurrency_Owner4;
        component.set("v.wrapperData.AdultCurrency_Owner4", AdultCurrency_Owner4);
		
		var KidCurrency_Owner4 = component.get("v.wrapperData.KidCurrency_Owner4");
        KidCurrency_Owner4 = (KidCurrency_Owner4=='Undefined' || KidCurrency_Owner4==null || KidCurrency_Owner4 =='')?0:KidCurrency_Owner4;
        component.set("v.wrapperData.KidCurrency_Owner4", KidCurrency_Owner4);
        
        var AdultCurrency_Owner5 = component.get("v.wrapperData.AdultCurrency_Owner5");
        AdultCurrency_Owner5 = (AdultCurrency_Owner5=='Undefined' || AdultCurrency_Owner5==null || AdultCurrency_Owner5 =='')?0:AdultCurrency_Owner5;
        component.set("v.wrapperData.AdultCurrency_Owner5", AdultCurrency_Owner5);
		
		var KidCurrency_Owner5 = component.get("v.wrapperData.KidCurrency_Owner5");
        KidCurrency_Owner5 = (KidCurrency_Owner5=='Undefined' || KidCurrency_Owner5==null || KidCurrency_Owner5 =='')?0:KidCurrency_Owner5;
        component.set("v.wrapperData.KidCurrency_Owner5", KidCurrency_Owner5);
        
        
        action.setParams({mainWrapperData : component.get("v.wrapperData"), leadID : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.IsQCF_Run", true);
                component.set("v.wrapperData", response.getReturnValue());
                console.log("Main wrapper called : " +response.getReturnValue());
                component.set("v.wrapperData.Highest_Credit_Score", component.get("v.HighestCreditScore"));
                helper.hideSpinner(component);
                console.log('------Total_First_CY----->>>'+component.get("v.wrapperData.Total_First_CY"));
            }
            else {
                console.log("Main wrapper calling failed: " + response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
    },
    saveQCF : function(component, event,helper){
        var leadID = component.get("v.recordId");
        helper.showSpinner(component);
        var action = component.get("c.saveQCFData");
        
        action.setParams({ ObjWrapperData: component.get("v.wrapperData"), leadID: component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //component.set("v.wrapperData", response.getReturnValue());
                console.log("Main wrapper called : " +response.getReturnValue());
                helper.hideSpinner(component);
               helper.showSuccessOnSave(component, event,helper);
            }
            else {
                console.log("Main wrapper calling failed: " + response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
    },
    
    helperFun : function(component,event,secId) {
        var acc = component.find(secId);
        for(var cmp in acc) {
            $A.util.toggleClass(acc[cmp], 'slds-show');  
            $A.util.toggleClass(acc[cmp], 'slds-hide');  
        }
    },
    
    showSpinner: function (component, event, helper) {
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
    },
    
    hideSpinner: function (component, event, helper) {
        var spinner = component.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    },
    changeValue : function(component) {
        component.set("v.msg","Changed value before Render");
    },
    showToast : function(component, event, helper) {
        // Use \n for line breake in string 
        var sMsg = 'Please Run Quick Cash Flow before save \n';
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            mode: 'dismissible',
            duration: 5000,
            message: sMsg,
            type : 'error'
        });
        toastEvent.fire();
    },
    showSuccessOnSave : function(component, event, helper) {
        // Use \n for line breake in string 
        var sMsg = 'Quick Cash Flow has been saved successfully.';
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            mode: 'dismissible',
            duration: 5000,
            message: sMsg,
            type : 'Success'
        });
        toastEvent.fire();
    }
    
    
    
    
})