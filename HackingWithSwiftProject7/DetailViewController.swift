//
//  DetailViewController.swift
//  HackingWithSwiftProject7
//
//  Created by Chen, Sihan on 2020-03-31.
//  Copyright © 2020 Chen, Sihan. All rights reserved.
//

import UIKit
import WebKit


class DetailViewController: UIViewController {

    
    var webView : WKWebView!
    // For use of HTML
    var detailItem : Petition?
    
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else {
            return
        }
     // detailItem is a petition, therefore in the webView you can use .body of the petition
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-
        scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
