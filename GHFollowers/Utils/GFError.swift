//
//  GFError.swift
//  GHFollowers
//
//  Created by Victor Chang on 02/02/2024.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete request. Please check your internet conection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again"
    case unaibleToFavorite = "There was an error favoriting this user. Please try again"
    case alreadyFavorited = "This user is already in Favorites"
}
