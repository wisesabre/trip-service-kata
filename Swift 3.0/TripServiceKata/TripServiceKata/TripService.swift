//
//  TripService.swift
//  TripServiceKata
//
//  Created by Alessandro Benvenuti on 21/02/2016.
//  Copyright © 2016 Alessandro Benvenuti. All rights reserved.
//

import Foundation

class TripService
{
    func GetTripsByUser(_ user:User) throws -> [Trip]?
    {
        var tripList:[Trip]? = nil
        let loggedUser = try getLoggedInUser()
        
        var isFriend = false
        
        if let loggedUser = loggedUser {
            for friend in user.getFriends() {
                if friend == loggedUser {
                    isFriend = true
                    break
                }
            }
            if isFriend {
                tripList = try! tripsBy(user: user)
            }
            return tripList
        }
        else {
            throw TripServiceErrorType.userNotLoggedIn
        }
    }
    
    internal func getLoggedInUser() throws -> User? {
        return try UserSession.sharedInstance.getLoggedUser()
    }
    
    internal func tripsBy(user:User) throws -> [Trip]? {
        return try TripDAO.findTripsByUser(user)
    }
}
