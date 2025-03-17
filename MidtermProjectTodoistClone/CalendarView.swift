//
//  CalendarView.swift
//  MidtermProjectTodoistClone
//
//  Created by Harry Surma on 3/16/25.
//

import SwiftUI
import NotificationCenter

struct CalendarView: View {
    @Binding var selectedDate: String
    @Binding var moveDate: String
    
    // Pre-define constants to avoid recreating them on every render
    private let todoistRed = Color(red: 0.86, green: 0.32, blue: 0.32)
    private let weekDays = ["S", "M", "T", "W", "T", "F", "S"]
    private let dates = ["26", "27", "28", "29", "30", "1", "2"]
    private let taskOnDay = [ false, false, true, true, true, false, false ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Apr 2020")
                    .font(.system(size: 18, weight: .medium))
                Image(systemName: "chevron.down")
                    .font(.system(size: 14))
                
                Spacer()
                
                Text("Today")
                    .foregroundColor(todoistRed)
                    .font(.system(size: 18))
            }
            .padding(.horizontal, 18.5)
            .padding(.top, 12)
            
            Spacer()
            
            // Week days row
            HStack(spacing: 0) {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }
            }
            .padding(.horizontal, 0)
            .padding(.bottom, 10)
            
            // Calendar dates row
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { index in
                    let date = dates[index]
                    let isSelected = date == selectedDate
                    let hasTask = taskOnDay[index]
                    
                    // Individual date number stack
                    CalendarDateView(
                        date: date,
                        isSelected: isSelected,
                        hasTask: hasTask,
                        accentColor: todoistRed,
                        onTap: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedDate = date
                                moveDate = date
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 0)
            
            Divider()
                .padding(.top, 01)
        }
        .frame(height: 119)
        .background(Color.white)
    }
}

// Separate view for each date cell to improve performance
struct CalendarDateView: View {
    let date: String
    let isSelected: Bool
    let hasTask: Bool
    let accentColor: Color
    let onTap: () -> Void
    
    var body: some View {
        let circleColor: Color = hasTask ? (isSelected ? accentColor : Color.gray) : Color.clear
        
        VStack(spacing: 0) {
            Text(date)
                .frame(maxWidth: .infinity)
                .foregroundColor(isSelected ? accentColor : .primary)
                .font(.system(size: 18))
                .padding(.bottom, 6)
            
            Circle()
                .fill(circleColor)
                .frame(height: 3)
                .padding(.bottom, 8)
                .padding(.top, -6)
            
            Rectangle()
                .fill(isSelected ? accentColor : Color.clear)
                .frame(height: 2)
                .padding(.horizontal, 0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}
