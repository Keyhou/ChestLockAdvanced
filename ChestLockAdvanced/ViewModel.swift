//
//  ViewModel.swift
//  ChestLockAdvanced
//
//  Created by Keyhan Mortezaeifar on 02/12/2023.
//

import Foundation
import LocalAuthentication

class ViewModel: ObservableObject {
    @Published var isChestOpen = false
    
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
