//
//  loginScreen.swift
//  SocUp
//
//  Created by Tejash Singh on 26/03/24.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore
import FirebaseDatabase

class loginController: UIViewController {

    //    let viewModel = AuthenticationViewModel()
    
    //    func signInWithGoogle() {
    //        Task {
    //            if await viewModel.signInWithGoogle() == true {
    //              dismiss(animated: false)
    //          }
    //        }
    //    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //        signInWithGoogle()
        // Do any additional setup after loading the view.
    }
    
   
    
    //read docs for understanding
    //https://developers.google.com/identity/sign-in/ios/people
    //https://www.youtube.com/watch?v=IzyOdKm0bWE&list=PL0aNJ8IiTUcrzShyNzYZuwrXxJY25Xws2&index=33
    
    @IBAction func googleSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self){ signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            guard let idToken = user.idToken else { print("id token missing"); return }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential){ result ,error in
                guard error == nil else { return }
                let firebaseUser = result!.user
                
                //if all goes well this will print
//                print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
                let photoUrlString=firebaseUser.photoURL?.absoluteString
                
                //make all this asynorous at last for now just implementing the idea
                self.saveData(uId:firebaseUser.uid, city: "", name: firebaseUser.displayName ?? "",photoUrl: photoUrlString ?? "https://www.example.com")
                
                // If sign in succeeded, display the app's main content View.
                self.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    //=============================
    //make all this asyncnorous later for now just implementing the idea
    //=============================
    func saveData(uId:String, city:String, name: String, photoUrl: String){
        var ref: DatabaseReference!

        ref = Database.database(url: "https://socup-23829-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
//        let firebaseUser = dataModel(uId: uId, city: city, name: name)
        
        //giving initial coins as 500
        let coins = 500
        
        ref.child("Profiles").child(uId).setValue(["uId":uId,"city":city,"name":name,"photoUrl":photoUrl,"coins":coins]) { Error, DatabaseReference in
            guard Error == nil else{
                print("error occured while adding data to database : \(String(describing: Error))")
                return}
            
        }
    }
}





//below given code is for swift ui important for understanding also refer to google docs
//for more information
//https://developers.google.com/identity/sign-in/ios/people
//https://developers.google.com/identity/sign-in/ios/backend-auth





//@MainActor
//class AuthenticationViewModel : ObservableObject{
//    
//    
//    @Published  var errorMessage: String = ""
//    enum AuthenticationError: Error {
//      case tokenError(message: String)
//    }
//    
//    
//    func signInWithGoogle() async -> Bool {
////        guard let clientID = FirebaseApp.app()?.options.clientID else {
////          fatalError("No client ID found in Firebase configuration")
////        }
////        let config = GIDConfiguration(clientID: clientID)
////        GIDSignIn.sharedInstance.configuration = config
//
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first,
//              let rootViewController = window.rootViewController else {
//                    print("There is no root view controller!")
//                    return false
//                }
//
//        
//          do {
//              print(1)
//              let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
//              print(2)
//            let user = userAuthentication.user
//              print(3)
//            guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: "ID token missing") }
//            let accessToken = user.accessToken
//
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
//                                                           accessToken: accessToken.tokenString)
//
//            let result = try await Auth.auth().signIn(with: credential)
//            let firebaseUser = result.user
//            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
//            return true
//          }
//          catch {
//            print(error.localizedDescription)
//            self.errorMessage = error.localizedDescription
//            return false
//          }
//      }


