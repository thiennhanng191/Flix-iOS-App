//
//  WebkitViewController.swift
//  Flix
//
//  Created by Nhan Nguyen on 12/3/21.
//  Copyright © 2021 Nhan Nguyen. All rights reserved.
//

import UIKit
import WebKit

class WebkitViewController: UIViewController, WKUIDelegate {

//    @IBOutlet weak var webkitView: WKWebView!
    var webView: WKWebView!
    var trailerUrl: String!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: trailerUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
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
