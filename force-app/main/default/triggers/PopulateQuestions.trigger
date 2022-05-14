trigger PopulateQuestions on Customer_Satisfaction_Interview__c (before insert, before update) {
    
    if (Trigger.isInsert) {
        for (Customer_Satisfaction_Interview__c interview: Trigger.new) {
        
            //A szülő rekord beszerzése
            Questionnaire__c questionnaire = [
                SELECT Id, Name, Question_1__c, Question_2__c, Question_3__c, Question_4__c, Question_5__c
                FROM Questionnaire__c WHERE Id = :interview.Questionnaire__c
            ];
    
            interview.Question_1__c = questionnaire.Question_1__c;
            interview.Question_2__c = questionnaire.Question_2__c;
            interview.Question_3__c = questionnaire.Question_3__c;
            interview.Question_4__c = questionnaire.Question_4__c;
            interview.Question_5__c = questionnaire.Question_5__c;
            
            //Névgenerálás - Szülő Account beszerzése
            Account account = [SELECT Id, Name FROM Account WHERE Id = :interview.Account__c];
            interview.Name = account.name + '__' + questionnaire.Name + '__' +  date.today().format();
    
        }
    }

    if (Trigger.isUpdate) {

        for (Customer_Satisfaction_Interview__c interview: Trigger.new) {

            Integer numberOfValues = 0;
            Integer sumOfValues = 0;

            List<String> sourceFields = new List<String> {'Answer_1__c', 'Answer_2__c', 'Answer_3__c', 'Answer_4__c', 'Answer_5__c'};

            for (String field: sourceFields) {
                if (interview.get(field) != null) {
                    numberOfValues++;
                    sumOfValues += Integer.valueOf(interview.get(field));
                }
            }

            interview.Score__c = (Decimal) sumOfValues / numberOfValues;
            //interview.Score__c = numberOfValues;

        }

    }

}