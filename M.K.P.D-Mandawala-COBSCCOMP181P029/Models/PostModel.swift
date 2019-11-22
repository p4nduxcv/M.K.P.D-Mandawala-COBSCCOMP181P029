//
//  PostModel.swift
//  M.K.P.D-Mandawala-COBSCCOMP181P029
//
//  Created by Pandula Mandawala on 11/22/19.
//  Copyright © 2019 Pandula Mandawala. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    
    var title : String!
    var description : String!
//    var user: String!
    var image_url: String!
    
    init(title: String, description: String,image_url:String) {
        self.title = title
        self.description = description
//        self.user=user
        self.image_url=image_url
    }
    
    
    
    
}
