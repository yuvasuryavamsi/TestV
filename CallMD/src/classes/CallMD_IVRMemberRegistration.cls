@RestResource(urlMapping='/v1/MemberRegistration/*')
global class CallMD_IVRMemberRegistration {
    
    @HttPPost
    global static registrationResponse memberRegistration(string firstname,string lastname,string cellphone,string city,string email,string gender,string zipcode,String DateOfBirth){
        registrationResponse res=new registrationResponse();
            
        Member__c mem=new Member__c();
        mem.FirstName__c=firstname;
        mem.LastName__c=lastname;
        mem.Cell_Phone__c=cellphone;
        mem.DateofBirth__c=Date.Parse(DateOfBirth);
        mem.City__c=city;
        mem.Email__c=email;
        mem.Gender__c=gender;
        mem.ZipCode__c=zipcode;
       
        insert mem;
        if(mem.id!=null){
        res.statusmsg='success';
        res.memberId=mem.id;
        }
        else{
          res.statusmsg='failure';   
        }
        return res;
        
    }
    
    global class registrationResponse{
        
       public string statusmsg;
       public string memberId;
    }

}