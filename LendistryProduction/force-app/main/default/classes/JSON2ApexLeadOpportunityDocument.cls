public class JSON2ApexLeadOpportunityDocument {
    //public String RecordTypeID;
    public String ApplicationID;
    public String BusinessID;
    public String LeadID;
    public String OpportunityID;
    public Decimal DocumentPercentage;
   
    public static JSON2ApexLeadOpportunityDocument parse(String json) 
    {
        return (JSON2ApexLeadOpportunityDocument ) System.JSON.deserialize(json, JSON2ApexLeadOpportunityDocument.class);
    }
}