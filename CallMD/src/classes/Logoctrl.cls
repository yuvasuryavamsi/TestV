public class Logoctrl 
{
    public string LogoName{get;set;}
    public transient blob LogoBody{get;set;}
    private string recordID;
    
    public Logoctrl(ApexPages.StandardController controller) {
        recordID=controller.getID();
    }
    public pagereference upload(){
        Attachment att=new Attachment();
        att.Name=LogoName;
        att.Body=LogoBody;
        att.parentID=RecordID;
        insert att;
        Providers__c p=new Providers__c();
        p.id=recordid;
        p.Logo_ID__c=att.id;
        update p;
        return null;
    }
    
    
}