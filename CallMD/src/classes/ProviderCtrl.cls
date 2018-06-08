public class ProviderCtrl {
    
    Public Providers__c prov{get;set;}
    Public string ProgramStatus {get;set;}
    Public String ProviderStatus {get;set;}
    Public String ProviderName{get;set;}
    Private string ProviderId;
    public List<Providers__c> providersList {get;set;}
    Public List<string> conditions = new List<string>();
    private integer totalRecs = 0;
    private integer OffsetSize = 0;
    private integer LimitSize= 10;
    public string filename{get;set;}
    public transient blob filebody{get;set;}
    
   
    
    public String mode{
    get{
        return ApexPages.CurrentPage().getParameters().get('mode');
    }set; }
    
    public ProviderCtrl(ApexPages.StandardController controller) {
        prov=(Providers__c)controller.getRecord();
        ProviderId=controller.getId();
        if(ProviderId!=null){
            Programs=[SELECT id,Name,Name__c,Programs__r.Program_Name__c,Program_Name__c,Program_Status__c,
                                 Pricing__c,Copay_Yes_No__c,Copay__c,No_of_Consultations__c, Free_Consultations__c,
                                 Product__c, Provider_Name__c,Parent_Program_Name__c,Providers__c
                                 FROM Programs__c 
                                 WHERE Providers__c=:ProviderId];
        }
    }
    
    Public pageReference p;
    Public pageReference Save(){
        try{
            insert prov;
            p=new PageReference('/apex/CallMD_Provider');
            p.getParameters().put('id',prov.id);
            p.getParameters().put('mode','s');
            p.setRedirect(true);
        }
        catch(exception e){
        }
        return p;
    }
    
    Public PageReference updateProv(){
        try{
            update prov;
            p=new PageReference('/apex/CallMD_Provider');
            p.getParameters().put('id',ProviderID);
            p.getParameters().put('mode','s');
            p.setRedirect(true);
        }
        catch(Exception e){}
        return p;
    }
    
    Public List<Programs__c> Programs;
    Public List<Programs__c> getProgramList(){
        return programs;
    }
    
    Public Void ChangeProgramStatus(){
        Programs=[SELECT id,Programs__r.Name,Name,Program_Status__c,No_of_Consultations__c,
                            Pricing__c,Copay_Yes_No__c,Copay__c, Providers__c,Free_Consultations__c,
                            Product__c,Provider_Name__c,Parent_Program_Name__c
                            FROM Programs__c 
                            WHERE Providers__c=:ProviderId AND Program_Status__c=:ProgramStatus];
    }
    
    Public PageReference NavigateToProvider(){
        p=new pageReference('/apex/CallMD_Provider');
        p.setRedirect(true);
        return p;
    }
    
    public void clear(){
        ProviderName='';
        ProviderStatus='';
        searchSobject();
    }
    
    Public pageReference Edit(){
        p=new PageReference('/apex/CallMD_Provider');
        p.getParameters().put('id',ProviderId);
        p.getParameters().put('mode','e');
        p.getParameters().put('retPageName','CallMD_Provider');
        p.setRedirect(true);
        return p;
    }
    
    Public pageReference cancel(){
        p=new PageReference('/apex/CallMD_Provider');
        p.getParameters().put('id',ProviderId);
        p.getParameters().put('mode','s');
        p.getParameters().put('retPageName','CallMD_Provider');
        p.setRedirect(true);
        return p;
    }
    
    public void upload(){
    
      Attachment att = new Attachment();
      att.Name=filename;
      att.body=filebody;
      att.parentId=ProviderId;
      insert att;
    
    }
    
    public List<Attachment> getDocList(){
    
    
      List<Attachment> attachList;
    
      if(string.isNotEmpty(providerId)){
      
         attachList = [SELECT id,Name FROM Attachment WHERE ParentId =: ProviderId];
      }
      
      return attachList;
    
    
    }
    
    
    public void searchSobject(){
        totalRecs = 0;
        OffsetSize = 0;
        if(providersList!=null && providersList.size()>0){
            ProvidersList=null;
        }
        
        searchSobjects(); 
        //conditions.clear();  
    }
    
    public Void searchSobjects(){
        
        if(providersList!= null && !providersList.isEmpty()){
            providersList.clear();
        }
        String strQuery ='SELECT id,Name,Name__c,Deactivate__c,Started_Date__c,Address_Line1__c,Address_Line2__c,City__c,State__c,ZipCode__c,Phone1__c,Phone2__c,Fax__c,Email__c,Contact_Person__c,Home_Page__c,Status__c FROM Providers__c';  
        if(ProviderName!=null && ProviderName!=''){
            conditions.add('Name Like \'%' +ProviderName +'%\' ');
        }
        if(ProviderStatus!=null && ProviderStatus!=''){
            conditions.add('Status__c Like \'%' +ProviderStatus +'%\' ');
        }
        if(conditions.size() > 0) {
            strQuery += '  WHERE ' + conditions[0];
            for (Integer i = 1; i < conditions.size(); i++)
                strQuery += '  OR ' + conditions[i];
        }
        if(totalRecs !=null && totalRecs ==0){
            List<Providers__c> accTemp = Database.query(strQuery);
            totalRecs = (accTemp !=null &&accTemp.size()>0)?accTemp.size():0;
        }
        strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSize OFFSET :OffsetSize';
        providersList =Database.query(strQuery);
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