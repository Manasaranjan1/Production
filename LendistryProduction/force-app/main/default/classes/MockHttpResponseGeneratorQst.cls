@isTest
global class MockHttpResponseGeneratorQst implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"TenantId":101,"LeadId":"00Q3J000001LYzK","Questionnaire":[{"questionId":1,"description":"What is your Name","questionType":"text","isRequired":false,"answer":"any","options":null,"isCustomized":false},{"questionId":2,"description":"Do you live in india","questionType":"DropDown","isRequired":false,"answer":"Yes","options":"Yes,No","isCustomized":false}]}');
        if(req.getMethod()=='POST'){
            res.setStatusCode(201);
        }
        if(req.getMethod()=='PUT' || req.getMethod()=='GET'){
            res.setStatusCode(200);
        }
        return res;
    }
    
}