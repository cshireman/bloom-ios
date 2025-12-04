//
//  BloomApp.swift
//  Bloom
//
//  Created by Chris Shireman on 11/25/25.
//

import SwiftUI

@main
struct BloomApp: App {
    init() {
        SecurityUtil.shared.hardenCache()
    }

    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
