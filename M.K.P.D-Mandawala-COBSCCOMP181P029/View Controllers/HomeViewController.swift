//
//  HomeViewController.swift
//  M.K.P.D-Mandawala-COBSCCOMP181P029
//
//  Created by Pandula Mandawala on 11/18/19.
//  Copyright © 2019 Pandula Mandawala. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class HomeViewController: UIViewController {
    
    var postsList : [PostModel] = []
    var window: UIWindow?
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
        getStudentData()
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
    
    func getStudentData(){
        let db = Firestore.firestore()
        
        db.collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let title = document.get("title") as! String
                    let description = document.get("description") as! String
                    //let user = document.get("username") as! String
                    let image_url = document.get("image_url") as! String
                    
                    let post = PostModel(
                        title: title,
                        description: description,
                        //user: User ,
                        image_url: image_url)
                    
                    self.postsList.append(post)
                    
                }
                print("*********")
                print(self.postsList)
                self.tableview.reloadData()
            }
        }
    }
    
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! CellView
        
        cell.selectionStyle = .none
        
        cell.populateData(post: postsList[indexPath.row])
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    //        performSegue(withIdentifier: "friendDetail", sender: postsList[indexPath.row])
    //    }
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "friendDetail" {
    //            if let viewController = segue.destination as? postsViewController{
    //
    //                viewController.posts = sender as? AddPostModel
    //            }
    //        }
    //    }
}


