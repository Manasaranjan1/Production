public class JSON2ApexScoreCard {

    public String opportunityId;
    public String LeadId;
    public String application_id;
    public String BusinessId;
    public Decimal Industry_retail_food_health_care_hai;
    public Decimal U_S_CDFI_Fund_Investment_Area_OR_Low_In;
    public Decimal Degree_to_which_the_business_was_impacte;
    public Decimal Not_Prior_Receipt;
    public Decimal Business_operates_in_a_designated;
    public Decimal From_a_rural_county;
    public Decimal County_Population_Loss;
    public Decimal Woman_Owned;
    public Decimal TotalScoreValue;
    public Decimal Low_Income_Owner;
    public Decimal Low_Mod_Borough_Approved_Score;
    public Decimal NP_Low_Mod_Approved_Score;
    public Decimal NP_Industry_Approved_Score;
    public Decimal NP_Serves_Person_of_Color_Approved_Score;
    public Decimal Person_of_Color_Approved_Score ;
    public Decimal Not_In_Urbanized_Area_Or_Urbanized_Cluster_Approved_Score;
    public Decimal Low_To_Moderate_Income_Area_Approved_Score;
    public Boolean isApproved;
    public Decimal Is_Owned_By_Woman_Veteran_Disabled_Approved_Score;
    public static JSON2ApexScoreCard parse(String json) {
        return (JSON2ApexScoreCard) System.JSON.deserialize(json, JSON2ApexScoreCard.class);
    }
}