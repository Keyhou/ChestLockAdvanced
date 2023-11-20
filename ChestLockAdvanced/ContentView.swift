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
    
    var body: some View {
        VStack(spacing: 60) {
            Text(isChestOpen ? "Application\nlocked" : "Application\nunlocked")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            ZStack {
                Image(isChestOpen ? "chest_opened" : "chest_closed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 64)
                    .padding()
                
                Circle()
                    .stroke(isChestOpen ? Color.green : Color.red, lineWidth: 5)
                    .frame(width: 120, height: 120)
            }
            
            Button(action: {
                if !self.isChestOpen {
                    // Only authenticate with Face ID when opening the chest
                    self.authenticateWithFaceID()
                } else {
                    self.isChestOpen.toggle()
                }
            }) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(isChestOpen ? Color.red : Color.green)
                    .frame(width: 110, height: 60)
                    .overlay(
                        Text(isChestOpen ? "Lock" : "Open")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                    )
            }
        }
        .padding()
    }
    
    func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock the chest with Face ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isChestOpen.toggle()
                    } else {
                        // Handle authentication error
                        // For example, show an alert with an error message
                        print("Authentication error: \(authenticationError?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        } else {
            // Device does not support Face ID or Touch ID
            // Handle accordingly, e.g., show an alert
            print("Biometric authentication not available: \(error?.localizedDescription ?? "Unknown error")")
        }
    }
}

#Preview {
    ContentView()
}
