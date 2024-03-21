//
//  Constans.swift
//  GHFollowers
//
//  Created by Victor Chang on 28/02/2024.
//

import UIKit

enum SFSymbols {
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let repos = UIImage(systemName: "repos")
    static let gists = UIImage(systemName: "text.alignleft")
    static let followers = UIImage(systemName: "herat")
    static let following = UIImage(systemName: "person.2")
}

enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
    static let placeHolder = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceType {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale
    
    static let isiphoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiphone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiphone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiphone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiphone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    static func isihoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
