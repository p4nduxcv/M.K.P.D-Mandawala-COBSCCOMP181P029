//
//  AddPostViewController.swift
//  M.K.P.D-Mandawala-COBSCCOMP181P029
//
//  Created by Pandula Mandawala on 11/22/19.
//  Copyright © 2019 Pandula Mandawala. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class AddPostViewController: UIViewController {

    
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var postBodyTextField: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var postPublishButton: UIButton!
    
    var imagePicker:UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        postImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
  
    @IBAction func tappedUploadImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func tappedPublish(_ sender: Any) {
        if(postTitleTextField.text == "") {
            let alert = UIAlertController(title: "Notification", message: "You can't leave Title", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if(postBodyTextField.text == ""){
            let alert = UIAlertController(title: "Notification", message: "You can't leave Content", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if(postImage.image == nil) {
            let alert = UIAlertController(title: "Notification", message: "Image Is Required.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.saveFIRData()
        navigationController?.popViewController(animated: true)
        let alert = UIAlertController(title: "Notification", message: "Post was Published.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func saveFIRData(){
        self.uploadMedia(image: postImage.image!){ url in
            self.saveImage(profileImageURL: url!){ success in
                if (success != nil){
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func uploadMedia(image :UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(imageName)
        let imgData = self.postImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else{
                print("error in save image")
                completion(nil)
            }
        }
    }
    
    func saveImage(profileImageURL: URL , completion: @escaping ((_ url: URL?) -> ())){
        let db = Firestore.firestore()
        
        /*let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
        }*/
        
        db.collection("posts").addDocument(data: ["title":postTitleTextField.text!,"description":postBodyTextField.text!,"image_url":profileImageURL.absoluteString]){
            (error)in
            if error != nil{
                let alert = UIAlertController(title: "Notification", message:"error", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            print("item added")
            self.clear()
        }
        
    }
    
    func clear(){
        postTitleTextField.text?.removeAll()
        postBodyTextField.text?.removeAll()
        postImage.image = nil
    }
    
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.postImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    

}
