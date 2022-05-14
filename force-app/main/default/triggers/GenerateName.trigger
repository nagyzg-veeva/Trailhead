/**
 *  GiftBox Sale generated names.
 *  <Account name>__<date>__<user given suffix>
 */

trigger GenerateName on GiftBoxSale__c (before insert) {
    for (GiftBoxSale__c sale: Trigger.new) {
        
        String name_suffix = sale.name;
        
        //getting parent account
        Account account = [SELECT Id, Name FROM Account WHERE Id = :sale.Account__c];
        
        sale.name = account.name + '__' + date.today().format() + ' ' + name_suffix;

    }
}