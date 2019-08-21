//
//  DetailViewController.swift
//  SearchMovie
//
//  Created by cscoi014 on 2019. 8. 21..
//  Copyright © 2019년 GA-Z-A. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!

    var link: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: self.view.frame)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // Do any additional setup after loading the view.
        print(link)
        let url = URL(string: link)
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
