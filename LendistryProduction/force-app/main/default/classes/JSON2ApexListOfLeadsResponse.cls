//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

public class JSON2ApexListOfLeadsResponse {

	public String leadId;
	public String email;
	public Boolean status;
	public string Application_Id;
	public string Business_Id;
    public string PrimaryOwnerId;

	
	public static List<JSON2ApexListOfLeadsResponse> parse(String json) {
		return (List<JSON2ApexListOfLeadsResponse>) System.JSON.deserialize(json, List<JSON2ApexListOfLeadsResponse>.class);
	}
}