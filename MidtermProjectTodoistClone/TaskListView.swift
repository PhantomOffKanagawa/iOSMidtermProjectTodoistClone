//
//  TaskListView.swift
//  MidtermProjectTodoistClone
//
//  Created by Harry Surma on 3/16/25.
//
import SwiftUI

func colorFromString(_ colorString: String) -> Color? {
    let colorMapping: [String: Color] = [
        "red": .red,
        "green": .green,
        "blue": .blue,
        "yellow": .yellow,
        "black": .black,
        "white": .white,
    ]
    
    return colorMapping[colorString.lowercased()]
}

struct TaskListView: View {
    @Binding var selectedDate: String
    @Binding var moveDate: String
    @State private var days: [Day] = []
    @State private var currentlyVisibleID: String?
    
    var body: some View {
        ScrollViewReaderContent(
            days: days,
            selectedDate: $selectedDate,
            moveDate: $moveDate,
            currentlyVisibleID: $currentlyVisibleID,
            loadTasks: loadTasks
        )
        .background(Color(UIColor.systemGroupedBackground))
    }
    
    private func loadTasks() {
        guard let url = Bundle.main.url(forResource: "tasks", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            days = try JSONDecoder().decode([Day].self, from: data)
//            print("Loaded days: \(days)") // Debugging line
        } catch {
            print("Error loading tasks: \(error)")
        }
    }
}

// Extracted ScrollViewReader content
struct ScrollViewReaderContent: View {
    let days: [Day]
    @Binding var selectedDate: String
    @Binding var moveDate: String
    @Binding var currentlyVisibleID: String?
    let loadTasks: () -> Void
    
    @State var scrollPosition: Int?
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                DaysContentView(days: days, currentlyVisibleID: $currentlyVisibleID)
            }
            .scrollPosition(id: $scrollPosition)
            .scrollTargetBehavior(.viewAligned)
            .onChange(of: moveDate) { _, _ in
                withAnimation {
                    value.scrollTo(Int(moveDate), anchor: .top)
                    moveDate = ""
                }
            }
            .onChange(of: scrollPosition) {
                print(scrollPosition ?? "Failed")
                if let scrollPosition = scrollPosition {
                    selectedDate = String(scrollPosition)
                }
            }
            .onAppear() {
                loadTasks()
                moveDate = "28"
            }
        }
    }
}

// Extracted days content
struct DaysContentView: View {
    let days: [Day]
    @Binding var currentlyVisibleID: String?
    
    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(days, id: \.self) { day in
                    DayView(day: day, currentlyVisibleID: $currentlyVisibleID)
                    .id(day.id)
                    
                    Rectangle()
                        .frame(height: 21)
                        .overlay(Color.white)
            }
        }
        .scrollTargetLayout()
    }
}

// Extracted day view
struct DayView: View {
    let day: Day
    @Binding var currentlyVisibleID: String?
    
    var body: some View {
        VStack(spacing: 0) {
            SectionHeaderView(title: day.title)
                .id(day.id)
            
            // Load each task with an id based on self
            ForEach(day.tasks.indices, id: \.self) { index in
                let task = day.tasks[index]
                TaskItemView(
                    title: task.title,
                    category: task.category,
                    categoryColor: colorFromString(task.categoryColor) ?? Color.clear,
                    hasRecurring: task.hasRecurring ?? false,
                    progress: task.progress
                )
            }
        }
    }
}
