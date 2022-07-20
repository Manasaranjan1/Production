@IsTest
public class JSON2ApexOpp_Test {
	
	static testMethod void testParse() {
		String json = '{\"sales_decline_reason\":null,\"referral_source\":null,\"referral_part_fee\":null,\"processing_fee\":\"1212\",\"origination_fee\":null,\"closing_fee\":null,\"business_id\":\"508\"}';
		JSON2Apex obj = JSON2Apex.parse(json);
		System.assert(obj != null);
	}
}