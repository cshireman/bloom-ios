//
//  Habit.swift
//  Bloom
//
//  Created on 2025-12-03.
//

import Foundation

/// Represents a user's wellness habit to track
struct Habit {
    let id: String
    let userId: String
    let name: String
    let icon: String
    let color: String
    let createdAt: Date
    var completedDates: [Date]
    var currentStreak: Int
    var longestStreak: Int
    var isActive: Bool

    init(
        id: String = UUID().uuidString,
        userId: String,
        name: String,
        icon: String,
        color: String,
        createdAt: Date = Date(),
        completedDates: [Date] = [],
        currentStreak: Int = 0,
        longestStreak: Int = 0,
        isActive: Bool = true
    ) {
        self.id = id
        self.userId = userId
        self.name = name
        self.icon = icon
        self.color = color
        self.createdAt = createdAt
        self.completedDates = completedDates
        self.currentStreak = currentStreak
        self.longestStreak = longestStreak
        self.isActive = isActive
    }

    /// Check if the habit was completed on a specific date
    func isCompleted(on date: Date) -> Bool {
        completedDates.contains { Calendar.current.isDate($0, inSameDayAs: date) }
    }

    /// Check if the habit was completed today
    var isCompletedToday: Bool {
        isCompleted(on: Date())
    }

    /// Total number of completions
    var totalCompletions: Int {
        completedDates.count
    }

    /// Completion rate over the last N days
    func completionRate(days: Int) -> Double {
        guard days > 0 else { return 0.0 }

        let calendar = Calendar.current
        let today = Date()
        let startDate = calendar.date(byAdding: .day, value: -days, to: today) ?? today

        let completionsInPeriod = completedDates.filter { $0 >= startDate }.count
        return Double(completionsInPeriod) / Double(days)
    }

    /// Calculate the current streak based on completion dates
    func calculateCurrentStreak() -> Int {
        let calendar = Calendar.current
        var streak = 0
        var checkDate = calendar.startOfDay(for: Date())

        while true {
            if completedDates.contains(where: { calendar.isDate($0, inSameDayAs: checkDate) }) {
                streak += 1
                checkDate = calendar.date(byAdding: .day, value: -1, to: checkDate) ?? checkDate
            } else {
                break
            }
        }

        return streak
    }

    /// Calculate the longest streak from completion history
    func calculateLongestStreak() -> Int {
        guard !completedDates.isEmpty else { return 0 }

        let calendar = Calendar.current
        let sortedDates = completedDates
            .map { calendar.startOfDay(for: $0) }
            .sorted()
            .reduce(into: [Date]()) { result, date in
                if !result.contains(date) {
                    result.append(date)
                }
            }

        var maxStreak = 1
        var currentStreak = 1

        for i in 1..<sortedDates.count {
            let daysBetween = calendar.dateComponents([.day], from: sortedDates[i-1], to: sortedDates[i]).day ?? 0

            if daysBetween == 1 {
                currentStreak += 1
                maxStreak = max(maxStreak, currentStreak)
            } else {
                currentStreak = 1
            }
        }

        return maxStreak
    }
}

extension Habit: Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        lhs.id == rhs.id
    }
}

extension Habit: Identifiable {}

/// Predefined habit templates
enum HabitTemplate: String, CaseIterable {
    case meditation = "Meditation"
    case exercise = "Exercise"
    case water = "Drink Water"
    case reading = "Reading"
    case gratitude = "Gratitude Journal"
    case sleep = "Early Sleep"
    case outdoors = "Time Outdoors"
    case healthyEating = "Healthy Eating"

    var icon: String {
        switch self {
        case .meditation: return "🧘"
        case .exercise: return "💪"
        case .water: return "💧"
        case .reading: return "📚"
        case .gratitude: return "🙏"
        case .sleep: return "😴"
        case .outdoors: return "🌳"
        case .healthyEating: return "🥗"
        }
    }

    var defaultColor: String {
        switch self {
        case .meditation: return "#9C27B0"
        case .exercise: return "#FF5722"
        case .water: return "#2196F3"
        case .reading: return "#795548"
        case .gratitude: return "#FF9800"
        case .sleep: return "#3F51B5"
        case .outdoors: return "#4CAF50"
        case .healthyEating: return "#8BC34A"
        }
    }
}
