//
//  WebViewController.swift
//  MobvenChallenge
//
//  Created by Yavuz BİTMEZ on 15/04/2019.
//  Copyright © 2019 Yavuz BİTMEZ. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var urlget = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let baseUrl = "https://www.imdb.com/title/\(urlget)"
        print(urlget)
        let url = URL(string: baseUrl)
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)
    }
    @IBAction func backBase(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
   
}
