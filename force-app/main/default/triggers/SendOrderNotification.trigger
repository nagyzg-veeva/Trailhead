trigger SendOrderNotification on GiftBoxSale__c (before update, before insert) {

    String warehouseEmail = 'nagyzg@gmail.com';
    String subject = 'GiftBox order confirmation';
    String body_customer = 'Your order is processed, Delivery could be expected within 2 working days';
    
    for (GiftBoxSale__c sale: Trigger.new) {
        
        Account acc = [SELECT Id, Name, Notification_Email_Address__c FROM Account WHERE Id= :sale.Account__c];
        
        if (Trigger.isInsert && sale.Stage__c == 'Closed Won') {
            
            String body_warehouse = 'Order to deliver: ' + sale.Name + ' - ' + sale.Id;
            
            CustomEmailManager.sendEmail(acc.Notification_Email_Address__c, subject, body_customer);
            CustomEmailManager.sendEmail(warehouseEmail, subject, body_warehouse);
        }
        
        if (Trigger.isUpdate) {
            
            GiftBoxSale__c oldSale = Trigger.oldMap.get(sale.ID);
            if (sale.Stage__c == 'Closed Won' && oldSale.Stage__c == 'In-Progress') {
                
                String body_warehouse = 'Order to deliver: ' + sale.Name + ' - ' + sale.Id;
                
                CustomEmailManager.sendEmail(acc.Notification_Email_Address__c, subject, body_customer);
                CustomEmailManager.sendEmail(warehouseEmail, subject, body_warehouse);
              
            } 
        }
    }
}