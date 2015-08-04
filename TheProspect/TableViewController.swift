//
//  TableViewController.swift
//  TheProspect
//
//  Created by Caroline Liu on 7/21/15.
//  Copyright (c) 2015 The Prospect. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {
   
   var myFeed : NSArray = []
   var url: NSURL = NSURL()

    override func viewDidLoad() {
        super.viewDidLoad()

         self.tableView.rowHeight = 70
         self.tableView.dataSource = self
         self.tableView.delegate = self
      
      url = NSURL(string: "http://www.theprospect.net/feed/")!
      loadRss(url);
      
    }
   
   func loadRss(data: NSURL) {
      var myParser : XmlParser = XmlParser.alloc().initWithUrl(data) as! XmlParser
      
      // putting feed in array
      myFeed = myParser.feeds
      
      tableView.reloadData()
   }
   
   func parserDidEndDocument(parser: NSXMLParser) {
      
      // reloading the table
      self.tableView.reloadData()
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // disposing of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myFeed.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = (myFeed.objectAtIndex(indexPath.row).objectForKey("title") as! String)
        cell.detailTextLabel?.numberOfLines = 3
        cell.detailTextLabel?.text = "by " + (myFeed.objectAtIndex(indexPath.row).objectForKey("dc:creator") as! String)
        return cell
    }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      if segue.identifier == "ViewPost" {
         if let destinationVC = segue.destinationViewController as? PageViewController {
            let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
            destinationVC.selectedFeedTitle = (myFeed.objectAtIndex(indexPath!.row).objectForKey("title") as! String)
            destinationVC.selectedFeedAuthor = (myFeed.objectAtIndex(indexPath!.row).objectForKey("dc:creator") as! String)
            destinationVC.selectedFeedURL = (myFeed.objectAtIndex(indexPath!.row).objectForKey("link") as! String)
         }
      }
   }

}
