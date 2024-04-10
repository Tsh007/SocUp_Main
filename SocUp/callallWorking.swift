////
////  callController.swift
////  SocUp
////
////  Created by Tejash Singh on 26/03/24.
////
//
//import UIKit
//import WebKit
//
//import FirebaseCore
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseDatabase
//import AVFoundation
//
//class callController: UIViewController, WKUIDelegate, WKNavigationDelegate {
//
//    
//    var uid=""
//    var incoming=""
//    var createdBy=""
//    var isAvailable=true
//    var isAudio = true
//    var isVideo = false
//
//    @IBOutlet var customView: UIView!
//    
//    @IBOutlet var webView: WKWebView!
////    var webView: WKWebView!
//    
//    
//    var isPeerConnected = false
//    
//    var friendsUid = ""
//    
//    let database = Database
//        .database(url: "https://socup-23829-default-rtdb.asia-southeast1.firebasedatabase.app/")
//        .reference()
//    
////    override func loadView() {
////
//////        view.addSubview(webView)
//////        view = webView
////
////    }
////
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("web page loaded")
////        webView.evaluateJavaScript("document.querySelector(\"h1\").innerHTML=\"changed heading\"", completionHandler: {_,_ in
////            print("evaluate function evaluated")
////        })
//        //cheking if things are working fine or not
////        webView.evaluateJavaScript("hello()", completionHandler: {(result, error) in
////            if let result = result {
////                print("result: \(result)")
////            }
////            if let error = error {
////                print("error: \(error)")
////            }
////        })
//        
//        initializePeer()
//        
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let webConfiguration = WKWebViewConfiguration()
////        webConfiguration.allowsInlineMediaPlayback = true
////        webConfiguration.allowsPictureInPictureMediaPlayback = true
//        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
//        
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
////        webView = WKWebView(frame: customView.bounds, configuration: WKWebViewConfiguration())
//        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//        webView.isInspectable = true
//        view = webView
////        customView.addSubview(webView)
////        view.addSubview()
//        friendsUid = incoming
//
//        setUpWebView()
////        customView = webView
//        //        callJSFunctionFromSwift(function: "javascript:hello()")
////        initializePeer()
//        // print(uid)
//        // print(incoming)
//        // print(createdBy)
//        // print(isAvailable)
//    }
//    
////    func makeCoordinator()->Coordinator{
////        return Coordinator()
////    }
//    
//    
//    func setUpWebView(){
//        
////        let coordinator = makeCoordinator()
////        let userContentController = WKUserContentController()
////        userContentController.add(coordinator, name: "iOS")
////        let configuration = WKWebViewConfiguration()
////        configuration.userContentController = userContentController
//        //the above is not yet applied to the webview
//        
//        
//            guard let url = Bundle.main.url(forResource: "call", withExtension: "html") else {return}
//            webView.loadFileURL(url, allowingReadAccessTo: url)
//
////        use evalute javascript when the page is fully loaded so implement next in webview did finish delegate method
//        
////        webView.evaluateJavaScript("document.querySelector("+"h1"+").innerHTML="+"changed heading")
//    }
//    
//    
//    func initializePeer(){
//        let uniqueId = uid
////        callJSFunctionFromSwift(function: "init("+uniqueId+")")
//        
////        webView.evaluateJavaScript("init(\""+uniqueId+"\")", completionHandler: {(result, error) in
////            if let result = result {
////                print("result: \(result)")
////            }
////            if let error = error {
////                print("error in init function : \(error)")
////            }
////        })
//        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////        if createdBy == uid {
////            database.child("users").child(uid).child("connId").setValue(uniqueId)
////            database.child("users").child(uid).child("isAvailable").setValue(true)
////        }else{
////            friendsUid = createdBy
////            let newReference = Database
////                .database(url: "https://socup-23829-default-rtdb.asia-southeast1.firebasedatabase.app/")
////                .reference()
////
////            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
////                let connId = self.friendsUid
//////                self.callJSFunctionFromSwift(function: "startCall("+connId+")")
////                 self.webView.evaluateJavaScript("startCall(\""+connId+"\")", completionHandler: {(result, error) in
////                    if let result = result {
////                        print("result: \(result)")
////                    }
////                    if let error = error {
////                        print("error in start call functions : \(error)")
////                    }
////                })
////            }
//        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////            newReference.child("users").child(friendsUid).child("connId").observe(.childChanged) { snapshot in
////                if snapshot.value != nil{
////                    self.sendCallRequest()
////                }
////            }//add a 2 second delay
//        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////        }
//        
//    }
//    
////    func sendCallRequest(){
////        if !isPeerConnected{
////            return
////        }
////        listenConnId()
////    }
////
////    func listenConnId(){
////        database.child("users").child(friendsUid).child("connId").observeSingleEvent(of: .childChanged) { snapshot in
////            if snapshot.value != nil{
////                let connId = snapshot.key
////                self.callJSFunctionFromSwift(function: "startCall("+connId+")")
////            }
////        }
////    }
////
////    func onPeerConnected(){
////        isPeerConnected = true
////    }
////
////    //this will call javasript functions in our webview
////    func callJSFunctionFromSwift( function : String){
////        webView.evaluateJavaScript(function, completionHandler: nil)
////    }
//    
//    @IBAction func micBtnPressed(_ sender: UIButton) {
//        isAudio = !isAudio
//        self.webView.evaluateJavaScript("toggleAudio(\""+"\(isAudio)"+"\")", completionHandler: {(result, error) in
//            if let result = result {
//                print("result: \(result)")
//            }
//            if let error = error {
//                print("error toggle audio function : \(error)")
//            }
//        })
//    }
//    @IBAction func videoBtnPressed(_ sender: UIButton) {
//        isVideo = !isVideo
//        print(isVideo)
//        
//        self.webView.evaluateJavaScript("toggleVideo(\""+"\(isVideo)"+"\")", completionHandler: {(result, error) in
//            if let result = result {
//                print("result: \(result)")
//            }
//            if let error = error {
//                print("error toggle video function : \(error)")
//            }
//        })
//    }
////    @IBAction func callCutPressed(_ sender: UIButton) {
////    }
//    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        // Get the new view controller using segue.destination.
////        // Pass the selected object to the new view controller.
////    }
//    
//
//    
//}
//
//class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler{
//    var webView: WKWebView?
//            
//            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//                self.webView = webView
//            }
//            
//            // receive message from wkwebview
//            func userContentController(
//                _ userContentController: WKUserContentController,
//                didReceive message: WKScriptMessage
//            ) {
//                print(message.body)
//                let date = Date()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    self.messageToWebview(msg: "hello, I got your messsage: \(message.body) at \(date)")
//                }
//            }
//            
//            func messageToWebview(msg: String) {
//                self.webView?.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(msg)')")
//            }
//    
//}
//
//
//
