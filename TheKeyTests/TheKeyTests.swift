//
//  TheKeyTests.swift
//  TheKeyTests
//
//  Created by Gabriel Maia Vinagre Costa on 16/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import XCTest
@testable import TheKey

class TheKeyTests: XCTestCase {
    
    var loginUnderTest: String!
    var userInfo: UserInfo!
    var secret: Secret!
    
    override func setUp() {
        super.setUp()
        
        self.loginUnderTest = "teste1234"
        self.userInfo = UserInfo(username: "usuario1@gmail.com", name: "usuario1", password: "senhaDoApp")
        self.secret = Secret(name: "site1", username: "name1", password: "senha1")
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.loginUnderTest = nil
        DataManager.deleteAllSecrets(username: userInfo.getUsername())
        self.userInfo = nil
        self.secret = nil
        
    }
    
    func testIfPasswordIsValid() {
        
        XCTAssertEqual(loginUnderTest.isValidPassword(), false, "Function are not validating correctly the password")
    }
    
    func testIfSecretAreSaving() {
        
        var quantityOfSecrets = DataManager.getAllData(username: self.userInfo.getUsername()).count
        XCTAssertEqual(quantityOfSecrets, 0, "Secret save function are not get all correctly quantity of secrects")
        
        DataManager.saveData(username: self.userInfo.getUsername(), secret: secret)
        
        quantityOfSecrets = DataManager.getAllData(username: self.userInfo.getUsername()).count
        XCTAssertEqual(quantityOfSecrets, 1, "Secret save function are not get all correctly quantity of secrects")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
