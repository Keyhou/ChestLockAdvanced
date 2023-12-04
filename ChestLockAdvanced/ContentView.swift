//
//  ContentView.swift
//  ChestLockAdvanced
//
//  Created by Keyhan Mortezaeifar on 20/11/2023.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isChestOpen = false
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 60) {
            Text(viewModel.isChestOpen ? "Application\nlocked" : "Application\nunlocked")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            ZStack {
                Image(viewModel.isChestOpen ? "chest_opened" : "chest_closed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 64)
                    .padding()
                
                Circle()
                    .stroke(viewModel.isChestOpen ? Color.green : Color.red, lineWidth: 5)
                    .frame(width: 120, height: 120)
            }
            
            Button(action: {
                if !self.viewModel.isChestOpen {
                    // Only authenticate with Face ID when opening the chest
                    self.viewModel.authenticateWithFaceID()
                } else {
                    self.viewModel.isChestOpen.toggle()
                }
            }) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(viewModel.isChestOpen ? Color.red : Color.green)
                    .frame(width: 110, height: 60)
                    .overlay(
                        Text(viewModel.isChestOpen ? "Lock" : "Open")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                    )
            }
        }
        .padding()
    }
    
}

#Preview {
    ContentView(viewModel: ViewModel())
}
