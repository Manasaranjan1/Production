public class JSON2ApexUnderwriterUpdate {
    
	public String ApplicationID;
	public String BusinessID;
	public String OpportunityID;
	public String Underwriter;
	
	public static JSON2ApexUnderwriterUpdate parse(String json) 
	{
        return (JSON2ApexUnderwriterUpdate) System.JSON.deserialize(json, JSON2ApexUnderwriterUpdate.class);
    }
}