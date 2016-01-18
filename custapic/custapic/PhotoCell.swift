//
//  PhotoCell.swift
//  custapic
//
//  Created by Akash G on 12/01/16.
//  Copyright © 2016 akash. All rights reserved.
//

import UIKit
import Haneke
class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    var url: String? {
        didSet {
            setImage(url!)
        }
    }
    var source: String? {
        didSet{
            self.sourceImage.layer.cornerRadius = self.sourceImage.frame.height / 2
            self.sourceImage.clipsToBounds = true
            
            switch(source!){
                case  "flickr":
                    self.sourceImage.image = UIImage(named: "flickr")
                case "tumblr":
                    self.sourceImage.image = UIImage(named: "tumblr")
                default:
                    print("error")
                }
        }
    }
    
    var title: String? {
        didSet{
            self.titleLabel.text = title!
        }
    }
    
    func setImage (url: String) {
        let imageUrl = NSURL (string: url)
        self.imageView.hnk_setImageFromURL(imageUrl!, placeholder: UIImage(named: "placeholder") , format: Format<UIImage>(name: "image"), failure: { (error) -> () in
            }) { (image) -> () in
                self.imageView.image = image
        }
    }
}
