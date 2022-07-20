@isTest(seeAlldata=true)
public class SalesforceScorecardAPI_Test{

 public static testMethod void method2(){
    
        Test.setMock(HttpCalloutMock.class, new JavaAPICallOut_Mock());
        
        String requestBodyString = '{"Woman_Owned":0.25,"U_S_CDFI_Fund_Investment_Area_OR_Low_In":2.00,"Low_Income_Owner":1.30,"TotalScoreValue":null,"opportunityId":"","Not_Prior_Receipt":0.10,"LeadId":"00Q1V00000weJza","isApproved":false,"Industry_retail_food_health_care_hai":1.00,"From_a_rural_county":0.25,"Degree_to_which_the_business_was_impacte":0.50,"County_Population_Loss":1.25,"BusinessId":"2090","Business_operates_in_a_designated":1.9,"application_id":"DIR18354820","Is_Owned_By_Woman_Veteran_Disabled_Approved_Score":2.00,"Low_Mod_Borough_Approved_Score":2.00,"NP_Low_Mod_Approved_Score":2.00,"NP_Industry_Approved_Score":2.00,"NP_Serves_Person_of_Color_Approved_Score":2.00,"Person_of_Color_Approved_Score":2.00}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceScorecardAPI/*','PATCH');
        RestContext.response = new RestResponse();    
        
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceScorecardAPI/*','PATCH');
        RestContext.response = new RestResponse();   
        
        
          
        Test.startTest();
            SalesforceScorecardAPI.PatchLeadData();
            
        Test.stopTest();
        JSON2ApexScoreCard  objWrap = new JSON2ApexScoreCard();
        objWrap.opportunityId ='';
        objWrap.LeadId='';
        objWrap.application_id ='';
        objWrap.BusinessId='';
        objWrap.Industry_retail_food_health_care_hai =0;
        objWrap.U_S_CDFI_Fund_Investment_Area_OR_Low_In=0;
        objWrap.Industry_retail_food_health_care_hai =0;
        objWrap.Not_Prior_Receipt=0;
        objWrap.Business_operates_in_a_designated=0;
        objWrap.From_a_rural_county=0;
        objWrap.County_Population_Loss=0;
        objWrap.Woman_Owned=0;
        objWrap.TotalScoreValue =0;
        objWrap.Low_Income_Owner=0;
       // objWrap.Is_Owned_By_Woman_Veteran_Disabled_Approved_Score = 0;      
    }
    
    public static testMethod void method(){
         String requestBodyString = '{"Woman_Owned":0.25,"U_S_CDFI_Fund_Investment_Area_OR_Low_In":2.00,"Low_Income_Owner":1.30,"TotalScoreValue":null,"opportunityId":"","Not_Prior_Receipt":0.10,"LeadId":"00Q1V00000weJz","isApproved":false,"Industry_retail_food_health_care_hai":1.00,"From_a_rural_county":0.25,"Degree_to_which_the_business_was_impacte":0.50,"County_Population_Loss":1.25,"BusinessId":"2090","Business_operates_in_a_designated":1.9,"application_id":"DIR18354820"}';
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceScorecardAPI/*','PATCH');
        RestContext.response = new RestResponse();    
        
        RestContext.request = setTestRestRequest(requestBodyString,'/salesforce/SalesforceScorecardAPI/*','PATCH');
        RestContext.response = new RestResponse();            
        Test.startTest();
            SalesforceScorecardAPI.PatchLeadData();
            
        Test.stopTest();
    }
    private static RestRequest setTestRestRequest(String requestBodyString, String url, String requestType) {
        RestRequest req = new RestRequest();
        req.requestURI = url; 
        req.httpMethod = requestType;
        req.requestBody = Blob.valueof(requestBodyString);
        return req;
        
    }
    private static RestResponse setTestRestResponse(String responseBodyString, String url, String responseType) {
        RestResponse res = new RestResponse();
        res.statusCode = 500;
        //res.responseURI = url; 
        //res.httpMethod = responseType;
        res.responseBody = Blob.valueof(responseBodyString);
        return res;
    }
}