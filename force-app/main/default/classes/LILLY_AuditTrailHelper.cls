/**
 * @description       : Utility methods for the Audit Trail functionality
 * @author            : zoltan.nagy@veeva.com
 * @group             : 
 * @last modified on  : 05-14-2022
 * @last modified by  : zoltan.nagy@veeva.com
**/
public class LILLY_AuditTrailHelper {

    private static Map<String, CMDWrapper> configMap;

    /**
    * @description returns the Schema SObjecType instance of the given record
    * @author zoltan.nagy@veeva.com | 05-14-2022 
    * @param SObject item 
    * @return Schema.SObjectType 
    **/
    public static Schema.SObjectType getObjectType(SObject item) {

        if(item.Id == null) {
            return null;
        }

        return item.Id.getSObjectType();

    }

    /**
    * @description 
    * @author zoltan.nagy@veeva.com | 05-15-2022 
    * @param SObject item 
    * @return String 
    **/
    public static String getObjectName(SObject item) {

        Schema.SObjectType objectType = getObjectType(item);
        return objectType.getDescribe().getName();

    }

    /**
    * @description 
    * @author zoltan.nagy@veeva.com | 05-15-2022 
    * @param String objectName 
    * @return Boolean 
    **/
    public static Boolean isCDC(String objectName) {

        CMDWrapper cmd = getConfig(objectName);

        if (cmd == null) {
            return null;
        }

        return cmd.isCDC;
    }


    /**
    * @description 
    * @author zoltan.nagy@veeva.com | 05-15-2022 
    * @param String objectName 
    * @return String 
    **/
    public static String getTargetObjectName(String objectName) {

        CMDWrapper = getConfig(objectName);

        if (cmd = null || String.isBlank(cmd.targetObject)) {
            return null;
        }

        return cmd.targetObject;
    }



    /**
    * @description 
    * @author zoltan.nagy@veeva.com | 05-15-2022 
    * @param String objectName 
    * @return List<String> 
    **/
    public static List<String> getBlacklistedFields(String objectName) {

        CMDWrapper cmd = getConfig(objectName);

        if (cmd == null || String.isBlank(cmd.fieldBlackList)) {
            return null;
        }

        return cmd.fieldBlackList.split(',');
    }


    /**
    * @description 
    * @author zoltan.nagy@veeva.com | 05-15-2022 
    * @param String objectName 
    * @return CMDWrapper 
    **/
    public static CMDWrapper getConfig(String objectName) {

        if (configMap == null) {
            configMap = new Map<String, CMDWrapper>();
        }

        if (!configMap.containsKey(getObjectName(item))) {

            CMDWrapper cmd = new CMDWrapper();
            cmd.sourceObject = 'Account';
            cmd.targetObject = 'TargetObject';
            cmd.fieldBlackList = 'Name,Id';
            cmd.isActive = true;
            cmd.isCDC = false;

            configMap.put(item, cmd);
            
        }

    }


    public class CMDWrapper {
        public String sourceObject;
        public String targetObject;
        public String fieldBlackList;
        public Boolean isCDC;
        public Boolean isActive;
    }

}
