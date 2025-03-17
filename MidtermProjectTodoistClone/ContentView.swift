//
//  ContentView.swift
//  MidtermProjectTodoistClone
//
//  Created by Harry Surma on 3/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddTask = false
    @State private var dragOffset = CGSize.zero
    @State private var isDragging = false
    @State private var selectedDate = "28"
    @State private var moveDate = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    // Header
                    HeaderView()
                    
                    // Horizontal Calendar list
                    CalendarView(
                        selectedDate: $selectedDate,
                        moveDate: $moveDate
                    )
                    
                    // Task List View
                    TaskListView(
                        selectedDate: $selectedDate,
                        moveDate: $moveDate
                    )
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        AddButton(
                            dragOffset: $dragOffset,
                            isDragging: $isDragging,
                            showingAddTask: $showingAddTask
                        )
                            .padding(.trailing, 18)
                            .padding(.bottom, 21)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ZStack {
        ContentView()
        // Reference Image overlayed in opacity
        Image("reference_design")
            .resizable()
            .opacity(0)
            .ignoresSafeArea()
    }
}
