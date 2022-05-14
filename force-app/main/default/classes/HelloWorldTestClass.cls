@isTest
private class HelloWorldTestClass {
    
    @isTest
    private static void validateHelloWorld() {
        
        Book__c book = new Book__c();
        book.Name = 'Behind The Cloud';
        book.Price__c = 100;
        
        System.debug('Price before inserting new book: ' + book.Price__c);
        
        insert book;
        
        Book__c savedBook = new Book__c();
        savedBook = [SELECT Price__c FROM Book__c WHERE Id = :book.Id];
        System.debug('Price after trigger fired: ' + savedBook.Price__c);
        
        System.assertEquals(90, savedBook.Price__c);
        
    }
}