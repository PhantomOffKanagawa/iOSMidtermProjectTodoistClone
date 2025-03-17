//
//  TaskListView.swift
//  MidtermProjectTodoistClone
//
//  Created by Harry Surma on 3/16/25.
//

import SwiftUI

struct TaskListView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SectionHeaderView(title: "Today · Tue Apr 28")
                
                TaskItemView(
                    title: "Pay: Credit card",
                    category: "Personal",
                    categoryColor: .green,
                    hasRecurring: true
                )
                
                TaskItemView(
                    title: "Monthly Log story",
                    category: "MacStories",
                    categoryColor: .red,
                    hasRecurring: false
                )
                
                TaskItemView(
                    title: "Write: Arcade Highlights",
                    category: "MacStories",
                    categoryColor: .red,
                    hasRecurring: false,
                    progress: "3/4"
                )
                
                Rectangle()
                    .frame(height: 21)
                    .overlay(.white)
                
                SectionHeaderView(title: "Tomorrow · Wed Apr 29")
                
                TaskItemView(
                    title: "Trim: Nails",
                    category: "Personal",
                    categoryColor: .green,
                    hasRecurring: true
                )
                
                TaskItemView(
                    title: "Monthly Log",
                    category: "MacStories",
                    categoryColor: .red,
                    hasRecurring: true
                )
                
                Rectangle()
                    .frame(height: 21)
                    .overlay(.white)
                
                SectionHeaderView(title: "Thu Apr 30")
                
                TaskItemView(
                    title: "MacStories Weekly",
                    category: "MacStories",
                    categoryColor: .red,
                    hasRecurring: false,
                    progress: "0/2"
                )
                
                Rectangle()
                    .frame(height: 21)
                    .overlay(.white)
                
                SectionHeaderView(title: "Fri May 1")
                
                Rectangle()
                    .frame(height: 21)
                    .overlay(.white)
                
                SectionHeaderView(title: "Sat May 2")
                
                Rectangle()
                    .frame(height: 21)
                    .overlay(.white)
                
                SectionHeaderView(title: "Sun May 3")
                
                TaskItemView(
                    title: "MacStories Check",
                    category: "MacStories",
                    categoryColor: .red,
                    hasRecurring: true,
                    progress: "0/2"
                )
                
                TaskItemView(
                    title: "Make T-Shirts",
                    category: "Personal",
                    categoryColor: .green,
                    hasRecurring: false
                )
                
                Rectangle()
                    .frame(height: 21)
                    .overlay(.white)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}
