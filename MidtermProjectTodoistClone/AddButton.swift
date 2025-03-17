//
//  AddButton.swift
//  MidtermProjectTodoistClone
//
//  Created by Harry Surma on 3/16/25.
//

import SwiftUI

struct AddButton: View {
    @Binding var dragOffset: CGSize
    @Binding var isDragging: Bool
    @Binding var showingAddTask: Bool
    
    // Constants
    private let buttonSize: CGFloat = 56
    private let todoistRed = Color(red: 0.86, green: 0.32, blue: 0.32)
    private let todoistDarkRed = Color(red: 0.70, green: 0.25, blue: 0.25)
    
    var body: some View {
        ZStack {
            // Drop zone that appears when dragging
            Circle()
                .fill(todoistDarkRed)
                .frame(width: buttonSize, height: buttonSize)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                )
                .opacity(isDragging ? 1 : 0)
                .scaleEffect(isDragging ? 1 : 0.5)
                .animation(.spring(), value: isDragging)
            
            // The actual draggable button
            Circle()
                .fill(todoistRed)
                .frame(width: buttonSize, height: buttonSize)
                .overlay(
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                )
                .shadow(color: .gray.opacity(0.4), radius: 3, x: 0, y: 2)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            withAnimation(.spring()) {
                                isDragging = true
                                dragOffset = gesture.translation
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                isDragging = false
                                dragOffset = .zero
                            }
                        }
                )
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            showingAddTask = true
                        }
                )
        }
    }
}
