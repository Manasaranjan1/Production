public class JSON2ApexOpp {

    public String Opportunity_Id;
    public String StageName;
    public string loan_number;
    public string Sales_Business_Id;
    public string interest_type;
    public string sales_decline_reason;
    public string loan_type;
    public string processing_fee;
    public string origination_fee;
    public string referral_part_fee;
    public string referral_source;


    
    public static List<JSON2ApexOpp> parse(String json) {
        return (List<JSON2ApexOpp>) System.JSON.deserialize(json, List<JSON2ApexOpp>.class);
    }
    
    public static JSON2ApexOpp parseObj(String json) {
        return (JSON2ApexOpp) System.JSON.deserialize(json, JSON2ApexOpp.class);
    }
}