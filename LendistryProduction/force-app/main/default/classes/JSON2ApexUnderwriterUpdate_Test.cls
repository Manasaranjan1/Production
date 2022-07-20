@IsTest
public class JSON2ApexUnderwriterUpdate_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		''+
		'\"ApplicationID\" : \"DIR12345\",'+
		''+
		'\"BusinessID\" : \"16878\",'+
		''+
		'\"OpportunityID\" : \"0063K000004FU6Q\",'+
		''+
		'\"Underwriter\" : \"0051V000005BdlPQAS\"'+
		''+
		'}';
		JSON2ApexUnderwriterUpdate obj = JSON2ApexUnderwriterUpdate.parse(json);
		System.assert(obj != null);
	}
}