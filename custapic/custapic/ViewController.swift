//
//  ViewController.swift
//  custapic
//
//  Created by Akash G on 12/01/16.
//  Copyright © 2016 akash. All rights reserved.
//

import UIKit
//import Haneke
import Alamofire
//import PhotoCell
//import JsonSerializerSwift

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var indexPath = NSIndexPath()
    var imagesArray = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        search("doodle")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.imagesArray = []
        self.collectionView.reloadData()
        search(searchBar.text!)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.imagesArray.count > 0 {
            return self.imagesArray.count
        }
        else {
            return 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let photoCell = segue.destinationViewController as! PhotoViewController
        photoCell.url = self.imagesArray[self.indexPath.row]["url"] as? String
        photoCell.navigationItem.title = self.imagesArray[self.indexPath.row]["title"] as? String
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //Didselect
        self.indexPath = indexPath
        self.performSegueWithIdentifier("showPhoto", sender: self)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
        photoCell.url = self.imagesArray[indexPath.row]["url"] as? String
        photoCell.source = self.imagesArray[indexPath.row]["source"] as? String
        photoCell.title = self.imagesArray[indexPath.row]["title"] as? String
        
        return photoCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height / 2 )
    }
    
    func search ( query: String ) {
        let queryAlt = query.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        let request = Alamofire.request(.GET, "http://localhost:8000/api/\(queryAlt)")
        request.responseJSON { (response) -> Void in
            guard let data = response.result.value else {
                print ("Requeest failed with error")
                return
            }
           // let json = JSONSerializer.toJson(data)
            print(data)
           // print(json)
            for photo in data as! [AnyObject] {
                var imageDictionary = [String:String]()
                imageDictionary["title"]  = photo["title"] as? String
                imageDictionary["source"] = photo["source"] as? String
                imageDictionary["url"] =  photo["url"] as? String
                self.imagesArray.append(imageDictionary)
                
            }
            self.collectionView.reloadData()
        }
    
    }
    
    
    }

