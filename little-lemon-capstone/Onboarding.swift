//
//  Onboarding.swift
//  little-lemon-capstone
//
//  Created by pwc on 28/08/2023.
//

import SwiftUI
let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"
let kIsLoggedIn = "logged_key"

struct OnboardingView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false // Added isLoggedIn
    
    var body: some View {
        NavigationView { // Wrap in NavigationView
            VStack {
                NavigationLink(
                    destination: HomeView(),
                    isActive: $isLoggedIn, // Use $ to bind to isActive
                    label: {
                        EmptyView()
                    }
                )
                
                VStack{
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                }.padding()
                
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && isValidEmail(email) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        
                        // Navigate to the Home screen and set isLoggedIn to true
                        isLoggedIn = true
                    } else {
                        // Handle invalid input or show an error message
                    }
                }
            }
        }
    }
    
    // Function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
