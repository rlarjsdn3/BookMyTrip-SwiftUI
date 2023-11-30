//
//  BaseServiceP.swift
//  AppleMusicSearch
//
//  Created by 김건우 on 11/30/23.
//

import Foundation

class BaseService {
    unowned let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}
