//
//  SignUpViewController.swift
//  M.K.P.D-Mandawala-COBSCCOMP181P029
//
//  Created by Pandula Mandawala on 11/18/19.
//  Copyright © 2019 Pandula Mandawala. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var mobleNumberTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //validation fields
    func validateFields() -> String? {
        //check that all fields are filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            //mobleNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "fill all fields"
        }
     return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        //validated the fields
        let error = validateFields()
        
        //show error messages
        if error != nil {
            showError(error!)
        } else {
            // creat clean version of data
            let first_name = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let last_name = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let mobile_number = mobleNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let profile_photo = "<add_url_here>"
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("Error in creating user")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "first_name" :first_name,
                        "last_name" : last_name ,
                        "mobile_number" : mobile_number,
                        "profile_photo" : profile_photo,
                        "uid" : result!.user.uid,
                        ]) { (error) in
                            if error != nil {
                                self.showError("User data insertion denied!")
                            }
                    }
                     // redirect to home
                    self.goToHome()
                }
            }
           
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func goToHome()  {
        let tapViewController =
        storyboard?.instantiateViewController(withIdentifier:
        Constants.Storyboard.tapViewController) as?
        TabViewController
        
        view.window?.rootViewController = tapViewController
        view.window?.makeKeyAndVisible()
    }
    
}
