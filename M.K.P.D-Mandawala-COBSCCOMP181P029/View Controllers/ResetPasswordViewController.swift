//
//  ResetPasswordViewController.swift
//  M.K.P.D-Mandawala-COBSCCOMP181P029
//
//  Created by Pandula Mandawala on 11/21/19.
//  Copyright © 2019 Pandula Mandawala. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements(){
        errorLabel.alpha=0
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        // check the fields are empty
        let error = validateFields()
        if error != nil {
            // There's something wrong with the fields, show error message
            showError(error!)
        }else {
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if (error != nil){
                    //alert(message: error?.localizedDescription ?? "Error")
                    self.showError("Wrong Credintial...")
                    return
                }
                
                // create the alert
                let alert = UIAlertController(title: "Notification", message: "A password reset email has been sent to your account.", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                self.transitionToLogin()
                
            }
            
            
        }
    }
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToLogin() {
        
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
        
    }
}
