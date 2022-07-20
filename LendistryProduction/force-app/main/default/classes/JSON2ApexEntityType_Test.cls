@IsTest
public class JSON2ApexEntityType_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		''+
		'\"ApplicationID\" : \"DIR12345\",'+
		''+
		'\"BusinessType\" : \"Non Profit\",'+
		''+
		'\"LeadID\" : \"00Q3K000001E1ZgUAK\",'+
		''+
		'\"OpportunityID\" : \"0063K000002Km8mQAC\"'+
		''+
		'}';
		JSON2ApexEntityType obj = JSON2ApexEntityType.parse(json);
		System.assert(obj != null);
	}
}