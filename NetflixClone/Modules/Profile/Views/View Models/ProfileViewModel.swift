//
//  ProfileViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 07/05/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


class ProfileViewModel {
    
    private let db = Firestore.firestore()
        
        func fetchData(completion: @escaping (Result<Profile, Error>) -> Void) {
            guard let userUID = fetchUserId() else { return }
            
            db.collection("users").whereField("uid", isEqualTo: userUID).getDocuments { (documentSnapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else if  documentSnapshot?.isEmpty == false {
                    let data = documentSnapshot?.documents[0].data()
                    let userEmail = self.fetchUserEmail()
                    let firstName = data?["firstName"] as? String ?? ""
                    let lastName = data?["lastName"] as? String ?? ""
                    let userName = firstName + " " + lastName
                    let profileData = Profile(userName: userName, userEmail: userEmail)
                    completion(.success(profileData))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
                    completion(.failure(error))
                }

            }
            
        }
    
    private func fetchUserEmail() -> String? {
        guard let currentUser = Auth.auth().currentUser else {
                // User is not authenticated, handle error accordingly
            return ""
        }
            
        let userEmail = currentUser.email
        return userEmail
    }
    
    private func fetchUserId() -> String? {
        guard let currentUser = Auth.auth().currentUser else {
                // User is not authenticated, handle error accordingly
            return ""
        }
            
        let userId = currentUser.uid
        print("user id: \(userId)")
        return userId
    }
    
}
