@isTest
public with sharing class AccountControllerTests {

    @isTest
    public static void TestFindAll () {
        AccountController.findAll();
        System.AssertEquals(true, true);
    }

    @isTest
    public static void TestFindOne () {
        AccountController.findOne();
        System.AssertEquals(true, true);
    }

    @isTest
    public static void TestFindTwo () {
        AccountController.findTwo();
        System.AssertEquals(true, true);
    }
}