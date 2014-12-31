//
//  DetailsViewController.swift
//  Symphony
//
//  Created by Jian Yao Ang on 12/31/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var theLabel: UILabel!
    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.theLabel.text = self.album?.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
