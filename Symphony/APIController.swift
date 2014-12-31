//
//  APIController.swift
//  Symphony
//
//  Created by Jian Yao Ang on 12/31/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

import Foundation

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

class APIController {
    
    var delegate: APIControllerProtocol
    
    //without init, can't create APIController
    init(delegate: APIControllerProtocol){
        self.delegate = delegate
    }
    
    func searchItunes(searchFor: String) {
        
        //within itunes, words are separated by + symbols
        let searchTerm = searchFor.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        
        if let escapedSearchTerm = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
            let itunesUrl = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music&entity=album"
            
            let url = NSURL(string: itunesUrl)
            
            let urlSession = NSURLSession.sharedSession()
            
            let task = urlSession.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                if (error != nil) {
                    println(error.localizedDescription)
                }
                
                var theError: NSError?
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &theError) as NSDictionary
                
                if (theError != nil) {
                    println("json returned error: \(theError?.localizedDescription)")
                }
                
                let results: NSArray = jsonResult["results"] as NSArray
                self.delegate.didReceiveAPIResults(jsonResult)
                
            })
            task.resume()
        }
    }

    
}