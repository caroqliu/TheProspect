//
//  PageViewController.swift
//  TheProspect
//
//  Created by Caroline Liu on 7/21/15.
//  Copyright (c) 2015 The Prospect. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var content: UITextView!
    
    var feedURL = ""
    var selectedFeedTitle = String()
    var selectedFeedContent = String()
    var selectedFeedURL = String()
    var selectedFeedAuthor = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.articleTitle!.text = selectedFeedTitle;
        self.author!.text = "by " + selectedFeedAuthor;
        
        let encodedData = selectedFeedContent.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        let attributedString = NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil, error: nil)!
        
        self.content!.text = attributedString.string

        // myWebView.loadRequest(NSURLRequest(URL: NSURL(string: feedURL)!))
        
        // Do any additional setup after loading the view, typically from a nib.
        // var feedContent:String! = "<h3>\(selectedFeedTitle)</h3>\(selectedFeedContent)"
        // myWebView.loadHTMLString(feedContent, baseURL: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}