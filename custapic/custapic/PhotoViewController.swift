//
//  PhotoViewController.swift
//  custapic
//
//  Created by Akash G on 15/01/16.
//  Copyright © 2016 akash. All rights reserved.
//

import UIKit
import Haneke
class PhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var url:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImage(self.url)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImage (urlString: String){
        let url = NSURL(string: urlString)
        self.imageView.hnk_setImageFromURL(url!)
    }
    @IBAction func savePhoto(sender: UIBarButtonItem) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
