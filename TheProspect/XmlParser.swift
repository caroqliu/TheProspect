//
//  XmlParser.swift
//  TheProspect
//
//  Created by Caroline Liu on 7/21/15.
//  Copyright (c) 2015 The Prospect. All rights reserved.
//

import Foundation

class XmlParser: NSObject, NSXMLParserDelegate {

    var parser = NSXMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var fdescription = NSMutableString()
    var fauthor = NSMutableString()
    var fcontent = NSMutableString()
    
    func initWithUrl(url: NSURL) -> AnyObject {
        startParse(url)
        return self
    }
    
    func startParse(url :NSURL) {
        feeds = []
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
    func allFeeds() -> NSMutableArray {
        return feeds
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        element = elementName
        
        // naming all the elements
        if (element as NSString).isEqualToString("item") {
            elements = NSMutableDictionary.alloc()
            elements = [:]
            ftitle = NSMutableString.alloc()
            ftitle = ""
            link = NSMutableString.alloc()
            link = ""
            fdescription = NSMutableString.alloc()
            fdescription = ""
            fauthor = NSMutableString.alloc()
            fauthor = ""
            fcontent = NSMutableString.alloc()
            fcontent = ""
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // processing all the elements
        
        if (elementName as NSString).isEqualToString("item") {
            if ftitle != "" {
                elements.setObject(ftitle, forKey: "title")
            }
            
            if link != "" {
                elements.setObject(link, forKey: "link")
            }
            
            if fdescription != "" {
                elements.setObject(fdescription, forKey: "description")
            }
            
            if fauthor != "" {
                elements.setObject(fauthor, forKey: "dc:creator")
            }
            
            if fcontent != "" {
                elements.setObject(fcontent, forKey: "content:encoded")
            }
            
            feeds.addObject(elements)
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
        // constructing the table
        
        if element.isEqualToString("title") {
            ftitle.appendString(string!)
        }
            
        else if element.isEqualToString("link") {
            link.appendString(string!)
        }
            
        else if element.isEqualToString("description") {
            fdescription.appendString(string!)
        }
        
        else if element.isEqualToString("dc:creator") {
            fauthor.appendString(string!)
        }
        
        else if element.isEqualToString("content:encoded") {
            let str = string!.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
            fcontent.appendString(str)
        }
        
    }

    
}