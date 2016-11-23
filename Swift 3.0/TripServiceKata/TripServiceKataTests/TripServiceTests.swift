//
//  TripServiceTests.swift
//  TripServiceKata
//
//  Created by Saqib Saud on 11/22/16.
//  Copyright © 2016 Alessandro Benvenuti. All rights reserved.
//

import XCTest
@testable import TripServiceKata

class TripServiceTests: XCTestCase {
    
    func test_should_throw_exception_when_user_is_not_logged_in(){
        let tripService = TestabelTripService()
        let user = User()
        
        do {
            try tripService.GetTripsByUser(user)
        } catch {
            XCTFail("Exception: \(error)")
            return
        }
    }
    
    private class TestabelTripService: TripService {
        internal override func getLoggedInUser() throws -> User? {
            return nil
        }
    }
}
