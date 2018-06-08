@RestResource(urlMapping='/v1/doctorstatetime')
global class CallMD_IVRDRStateByTime {
    
    
    @HttPGet
    global static responseStatesTime doGetStates(){
        
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        responseStatesTime statesTime=new responseStatesTime();
        
        try{
            List<Doctor__c> docList=[SELECT Name,State__c FROM Doctor__c 
                                     WHERE State__c=:req.params.get('state')];
            if(!docList.isEmpty()){
                statesTime.doctor=docList;
                statesTime.status='200';
                statesTime.statusmsg='success';
            }
            else{ 
                statesTime.doctor=null;
                statesTime.status='200';
                statesTime.statusmsg='No Doctor Found'; 
            }
        }
        catch(exception e){} 
        
        return statesTime;
        
    }
    
    global class responseStatesTime{
        Public List<Doctor__c> doctor;
        public string status;
        Public string statusmsg;
    }
    
    
}