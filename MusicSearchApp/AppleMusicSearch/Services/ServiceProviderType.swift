//
//  ServiceProviderType.swift
//  AppleMusicSearch
//
//  Created by 김건우 on 11/30/23.
//

import Foundation

protocol ServiceProviderType: AnyObject {
    var musicAPIService: MusicAPIServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var musicAPIService: MusicAPIServiceType = MusicAPIService(provider: self)
}

