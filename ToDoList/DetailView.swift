//
//  DetailView.swift
//  ToDoList
//
//  Created by Chris Wheeler on 2/26/25.
//

import SwiftUI

struct DetailView: View {
    var passedValue: String     // don't initialize it - it gets passed in
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            
            Text("You Are a Swifty Legend!\nAnd you passed the value \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    DetailView(passedValue: "Item 99")
}
