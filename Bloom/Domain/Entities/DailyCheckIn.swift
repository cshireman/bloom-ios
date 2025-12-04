//
//  DailyCheckIn.swift
//  Bloom
//
//  Created on 2025-12-03.
//

import Foundation

/// Represents a daily wellness check-in entry
struct DailyCheckIn {
    let id: String
    let userId: String
    let timestamp: Date
    let moodScore: Int       // 1-10 scale
    let energyScore: Int     // 1-10 scale
    let sleepHours: Double   // Hours of sleep
    let sleepQuality: Int    // 1-10 scale
    let notes: String?
    var aiInsight: String?
    let isMorning: Bool

    init(
        id: String = UUID().uuidString,
        userId: String,
        timestamp: Date = Date(),
        moodScore: Int,
        energyScore: Int,
        sleepHours: Double,
        sleepQuality: Int,
        notes: String? = nil,
        aiInsight: String? = nil,
        isMorning: Bool = true
    ) {
        self.id = id
        self.userId = userId
        self.timestamp = timestamp
        self.moodScore = moodScore
        self.energyScore = energyScore
        self.sleepHours = sleepHours
        self.sleepQuality = sleepQuality
        self.notes = notes
        self.aiInsight = aiInsight
        self.isMorning = isMorning
    }

    /// Validates that all scores are within acceptable ranges
    var isValid: Bool {
        moodScore >= 1 && moodScore <= 10 &&
        energyScore >= 1 && energyScore <= 10 &&
        sleepQuality >= 1 && sleepQuality <= 10 &&
        sleepHours >= 0 && sleepHours <= 24
    }

    /// Returns the overall wellness score (average of mood, energy, sleep quality)
    var overallWellnessScore: Double {
        let sleepScore = (sleepQuality + min(10, Int(sleepHours / 0.8))) / 2
        return Double(moodScore + energyScore + sleepScore) / 3.0
    }

    /// Check if this check-in is from today
    func isFromToday() -> Bool {
        Calendar.current.isDateInToday(timestamp)
    }

    /// Check if this check-in is from a specific date
    func isFrom(date: Date) -> Bool {
        Calendar.current.isDate(timestamp, inSameDayAs: date)
    }
}

extension DailyCheckIn: Equatable {
    static func == (lhs: DailyCheckIn, rhs: DailyCheckIn) -> Bool {
        lhs.id == rhs.id
    }
}

extension DailyCheckIn: Identifiable {}
