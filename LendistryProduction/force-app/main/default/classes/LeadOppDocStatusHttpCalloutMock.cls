@isTest
global class LeadOppDocStatusHttpCalloutMock implements HttpCalloutMock {
    // Implement this interface method
     global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"LeadId":"0062a000006iVO7AAM"}]');
        if(req.getMethod()=='POST'){
            res.setStatusCode(201);
        }
        
        return res;
    }
}