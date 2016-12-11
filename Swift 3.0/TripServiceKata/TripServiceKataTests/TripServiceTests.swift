//
//  TripServiceTests.swift
//  TripServiceKata
//
//  Created by Saqib Saud on 11/22/16.
//  Copyright © 2016 Alessandro Benvenuti. All rights reserved.
//

import XCTest
@testable import TripServiceKata

private var loggedInUser:User?

class TripServiceTests: XCTestCase {
    
    private static let GUEST:User? = nil
    private static let UNUSED_USER:User = User()
    private static let REGISTERED_USER:User = User()
    private static let ANOTHER_USER:User = User()
    private static let TO_BRAZIL = Trip()
    private static let TO_LONDON = Trip()
    
    private var tripService:TestableTripService?
    
    override func setUp() {
        super.setUp()
        tripService = TestableTripService()
        loggedInUser = TripServiceTests.REGISTERED_USER

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
    }
    
    func testPerformanceExample() {
        self.measure {
            
        }
    }
    
    func test_should_throw_exception_when_user_is_not_logged_in(){
        loggedInUser = TripServiceTests.GUEST
        
        XCTAssertThrowsError(try tripService?.GetTripsByUser(TripServiceTests.UNUSED_USER), "Test did not threw exception when user is not logged in") { error in
            XCTAssertEqual(error as! TripServiceErrorType, TripServiceErrorType.userNotLoggedIn)
        }
    }
    
    func test_should_not_return_any_trips_when_users_are_not_friends() {
        let friend = User()
        friend.addFriend(TripServiceTests.ANOTHER_USER)
        friend.addTrip(TripServiceTests.TO_BRAZIL)
        
        let friendTrips =  try! tripService?.GetTripsByUser(friend)
        
        assert((friendTrips == nil) || friendTrips?.count == 0, "Test returned some trips")
 
    }
    
    func test_should_return_friend_trips_when_user_are_friends(){
        let friend = User()
        friend.addFriend(TripServiceTests.ANOTHER_USER)
        friend.addFriend(loggedInUser!)
        friend.addTrip(TripServiceTests.TO_BRAZIL)
        friend.addTrip(TripServiceTests.TO_LONDON)
    
        let friendTrips = try! tripService?.GetTripsByUser(friend)
        
        assert((friendTrips != nil) || friendTrips?.count == 2, "Test failed to get 2 trips ")
    }
    
    private class TestableTripService: TripService {
        internal override func getLoggedInUser() throws -> User? {
            return loggedInUser
        }
        
        internal override func tripsBy(user:User) throws -> [Trip]? {
            return user.trips()
        }
    }
}
