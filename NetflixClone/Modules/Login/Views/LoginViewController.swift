//
//  LoginViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 01/05/23.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var topStackView: UIStackView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField! {
        didSet {
            passField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var recoverPassButton: UIButton!
    @IBOutlet weak var signUpButton: UILabel!
    
    private var errorShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavigationBar()
        setupSignUpButton()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.backButtonTitle = ""
    }
    
    private func setupSignUpButton() {
        let tapSignOut = UITapGestureRecognizer(target: self, action: #selector(self.tapSignUpButton(sender:)))
            signUpButton.isUserInteractionEnabled = true
            signUpButton.addGestureRecognizer(tapSignOut)
    }
    
    private func validateSignInFields() -> String {
        if  emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        return ""
    }
    
    @IBAction func tapSignInButton(_ sender: Any) {
        
        let error = validateSignInFields()
        
        
        if error != "" {
            if errorShown == false {
                errorShown = true
                let errorMessage = Utilities.createErrorLabel(text: error)
                topStackView.insertArrangedSubview(errorMessage, at: 2)
            }
        } else {
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, err) in
                if err != nil {
                    self?.setupError(text: "No account found")

                } else {
                    guard let strongSelf = self else { return }
                    strongSelf.moveToHomePage()
                }
               
                
            }
            
        }
    }
    
    @objc
    func tapSignUpButton(sender:UITapGestureRecognizer) {

        print("tap working")
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupError(text: String) {
        let errorMessage = Utilities.createErrorLabel(text: text)

        if errorShown == false {
            errorShown = true
            topStackView.insertArrangedSubview(errorMessage, at: 2)
        } else {
            let existingErrorMessage = topStackView.arrangedSubviews[2]
            topStackView.removeArrangedSubview(existingErrorMessage)
            existingErrorMessage.removeFromSuperview()
            topStackView.insertArrangedSubview(errorMessage, at: 2)
        }
    }


    private func moveToHomePage() {
        let tabBarController = TabBarController()
         
         view.window?.rootViewController = tabBarController
         view.window?.makeKeyAndVisible()
    }
    

}
