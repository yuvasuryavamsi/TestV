@RestResource(urlMapping='/v1/chiefcomplaints/*')
global class CallMD_IVRChiefComplaints {
    
    @HttPGet
    global static responseComplaints CompliantsSuggestions(){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        responseComplaints resp=new responseComplaints();
        
        List<string> comp=new List<string>();
        
        string str='%'+req.params.get('name')+'%';
        
        List<Chief_Complaint_Symptoms__c> lstComp=[SELECT id,Name FROM Chief_Complaint_Symptoms__c WHERE Name LIKE:str];
        if(!lstComp.isEmpty()){
          for(Chief_Complaint_Symptoms__c cSym:lstComp){
            comp.add(cSym.Name);
          }
            resp.compliantName=comp;
            resp.status='success';
        }
        else{
           resp.status='No Result Found' ;
        }
        return resp;
    }
    
    global class responseComplaints{
        
       public List<string> compliantName;  
       public string status;
    }

}