public class passingParametersCtrl {

  public string category{get;set;}
  
  
  
  public void send(){
  
     category=ApexPages.CurrentPage().getParameters().get('s');
  
    system.debug('Category Value:: '+category);  
    system.debug(ApexPages.CurrentPage().getParameters().get('s'));
  }

}