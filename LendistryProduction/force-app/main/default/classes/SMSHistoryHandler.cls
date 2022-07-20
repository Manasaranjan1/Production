public class SMSHistoryHandler 
{
	Public Void onAfterInsert (List<tdc_tsw__Message__c> listofSMSHistory)
	{
		List<Lead> updateLeadlist = new List <Lead>();
		map<ID,DateTime> mapofLeadIDwithDate = new map<ID,dateTime>();
		Id devRecordTypeId = Schema.SObjectType.tdc_tsw__Message__c.getRecordTypeInfosByName().get('Outgoing').getRecordTypeId();
		if(listofSMSHistory != null && listofSMSHistory.size()>0)
		{
			for(tdc_tsw__Message__c objMessage : [Select Id,tdc_tsw__Lead__c,CreatedDate FROM tdc_tsw__Message__c 
													WHERE tdc_tsw__Lead__c != null AND Name = 'Outgoing' AND recordTypeId = :devRecordTypeId  AND CreatedDate != NULL AND ID in :listofSMSHistory])
			{
				mapofLeadIDwithDate.put(objMessage.tdc_tsw__Lead__c , objMessage.CreatedDate);
			}
		}
		if(mapofLeadIDwithDate != null && mapofLeadIDwithDate.size()>0)
		{
			for(String str : mapofLeadIDwithDate.keyset())
                
			{
				Lead objLead = new Lead (id=str);
				objLead.SMS_Sent_Date__c = mapofLeadIDwithDate.get(str);
				updateLeadlist.add(objLead);
			}
		}
		if(updateLeadlist != null && updateLeadlist.size() > 0)
			Update updateLeadlist;
	}
}