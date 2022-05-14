trigger UpdateParentCost on Product_Sample_Sale__c (after insert, after update, after delete) {

    if (Trigger.isDelete) {

         for (Product_Sample_Sale__c co: Trigger.old) {

            // Parent megszerzése
            GiftBoxSale__c sale = [SELECT Id, Cost_of_Samples__c FROM GiftBoxSale__c WHERE Id = :co.GiftBoxSale__c];

            //A parent gyermekeinek megszerzése
            List<Product_Sample_Sale__c> children = new List<Product_Sample_Sale__c>();
            children = [SELECT Id, Quantity__c, GisftBoxProduct__c FROM Product_Sample_Sale__c WHERE GiftBoxSale__c = :sale.Id];

            Decimal totalCost = 0;
            for (Product_Sample_Sale__c pco : children) {

                GisftBoxProduct__c product = [SELECT Id, Purchase_Price__c FROM GisftBoxProduct__c WHERE Id= :pco.GisftBoxProduct__c];
                totalCost += (product.Purchase_Price__c * pco.Quantity__c);
            }
            
            sale.Cost_of_Samples__c = totalCost;
            update sale;

        }
    }


    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Product_Sample_Sale__c co: Trigger.new) {

            // Parent megszerzése
            GiftBoxSale__c sale = [SELECT Id, Cost_of_Samples__c FROM GiftBoxSale__c WHERE Id = :co.GiftBoxSale__c];

            //A parent gyermekeinek megszerzése
            List<Product_Sample_Sale__c> children = new List<Product_Sample_Sale__c>();
            children = [SELECT Id, Quantity__c, GisftBoxProduct__c FROM Product_Sample_Sale__c WHERE GiftBoxSale__c = :sale.Id];

            Decimal totalCost = 0;
            for (Product_Sample_Sale__c pco : children) {

                GisftBoxProduct__c product = [SELECT Id, Purchase_Price__c FROM GisftBoxProduct__c WHERE Id= :pco.GisftBoxProduct__c];
                totalCost += (product.Purchase_Price__c * pco.Quantity__c);
            }

            sale.Cost_of_Samples__c = totalCost;
            update sale;

        }
    }

    
}