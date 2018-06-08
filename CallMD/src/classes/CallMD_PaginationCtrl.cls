public class CallMD_PaginationCtrl {

        Public String firstname{get;set;}
        Public String lastname{get;set;}
        Public String phone{get;set;}
        Public string status{get;set;}
        Public string licenseState{get;set;}
        public List<Doctor__c> doctorsList {get;set;}
       
        List<string> conditions = new List<string>();
        private integer totalRecs = 0;
        private integer OffsetSize = 0;
        private integer LimitSize= 10;

        Public PageReference p;
        Public PageReference NavigateToDoctor(){
        
            p=new PageReference('/apex/CallMD_Doctor');
            p.setRedirect(true);
            return p;
        }
        
       public void searchSobject(){
            totalRecs = 0;
            OffsetSize = 0;
            /* if(doctorsList !=null && doctorsList.size()>0){
                doctorsList=null;
            } */
            searchSobjects();
            conditions.clear();
        }
        
        public Void searchSobjects(){

            if(doctorsList != null && !doctorsList.isEmpty()){
                doctorsList.clear();
            }
            String strQuery ='SELECT Id,Name,Last_Name__c,Status__c,InActive_Licenses__c,Username__c,Email__c,Primary_Phone__c,Secondary_Phone__c,Date_Of_Birth__c,License_States__c,Product_Type__c FROM Doctor__c';
           
            if(firstname !=null && firstname!=''){
                conditions.add('Name Like \'%' +firstname +'%\' ');
            }
            
            if(lastname !=null && lastname!=''){
                conditions.add('Last_Name__c Like \'%' +lastname +'%\' ');
            }
            
            if(phone !=null &&  phone!=''){
                conditions.add('Secondary_Phone__c Like \'%'+phone+'%\' ');
            }
            
            if(status!=null && status!=''){
                conditions.add('Status__c Like \'%'+status+'%\' ');
            }
            
            /* if(LicenseState !=null && LicenseState !=''){
                conditions.add('License_States__c  includes \'%' +licenseState+'%\' ');
            } */
            
            
            if (conditions.size() > 0) {
                strQuery += '  WHERE ' + conditions[0];
                for (Integer i = 1; i < conditions.size(); i++)
                    strQuery += '  AND ' + conditions[i];
            }
            if(totalRecs !=null && totalRecs ==0){
                List<Doctor__c> accTemp = Database.query(strQuery);
                totalRecs = (accTemp !=null &&accTemp.size()>0)?accTemp.size():0;
            }
        
            strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSize OFFSET :OffsetSize';
            doctorsList  =Database.query(strQuery);
        }
        
        public void first()
        {
            OffsetSize = 0;
            searchSobjects();
        }
        public void previous()
        {
            OffsetSize = (OffsetSize-LimitSize);
            searchSobjects();
        }
        public void next()
        {
            OffsetSize = OffsetSize + LimitSize;
            searchSobjects();
        }
        public void last()
        {
            OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
            searchSobjects();
        }
        public boolean getHasPrevious()
        {
            Boolean res1;
            if(OffsetSize == 0){
                
                res1=true;
            }
            
            return res1;
        }
        public boolean getHasNext()
        {
            Boolean res1;
            if((OffsetSize + LimitSize) > totalRecs){
                
                res1=true;
            }
            
            return res1;
       
        }
   }