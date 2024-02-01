//
//  User.swift
//  GHFollowers
//
//  Created by Victor Chang on 01/02/2024.
//

import Foundation

struct User: Codable {
    var id: Int
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var followers: Int
    var following: Int
    var createdAt: String
}
