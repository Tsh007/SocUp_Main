//import UIKit
//import WebKit
//import AVFoundation
//
//
//class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
//
//    var webView: WKWebView!
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("web page loaded")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
//        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//        webView.isInspectable = true
//        
//        setUpWebView()
//
//
//    }
//    
//    func setUpWebView(){
//        guard let url = Bundle.main.url(forResource: "call", withExtension: "html") else {return}
//        webView.loadFileURL(url, allowingReadAccessTo: url)
//    }
//    
//
//}
