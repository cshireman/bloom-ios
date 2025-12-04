//
//  WellnessGoal.swift
//  Bloom
//
//  Created on 2025-12-03.
//

import Foundation

/// Represents a user's wellness goal for personalized coaching
struct WellnessGoal {
    let id: String
    let userId: String
    let type: WellnessGoalType
    let description: String
    let targetValue: Double?
    let createdAt: Date
    var isActive: Bool

    init(
        id: String = UUID().uuidString,
        userId: String,
        type: WellnessGoalType,
        description: String,
        targetValue: Double? = nil,
        createdAt: Date = Date(),
        isActive: Bool = true
    ) {
        self.id = id
        self.userId = userId
        self.type = type
        self.description = description
        self.targetValue = targetValue
        self.createdAt = createdAt
        self.isActive = isActive
    }
}

/// Types of wellness goals users can select
enum WellnessGoalType: String, Codable, CaseIterable {
    case improveSleep = "Improve Sleep"
    case reduceStress = "Reduce Stress"
    case increaseEnergy = "Increase Energy"
    case betterMood = "Better Mood"
    case buildHabits = "Build Healthy Habits"
    case mindfulness = "Practice Mindfulness"
    case workLifeBalance = "Work-Life Balance"
    case physicalHealth = "Physical Health"
    case mentalHealth = "Mental Health"
    case productivity = "Productivity"

    var icon: String {
        switch self {
        case .improveSleep: return "😴"
        case .reduceStress: return "🧘"
        case .increaseEnergy: return "⚡️"
        case .betterMood: return "😊"
        case .buildHabits: return "✅"
        case .mindfulness: return "🌸"
        case .workLifeBalance: return "⚖️"
        case .physicalHealth: return "💪"
        case .mentalHealth: return "🧠"
        case .productivity: return "🎯"
        }
    }

    var defaultDescription: String {
        switch self {
        case .improveSleep:
            return "Get better quality sleep and wake up refreshed"
        case .reduceStress:
            return "Manage stress and find calm in daily life"
        case .increaseEnergy:
            return "Boost energy levels throughout the day"
        case .betterMood:
            return "Cultivate a more positive emotional state"
        case .buildHabits:
            return "Establish consistent healthy routines"
        case .mindfulness:
            return "Be more present and aware in daily activities"
        case .workLifeBalance:
            return "Find harmony between work and personal life"
        case .physicalHealth:
            return "Improve overall physical wellbeing"
        case .mentalHealth:
            return "Enhance mental clarity and emotional resilience"
        case .productivity:
            return "Accomplish goals with focus and efficiency"
        }
    }

    /// Returns coaching context for AI to personalize insights
    var coachingContext: String {
        switch self {
        case .improveSleep:
            return "Focus on sleep hygiene, bedtime routines, and factors affecting sleep quality."
        case .reduceStress:
            return "Emphasize stress management techniques, relaxation, and healthy coping mechanisms."
        case .increaseEnergy:
            return "Highlight energy-boosting habits like movement, nutrition, and rest patterns."
        case .betterMood:
            return "Support mood regulation through activities, social connection, and self-care."
        case .buildHabits:
            return "Encourage consistency, celebrate small wins, and provide accountability."
        case .mindfulness:
            return "Promote present-moment awareness and mindful practices."
        case .workLifeBalance:
            return "Address boundaries, time management, and life satisfaction."
        case .physicalHealth:
            return "Encourage movement, nutrition, and physical self-care."
        case .mentalHealth:
            return "Support emotional wellbeing, cognitive health, and mental resilience."
        case .productivity:
            return "Focus on focus, energy management, and effective goal-setting."
        }
    }
}

extension WellnessGoal: Equatable {
    static func == (lhs: WellnessGoal, rhs: WellnessGoal) -> Bool {
        lhs.id == rhs.id
    }
}

extension WellnessGoal: Identifiable {}
