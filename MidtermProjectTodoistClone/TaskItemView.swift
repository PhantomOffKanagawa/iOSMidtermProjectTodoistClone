//
//  TaskItemView.swift
//  MidtermProjectTodoistClone
//
//  Created by Harry Surma on 3/16/25.
//

import SwiftUI

struct TaskItemView: View {
    let title: String
    let category: String
    let categoryColor: Color
    let hasRecurring: Bool
    var progress: String? = nil
    var showsChevron: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 24, height: 24)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 17))
                    
                    HStack(spacing: 0) {
                        if let progress = progress {
                            Image(systemName: "link")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                            Text(progress)
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                                .padding(.leading, 5)
                                .padding(.trailing, 3)
                        }
                        
                        if hasRecurring {
                            Image(systemName: "arrow.2.circlepath")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                        }
                        
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 12)
                    }
                    .padding(.leading, 2)
                    .padding(.top, 3)
                }
                .padding(.leading, 4)
                .padding(.top, 18)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Spacer()
                    
                    if progress != nil {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.gray)
                            .padding(.trailing, 20)
                            .padding(.bottom, 8)
                    }
                    
                    HStack(spacing: 5) {
                        Text(category)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(.trailing, 0)
                        Circle()
                            .fill(categoryColor)
                            .frame(width: 8, height: 8)
                            .padding(.leading, 0)
                            .padding(.trailing, 7)
                    }
                    .padding(.trailing)
//                    .padding(.top, 44)
                    .padding(.bottom, -5)
                }
            }
            .frame(height: 53)
//            .overlay(
//                Rectangle()
//                    .frame(height: 1)
//                    .foregroundColor(Color(UIColor.systemGray5))
//                    .offset(y: 30)
//            )
            
            Divider()
                .padding(.top, 15)
        }
        .background(Color.white)
//        .frame(height: 55)
    }
}
