@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"stagename":"Docs Out","Sales_Business_Id":"1234567","Opportunity_Id":"0062a000006iVO7AAM","daysinStage":12}]');
        if(req.getMethod()=='POST'){
            res.setStatusCode(201);
        }
        if(req.getMethod()=='PUT' || req.getMethod()=='GET'){
            res.setStatusCode(200);
        }
        return res;
    }
    
}