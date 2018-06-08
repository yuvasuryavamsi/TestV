public class CallMD_IVRTest {
  /*
     Request:

curl -X POST \
  https://webdev4.ivrtechnology.com/callmd_middleware/make-call \
  -H 'Authorization: Token f1c00e4c5937e5a3b22bf1027d23016a0a1715ac' \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: 2bc1c6b4-fd31-4d43-b75e-fad22fccac03' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F phone_number=7162760041 \

  -F doctor_id=123456789 \
  -F consultation_id=12345678 \


Response:

{
    "queueid": 662730,
    "result": "Success" 
}
*/
public string responseBody{get;set;}
public void send(){

   HttpRequest req=new HttpRequest();
   string endpoint='https://webdev4.ivrtechnology.com/callmd_middleware/make-call';
   req.setEndpoint(endpoint);
   req.setMethod('POST');
   req.setHeader('Authorization','Token f1c00e4c5937e5a3b22bf1027d23016a0a1715ac');
   req.setHeader('content-type','multipart/form-data');
   string body='consultation_id=a05W0000006gfFAIAY';
   req.setBody(body);
   
   HttP ht=new HttP();
   
   HttPResponse res=ht.send(req);
   
   responseBody=res.getBody();

}



}