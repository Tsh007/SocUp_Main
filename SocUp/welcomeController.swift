//
//  ViewController.swift
//  SocUp
//
//  Created by Tejash Singh on 26/03/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

class welcomeController: UIViewController {

    let user = Auth.auth().currentUser
    var ref: DatabaseReference! = Database.database(url: "https://socup-23829-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getStartedPressed(_ sender: UIButton) {
        Task{@MainActor in
            //        if  user != nil {
            //            print(Auth.auth().currentUser!)
            //            print(Auth.auth().currentUser!.email!)
            //            print(Auth.auth().currentUser!.uid)
            //            performSegue(withIdentifier: "directlyGoToMain", sender: self)
            //
            //        } else {
            //            performSegue(withIdentifier: "directlyGoToMain", sender: self)
            //            performSegue(withIdentifier: "goToLogin", sender: self)
            //
            //        }
            var unique : String = ""
            if let userID = Auth.auth().currentUser?.uid{
                do {
                    let snapshot = try await ref.child("Profiles/\(userID)/uId").getData()
                    unique = snapshot.value as? String ?? ""
                    print(unique+" from ")
                } catch {
                    print(error)
                }
                
            }
            
            if unique == ""{
                 performSegue(withIdentifier: "goToLogin", sender: self)
            }else{
                performSegue(withIdentifier: "directlyGoToMain", sender: self)
            }
            
        }
        
    }
    
}

