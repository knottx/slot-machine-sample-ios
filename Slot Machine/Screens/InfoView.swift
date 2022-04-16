//
//  InfoView.swift
//  Slot Machine
//
//  Created by Visarut Tippun on 16/4/22.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            
            Spacer()
            
            Form {
                Section {
                    FormRowView(title: "Application", value: "Slot Machine")
                    FormRowView(title: "Platforms", value: "iPhone, iPad, Mac")
                    FormRowView(title: "Developer", value: "Knot / knottx")
                    FormRowView(title: "Version", value: "1.0.0")
                } header: {
                    Text("About the application")
                }

            } //: Form
            .font(.system(.body, design: .rounded))
        } //: VStack
        .padding(.top, 40)
        .overlay(alignment: .topTrailing) {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
            }
            .padding(.top, 30)
            .padding(.trailing, 20)
            .tint(.secondary)
        }
    }
}

struct FormRowView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

