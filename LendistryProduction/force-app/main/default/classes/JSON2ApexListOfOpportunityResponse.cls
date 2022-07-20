public class JSON2ApexListOfOpportunityResponse {

  public String businessId;
  public String opportunityId;
  public Boolean isUpdated;
  
  public static List<JSON2ApexListOfOpportunityResponse> parse(String json) {
    return (List<JSON2ApexListOfOpportunityResponse >) System.JSON.deserialize(json, List<JSON2ApexListOfOpportunityResponse >.class);
  }
}