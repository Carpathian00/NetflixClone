//
//  SignUpViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 01/05/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var firstNameField: UITextField! 
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField! {
        didSet {
            passField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var repeatPassField: UITextField! {
        didSet {
            repeatPassField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var signInButton: UILabel!
    
    var errorShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSignIn()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Sign Up"
        self.navigationController?.navigationBar.tintColor = .label
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .black
        

    }
    
    private func validateSignUpFields() -> String {
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            repeatPassField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            return "Please fill in all fields."
        }
        
        let cleanedPassword = passField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if passField.text != repeatPassField.text {
            return "Please repeat the correct password"
        }

        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at leat 8 characters, contains a special character and a number."
        }
        
        
        return ""
    }
    

    private func setupSignIn() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapSignInButton(sender:)))
            signInButton.isUserInteractionEnabled = true
            signInButton.addGestureRecognizer(tap)
    }
    
    @IBAction func tapSignUpButton(_ sender: Any) {
        let error = validateSignUpFields()

        if error != "" {
            self.setupError(text: error)
        } else {
            let firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for error in firebase
                if err != nil {
                    //there was an error creating a user
                    self.setupError(text: "There was an error creating a user")
                } else {
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data:
                    [
                        "firstName":firstName,
                        "lastName":lastName,
                        "uid":result!.user.uid
                    ]) { (error) in
                        
                        if error != nil {
                            self.setupError(text: "Error saving user data")
                            }
                        
                        }
                    self.moveToHomePage()
                    }
            }
        }
        
    }
    
    private func setupError(text: String) {
        let errorMessage = Utilities.createErrorLabel(text: text)

        if errorShown == false {
            errorShown = true
            verticalStackView.insertArrangedSubview(errorMessage, at: 5)
        } else {
            let existingErrorMessage = verticalStackView.arrangedSubviews[5]
            verticalStackView.removeArrangedSubview(existingErrorMessage)
            existingErrorMessage.removeFromSuperview()
            verticalStackView.insertArrangedSubview(errorMessage, at: 5)
        }
    }
    
    @objc
    func tapSignInButton(sender:UITapGestureRecognizer) {

        print("tap working")
        self.navigationController?.popViewController(animated: true)
    }

    private func moveToHomePage() {
        let tabBarController = TabBarController()
         
         view.window?.rootViewController = tabBarController
         view.window?.makeKeyAndVisible()
    }

}
