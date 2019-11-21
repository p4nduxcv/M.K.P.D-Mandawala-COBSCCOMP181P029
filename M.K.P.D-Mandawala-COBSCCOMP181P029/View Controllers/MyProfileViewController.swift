//
//  MyProfileViewController.swift
//  M.K.P.D-Mandawala-COBSCCOMP181P029
//
//  Created by Pandula Mandawala on 11/20/19.
//  Copyright © 2019 Pandula Mandawala. All rights reserved.
//

import UIKit
import Firebase


class MyProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupElement()
    }
    
    func setupElement(){
        errorLabel.alpha=0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tappedFetchButton(_ sender: Any) {
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            db.collection("users").whereField("uid", isEqualTo: uid)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                         //print("\(document.documentID) => \(document.data())")
                            let firstName = document.get("first_name")
                            let lastName = document.get("last_name")
                            let mobileNumber = document.get("mobile_number")
                            let profilePhoto = document.get("profile_photo")
                            
                            self.firstNameLabel.text = firstName as? String
                            self.lastNameLabel.text = lastName as? String
                            self.mobileNumberLabel.text = mobileNumber as? String
                            
                            if let url = NSURL (string: profilePhoto as! String) {
                                if let data = NSData(contentsOf: url as URL) {
                                    self.profileImageView.contentMode = UIView.ContentMode.scaleAspectFit
                                    self.profileImageView.image = UIImage (data: data as Data)
                                    
                                }
                            }
                        }
                        
                    }
            }
        }
        //db.collectionGroup("users").whereField("uid", isEqualTo: true)
        
//        if currentUser == nil {
//            showError("no users")
//        } else {
//
//            db.collection("users").document(currentUser)
//        }
        
        
        
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
