//
//  UserProfile.swift
//  little-lemon-capstone
//
//  Created by pwc on 28/08/2023.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(\.presentationMode) var presentation
    let firstName: String? = UserDefaults.standard.string(forKey: kFirstName)
    let lastName: String? = UserDefaults.standard.string(forKey: kLastName)
    let email: String? = UserDefaults.standard.string(forKey: kEmail)
    
    var body: some View {
        VStack {
            Text("Personal Information")
                .font(.largeTitle)
                .padding()
            
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text("First Name: \(firstName ?? "")")
                .font(.headline)
                .padding()
            
            Text("Last Name: \(lastName ?? "")")
                .font(.headline)
                .padding()
            
            Text("Email: \(email ?? "")")
                .font(.headline)
                .padding()
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn) 
                self.presentation.wrappedValue.dismiss() // Navigate back to the Onboarding screen
            }
            
            Spacer() 
        }
        .onAppear {
            let isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
            if isLoggedIn {
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}


