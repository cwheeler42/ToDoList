//
//  DetailView.swift
//  ToDoList
//
//  Created by Chris Wheeler on 2/26/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            
            Text("You Are a Swifty Legend!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button("Get Back!") {
                dismiss()
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DetailView()
}
