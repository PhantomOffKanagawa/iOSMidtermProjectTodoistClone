//
//  SectionHeaderView.swift
//  MidtermProjectTodoistClone
//
//  Created by Harry Surma on 3/16/25.
//

import SwiftUI

struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.system(size: 17, weight: .medium))
                    .padding(.horizontal)
                    .padding(.vertical, 11)
                
                Spacer()
                
            }
            .background(Color.white)
            
            Divider()
        }
    }
}
