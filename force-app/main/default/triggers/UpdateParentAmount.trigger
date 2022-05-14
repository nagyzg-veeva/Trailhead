trigger UpdateParentAmount on GiftBox_Product_Sale__c (after insert, after update, after delete) {

    if (Trigger.isInsert || Trigger.isUpdate) {

        for (GiftBox_Product_Sale__c giftBoxProductSale: Trigger.new) {

            //Parent
            GiftBoxSale__c giftBoxSale = [SELECT Id, Amount__c FROM GiftBoxSale__c WHERE Id = :giftBoxProductSale.GiftBox_Sale__c];
            
            // A parent összes gyermekének beszerzése majd iterációban az amount összegzése
            List<GiftBox_Product_Sale__c> childrenProductSales = [SELECT Id, GiftBox_Product__c ,Quantity__c FROM GiftBox_Product_Sale__c WHERE GiftBox_Sale__c = :giftBoxSale.Id];

            Decimal amount = 0;

            for (GiftBox_Product_Sale__c cGiftBoxProductSale: childrenProductSales) {

                //Kell a termék eladási ára a parent reláción keresztül
                GisftBoxProduct__c product = [SELECT Id, Sell_Price__c FROM GisftBoxProduct__c WHERE Id = :cGiftBoxProductSale.GiftBox_Product__c];
                amount += (product.Sell_Price__c * cGiftBoxProductSale.Quantity__c);

            }

            giftBoxSale.Amount__c = amount;
            update giftBoxSale;
        }

    }

    if (Trigger.isDelete) {

            for (GiftBox_Product_Sale__c giftBoxProductSale: Trigger.old) {

            //Parent
            GiftBoxSale__c giftBoxSale = [SELECT Id, Amount__c FROM GiftBoxSale__c WHERE Id = :giftBoxProductSale.GiftBox_Sale__c];
            
            // A parent összes gyermekének beszerzése majd iterációban az amount összegzése
            List<GiftBox_Product_Sale__c> childrenProductSales = [SELECT Id, GiftBox_Product__c ,Quantity__c FROM GiftBox_Product_Sale__c WHERE GiftBox_Sale__c = :giftBoxSale.Id];

            Decimal amount = 0;

            for (GiftBox_Product_Sale__c cGiftBoxProductSale: childrenProductSales) {

                //Kell a termék eladási ára a parent reláción keresztül
                GisftBoxProduct__c product = [SELECT Id, Sell_Price__c FROM GisftBoxProduct__c WHERE Id = :cGiftBoxProductSale.GiftBox_Product__c];
                amount += (product.Sell_Price__c * cGiftBoxProductSale.Quantity__c);

            }

            giftBoxSale.Amount__c = amount;
            update giftBoxSale;
        }
    }

}