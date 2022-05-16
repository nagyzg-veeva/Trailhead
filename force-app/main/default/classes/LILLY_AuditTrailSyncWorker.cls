public class LILLY_AuditTrailSyncWorker {

    Map<Id, SObject> oldItemsMap;
    Map<Id, SObject> newItemsMap;

    public LILLY_AuditTrailSyncWorker(Map<Id, SObject> oldItemsMap, Map<Id, SObject> newItemsMap) {

    }

    public Boolean recordChanges() {

        Schema.SObjectType objectType = LILLY_AuditTrailHelper.getObjectType(oldItemsMap.values().get(0));
        String objectName  = LILLY_AuditTrailHelper.getObjectName(oldItemsMap.values().get(0));


        //2. get config

        //3.

        //4. collect changes

        //5 get target record type

        //6. generate target record instances

        return true;

    }
}
