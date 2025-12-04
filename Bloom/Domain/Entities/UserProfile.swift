//
//  UserProfile.swift
//  Bloom
//
//  Created on 2025-12-03.
//

import Foundation

/// Represents a user's profile and account information
struct UserProfile {
    let id: String
    let email: String
    let displayName: String
    let createdAt: Date
    let subscriptionTier: SubscriptionTier
    let wellnessGoals: [String]
    var checkInStreak: Int

    init(
        id: String,
        email: String,
        displayName: String,
        createdAt: Date = Date(),
        subscriptionTier: SubscriptionTier = .free,
        wellnessGoals: [String] = [],
        checkInStreak: Int = 0
    ) {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.createdAt = createdAt
        self.subscriptionTier = subscriptionTier
        self.wellnessGoals = wellnessGoals
        self.checkInStreak = checkInStreak
    }
}

/// User subscription tier
enum SubscriptionTier: String, Codable {
    case free
    case premium

    var maxHabits: Int {
        switch self {
        case .free: return 3
        case .premium: return 10
        }
    }

    var maxAIInsightsPerWeek: Int? {
        switch self {
        case .free: return 5
        case .premium: return nil // unlimited
        }
    }

    var hasAdvancedAnalytics: Bool {
        self == .premium
    }

    var hasDataExport: Bool {
        self == .premium
    }

    var hasUnlimitedChat: Bool {
        self == .premium
    }
}
