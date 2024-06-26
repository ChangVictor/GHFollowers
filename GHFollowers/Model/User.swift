//
//  User.swift
//  GHFollowers
//
//  Created by Victor Chang on 01/02/2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let followers: Int
    let following: Int
    let createdAt: Date
}
