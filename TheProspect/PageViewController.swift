//
//  PageViewController.swift
//  TheProspect
//
//  Created by Caroline Liu on 7/21/15.
//  Copyright (c) 2015 The Prospect. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet var content: UIWebView!
    
    var feedURL = ""
    var selectedFeedTitle = String()
    var selectedFeedContent = String()
    var selectedFeedURL = String()
    var selectedFeedAuthor = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let urlStr = selectedFeedURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let url = NSURL(string:urlStr!)
        let request = NSURLRequest(URL:url!);
        content.loadRequest(request);
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}