@RestResource(urlMapping='/v1/d2cregistration/*')
global class CallMD_d2cRegistration {
    
    @HttpPost
    global static reponseMember createMemberSubscription(requestMember reqMem){
        
        reponseMember resp = new reponseMember();
        Member__c  mem = new Member__c();
        mem.FirstName__c = reqMem.firstname;
        mem.LastName__c = reqMem.lastname;
        mem.Cell_Phone__c = reqMem.mobileno;
        mem.Email__c = reqMem.email;
        mem.DateofBirth__c = reqMem.dob;
        mem.Gender__c = reqMem.gender;
        mem.City__c = reqMem.city;
        mem.State__c = reqMem.state;
        mem.ZipCode__c = reqMem.zipcode;
        mem.Packages__c = reqMem.packages;
    
        try{
        insert mem;
         if(mem.id!=null){ 
            resp.status='successful';
            resp.statusMsg='Created Successfully';
         }
         else{
            resp.status='Failed';
            resp.statusMsg='Not Created Successfully';
         }
        }
        catch(exception e){}
        
        return resp;
      }

global class requestMember{
    
    public string firstname;
    public string lastname;
    public string mobileno;
    public string email;
    public date dob;
    public string gender;
    public string city;
    public string state;
    public string zipcode;
    public string packages;     
}
    
 global class reponseMember{    
    public string status;
    public string statusMsg;            
  }
    
}