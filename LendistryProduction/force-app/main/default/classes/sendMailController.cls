public class sendMailController{
    public static void sendEmail(String request, String response,String BusinessId, String applicationId){
        List<String> listOfEmail = new List<String>();
        String emailIds = System.Label.LeadConversion_Email_User;
        List<String> breakList = emailIds.split(';');
        for(String str : breakList ){
            listOfEmail.add(str);
        }
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>();
        mail.setToAddresses(listOfEmail);
        mail.setSubject('Lead to opportunity conversion failed at portal end.');
        String body = 'Hi<br/>';
        body += 'SF & Portal admins the application Id conversion has failed. Please find the request and JSON below<br/>';
        body += 'ApplicationId :'+applicationId+'<br/>';
        body += 'Business Id:'+BusinessId+'<br/>';
        body += 'Request :'+request+'<br/>';
        body += 'Response :'+response+'<br/><br/><br/>';
        body += 'Thanx';       
        mail.setHtmlBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail}); 
    }
}