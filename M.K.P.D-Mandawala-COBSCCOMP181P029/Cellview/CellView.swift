//
//  CellView.swift
//  M.K.P.D-Mandawala-COBSCCOMP181P029
//
//  Created by Pandula Mandawala on 11/22/19.
//  Copyright © 2019 Pandula Mandawala. All rights reserved.
//

import UIKit
import Nuke

class CellView: UITableViewCell {
    
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var postTitle: UILabel!
    

    @IBOutlet weak var postContent: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateData(post: PostModel)  {
        
        postTitle.text = post.title
        postContent.text = post.description
        //userName.text = post.user
        
        let imgUrl = URL(string: post.image_url)
        
        Nuke.loadImage(with: imgUrl!, into: postImage)
        Nuke.loadImage(with: imgUrl!, into: userImage)
        
    }

    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/

}
