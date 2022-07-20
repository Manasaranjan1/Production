public class JSON2ApexEntityType {
    //public String RecordTypeID;
	public String ApplicationID;
	public String BusinessType;
	public String LeadID;
	public String OpportunityID;
	
	public static JSON2ApexEntityType parse(String json) 
	{
        return (JSON2ApexEntityType) System.JSON.deserialize(json, JSON2ApexEntityType.class);
    }
}