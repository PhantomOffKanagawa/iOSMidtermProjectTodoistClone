//
//  HeaderView.swift
//  MidtermProjectTodoistClone
//
//  Created by Harry Surma on 3/16/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        // Stack of color with icons and text on top
        ZStack {
            Color(red: 0.86, green: 0.32, blue: 0.32) // Todoist red
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0) {
                // Navigation bar
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .bold))
                    }
                    .padding(.trailing, 20)
                    .padding(.leading, -5)
                    
                    
                    Text("Upcoming")
                        .foregroundColor(.white)
                        .font(.system(size: 23, weight: .bold))
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: {}) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                        }
                        .padding(.trailing, 15)
                        
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .font(.system(size: 28))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 15)
            }
        }
        .frame(height: 35)
    }
}
