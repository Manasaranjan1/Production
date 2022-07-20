@isTest
global class JavaAPICallOut_Mock implements HttpCalloutMock{
    global HttpResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatus('OK');
        res.setStatusCode(200);
        res.setBody('{"username": "'+System.Label.JavaPortalUserName+'","secure": "'+System.Label.JavaPortalPassword+'"}');
        return res;
    }
     global HttpResponse respond2(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatus('OK');
        res.setStatusCode(200);
        res.setBody('{"username": "'+System.Label.JavaPortalUserName+'","secure": "'+System.Label.JavaPortalPassword+'"}');
        return res;
     }
}