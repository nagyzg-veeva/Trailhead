public class LILLY_AuditTrailAsyncWorker implements Queueable{

    Map<Id, SObject> oldItemsMap;
    Map<Id, SObject> newItemsMap;

    public LILLY_AuditTrailAsyncWorker(Map<Id, SObject> oldItemsMap, Map<Id, SObject> newItemsMap) {
        this.oldItemsMap = oldItemsMap;
        this.newItemsMap = newItemsMap;
    }

    public void execute(QueueableContext context) {

    }

}
