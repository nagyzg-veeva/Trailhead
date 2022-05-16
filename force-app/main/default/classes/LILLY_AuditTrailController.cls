/**
 * @description       : Audit Trail
 * @author            : zoltan.nagy@veeva.com
 * @group             : 
 * @last modified on  : 05-14-2022
 * @last modified by  : zoltan.nagy@veeva.com
**/
public class LILLY_AuditTrailController {

    /**
    * @description Directs the audit trail task to the corresponding worker, depending on the system context
    * @author zoltan.nagy@veeva.com | 05-14-2022 
    * @param Map<Id SObject> oldItemsMap 
    * @param Map<Id Sobject> newItemsMap 
    **/
    public static void routeAuditFlow(Map<Id, SObject> oldItemsMap, Map<Id, Sobject> newItemsMap) {

        Boolean asyncContext = (System.isFuture() || System.isQueueable() || System.isBatch());

        if (asyncContext) {
            LILLY_AuditTrailSyncWorker syncWorker = new LILLY_AuditTrailSyncWorker(oldItemsMap, newItemsMap);
            syncWorker.recordChanges();
        }

        if (!asyncContext) {

            if (Limits.getQueueableJobs() > 5) {
                System.enqueueJob(new LILLY_AuditTrailAsyncWorker(oldItemsMap, newItemsMap));
            }
        }

    }

}
