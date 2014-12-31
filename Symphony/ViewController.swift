//
//  ViewController.swift
//  Symphony
//
//  Created by Jian Yao Ang on 12/31/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIControllerProtocol {

    @IBOutlet weak var theTableView: UITableView!
    var albums = [Album]()
    
    var itunesAPI: APIController?
    
    //[String : UIImage] --> Dictionary where key is String, value is UIImage
    //adding the () is calling the constructor to init the dictionary
    var imageCache = [String : UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.itunesAPI = APIController(delegate: self)
        self.itunesAPI!.searchItunes("Ed Sheeran")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albums.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let itunesData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
    
        let album = self.albums[indexPath.row]
        
//        let itunesUrlString: NSString = album["artworkUrl60"] as NSString
//        let itunesImgURL: NSURL? = NSURL(string: itunesUrlString)
//        let itunesImgData = NSData(contentsOfURL: itunesImgURL!)
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CellID") as UITableViewCell
        
        cell.textLabel?.text = album.title
        
//        cell.textLabel?.text = itunesData["trackName"] as? String
//        cell.imageView?.image = UIImage(data: itunesImgData!)
        
        return cell
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        var resultsArray: NSArray = results["results"] as NSArray
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.albums = Album.albumsWithJSON(resultsArray)
            self.theTableView.reloadData()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var detailsViewController: DetailsViewController = segue.destinationViewController as DetailsViewController
        
        var albumIndex = self.theTableView.indexPathForSelectedRow()!.row
        
        var selectedAlbum = self.albums[albumIndex]
        
        detailsViewController.album = selectedAlbum
    }
    
}

