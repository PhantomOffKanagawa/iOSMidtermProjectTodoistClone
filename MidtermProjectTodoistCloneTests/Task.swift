//
//  TaskModel.swift
//  MidtermProjectTodoistClone
//

import SwiftUI
import Foundation

// Models for our data structure
struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var category: String
    var categoryColor: String
    var hasRecurring: Bool
    var progress: String?
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, category, categoryColor, hasRecurring, progress, date
    }
}

struct TaskSection: Identifiable {
    var id = UUID()
    var date: String
    var formattedTitle: String
    var tasks: [Task]
}

struct CalendarDate: Identifiable {
    var id = UUID()
    var date: String
    var dayOfWeek: String
    var fullDate: Date
    var hasTask: Bool
}

// View model to handle data and logic
class TaskViewModel: ObservableObject {
    @Published var taskSections: [TaskSection] = []
    @Published var calendarDates: [CalendarDate] = []
    @Published var selectedDate: String = ""
    @Published var monthYearText: String = ""
    
    // For scroll position tracking
    @Published var scrolledSectionID: UUID?
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let jsonData = loadJSONData() else {
            // Create sample data if JSON loading fails
            createSampleData()
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let tasks = try decoder.decode([Task].self, from: jsonData)
            processTasks(tasks)
        } catch {
            print("Error decoding JSON: \(error)")
            createSampleData()
        }
    }
    
    private func loadJSONData() -> Data? {
        // In a real app, you would load from a file or network
        // For this example, we'll return nil to use sample data
        return nil
    }
    
    private func createSampleData() {
        // Create calendar dates (one week)
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today) // 1 = Sunday, 2 = Monday, etc.
        
        // Calculate the start date (previous Sunday)
        let daysToSubtract = weekday - 1
        guard let startDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: today) else {
            return
        }
        
        // Format the month and year for display
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        monthYearText = dateFormatter.string(from: today)
        
        // Create 7 days starting from Sunday
        calendarDates = []
        var dateTasks: [String: [Task]] = [:]
        
        for i in 0..<7 {
            guard let date = calendar.date(byAdding: .day, value: i, from: startDate) else { continue }
            
            // Format for display
            dateFormatter.dateFormat = "d"
            let dayNumber = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "E"
            let weekdayLetter = String(dateFormatter.string(from: date).prefix(1))
            
            // Format for section headers
            dateFormatter.dateFormat = "EEE MMM d"
            let formattedDate = dateFormatter.string(from: date)
            
            // Determine if this is today
            let isToday = calendar.isDateInToday(date)
            
            // Create sample tasks for this date (more for today, fewer for other days)
            let tasksCount = isToday ? 3 : (i % 2 == 0 ? 1 : 2)
            var tasks: [Task] = []
            
            for j in 0..<tasksCount {
                let task = Task(
                    title: "Task \(j+1) for \(formattedDate)",
                    category: j % 2 == 0 ? "Personal" : "MacStories",
                    categoryColor: j % 2 == 0 ? "green" : "red",
                    hasRecurring: j % 3 == 0,
                    progress: j % 3 == 2 ? "\(j)/\(j+2)" : nil,
                    date: formattedDate
                )
                tasks.append(task)
            }
            
            // Set if this date has tasks
            let hasTask = !tasks.isEmpty
            
            // Add to calendar dates
            calendarDates.append(CalendarDate(
                date: dayNumber,
                dayOfWeek: weekdayLetter,
                fullDate: date,
                hasTask: hasTask
            ))
            
            // Store tasks by date
            dateTasks[formattedDate] = tasks
        }
        
        // Build sections from tasks
        taskSections = []
        for (date, tasks) in dateTasks {
            let formattedTitle = isToday(date: date) ? "Today · \(date)" :
                                isTomorrow(date: date) ? "Tomorrow · \(date)" : date
            
            let section = TaskSection(
                date: date,
                formattedTitle: formattedTitle,
                tasks: tasks
            )
            taskSections.append(section)
        }
        
        // Sort sections by date
        taskSections.sort { (section1, section2) -> Bool in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE MMM d"
            
            if let date1 = dateFormatter.date(from: section1.date),
               let date2 = dateFormatter.date(from: section2.date) {
                return date1 < date2
            }
            return false
        }
        
        // Set initial selected date to today
        if let todayDate = calendarDates.first(where: { calendar.isDateInToday($0.fullDate) }) {
            selectedDate = todayDate.date
        } else if !calendarDates.isEmpty {
            selectedDate = calendarDates[0].date
        }
    }
    
    private func processTasks(_ tasks: [Task]) {
        // Group tasks by date
        var tasksByDate: [String: [Task]] = [:]
        
        for task in tasks {
            if tasksByDate[task.date] == nil {
                tasksByDate[task.date] = []
            }
            tasksByDate[task.date]?.append(task)
        }
        
        // Create sections
        taskSections = tasksByDate.map { (date, tasks) in
            let formattedTitle = isToday(date: date) ? "Today · \(date)" :
                                isTomorrow(date: date) ? "Tomorrow · \(date)" : date
            
            return TaskSection(
                date: date,
                formattedTitle: formattedTitle,
                tasks: tasks
            )
        }
        
        // Sort sections by date
        taskSections.sort { (section1, section2) -> Bool in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE MMM d"
            
            if let date1 = dateFormatter.date(from: section1.date),
               let date2 = dateFormatter.date(from: section2.date) {
                return date1 < date2
            }
            return false
        }
        
        // Build calendar dates based on the available task dates
        // In a real app, you would generate a week or month of dates
        // For this example, we're using the task dates we have
        calendarDates = []
        
        // Set initial selected date
        if let firstSection = taskSections.first {
            selectedDate = firstSection.date
        }
    }
    
    // Helper functions for date formatting
    private func isToday(date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM d"
        guard let parsedDate = dateFormatter.date(from: date) else { return false }
        
        return Calendar.current.isDateInToday(parsedDate)
    }
    
    private func isTomorrow(date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM d"
        guard let parsedDate = dateFormatter.date(from: date) else { return false }
        
        return Calendar.current.isDateInTomorrow(parsedDate)
    }
    
    // Find section ID by date
    func getSectionID(for dateString: String) -> UUID? {
        // Parse the numeric date from calendar format to find matching section
        if let section = taskSections.first(where: { section in
            // Handle both formats: just the date number or the full date
            return section.date.contains(dateString) || 
                section.formattedTitle.contains("· \(dateString)") ||
                section.date.hasSuffix(" \(dateString)")
        }) {
            return section.id
        }
        return nil
    }
    
    // Find date for a section ID
    func getDateNumber(for sectionID: UUID) -> String? {
        if let section = taskSections.first(where: { $0.id == sectionID }) {
            // Extract the date number
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE MMM d"
            if let date = dateFormatter.date(from: section.date) {
                dateFormatter.dateFormat = "d"
                return dateFormatter.string(from: date)
            }
        }
        return nil
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}