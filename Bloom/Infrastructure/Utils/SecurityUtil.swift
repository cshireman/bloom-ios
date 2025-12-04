//
//  SecurityUtil.swift
//  Bloom
//
//  Created by Chris Shireman on 11/29/25.
//

import Foundation

class SecurityUtil {
    static let shared = SecurityUtil()

    func hardenCache() {
        let memoryCapacity = 4 * 1024 * 1024 // 4 MB
        let diskCapacity = 0 // Disable disk caching
        let sharedCache = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            diskPath: nil
        )
        URLCache.shared = sharedCache
        URLCache.shared.removeAllCachedResponses() // optional cleanup
    }
}
