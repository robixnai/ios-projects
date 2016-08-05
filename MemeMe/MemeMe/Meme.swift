//
//  Meme.swift
//  MemeMe
//
//  Created by Guilherme Silva on 05/08/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String?
    var bottomText: String?
    var memeImage : UIImage?
    var originalImage : UIImage?
    
    init(top: String, bottom: String, original: UIImage, meme:UIImage) {
        topText = top
        bottomText = bottom
        originalImage = original
        memeImage = meme
    }
    
}
