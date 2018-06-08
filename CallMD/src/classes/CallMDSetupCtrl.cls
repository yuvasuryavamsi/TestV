public class CallMDSetupCtrl {

  Public Member__c memData;
  
  Private String MemberId=ApexPages.CurrentPage().getParameters().get('mid');
  
  Public CallMDSetupCtrl(){
  
     memData=new Member__c();
  }
  
  
  Public Member__c getMemDetails(){
  
  /* if(MemberId!=NULL){
    memData=[SELECT FirstName__c,LastName__c,DateofBirth__c,Cell_Phone__c,State__c 
                    FROM Member__c];
                    
  } */
  
  try{
  if(MemberID!=NULL){
  
    memData=[SELECT id,FirstName__c,LastName__c,DateofBirth__c,Cell_Phone__c,State__c,CallMDUserName__c,Name,isMemberPin__c,Email__c,
                    Member_Pin__c,Confirm_Member_Pin__c,Pin__c  
                    FROM Member__c WHERE ID=:MemberId];
  }
    }
    catch(Exception e){
    
    }
   
    return memData;
  
  }
  
  
  
  Public PageReference p;
  
  Public PageReference ConfirmMember(){
  
  try{
   memData=[SELECT id,Name,FirstName__c,LastName__c,DateofBirth__c,Cell_Phone__c,State__c,CallMDUserName__c 
                    FROM Member__c
                    WHERE FirstName__c=:memData.FirstName__c AND LastName__c=:memData.LastName__c 
                    AND DateofBirth__c=:memData.DateofBirth__c AND (Cell_Phone__c=:memData.Cell_Phone__c
                    OR State__c=:memData.State__c)];
   if(memData!=NULL){
    
    p=new PageReference('/apex/CallMDSetupConfirmPassword');
    p.getParameters().put('mid',memData.id);
    p.setRedirect(true);
   }
  }  
 
  Catch(Exception e){
    memData.Status__c='Active';
    memData.Pin__c=memData.Confirm_Member_Pin__c;
     insert memData;
     p=new PageReference('/apex/CallMDSetupConfirmPassword');
    p.getParameters().put('mid',memData.id);
    p.setRedirect(true);
     
   }
   
   
   return p;
  }
  
  Public PageReference Confirm(){
  
   try{
   if(memData!=NULL){
    memData.isMemberPin__c=true;
    memData.Pin__c=memData.Confirm_Member_Pin__c;
    update memData;
    p=new PageReference('/apex/CallMDSetupThankYou');
    p.getParameters().put('mid',memData.id);
    p.setRedirect(true);
   }
   }
   catch(Exception e){
   
   }
   
   return p;
  
    
  }

}