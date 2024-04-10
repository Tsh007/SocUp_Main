//
//  connectingController.swift
//  SocUp
//
//  Created by Tejash Singh on 30/03/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import AVFoundation

class connectingController: UIViewController {

//    var ref: DatabaseReference! = Database.database(url: "https://socup-23829-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    var uid = ""
    var incoming=""
    var createdBy=""
    var isAvailable=true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(uid)
        var key : String=""
        let database = Database
            .database(url: "https://socup-23829-default-rtdb.asia-southeast1.firebasedatabase.app/")
            .reference()//same as ref used before//FIRDatabase has been renamed to Databse
        
        Task{@MainActor in
//            print("123\n")
            
            do{
                let snapshot = try await database.child("users").queryOrdered(byChild: "status").queryEqual(toValue: 0).queryLimited(toFirst: 1).getData()
//                print(out)
                if(snapshot.childrenCount > 0){
                    //room  available
                    for child in snapshot.children {
                        key = (child as AnyObject).key as String//vimp method to get child
                    }
//                    print(database.child("users").child(key).child("incoming"))
                    
                    do{
                        try await database.child("users").child(key).child("incoming").setValue(uid)
                        try await database.child("users").child(key).child("status").setValue(1)
                    }catch{
                        print(error)
                    }
                    
                    createdBy = key
                    isAvailable = true
                    incoming = uid
                    
                    self.performSegue(withIdentifier: "goToCall", sender: self)
                    
                }else {
                    //room not available
                    //function to create room
                    saveData(uId: uid, isAvailable: true, status: 0)
                    
                    //get into the created room
                    do{
                        let newSnapshot = try await database.child("users").queryOrdered(byChild: "status").queryEqual(toValue: 0).queryLimited(toFirst: 1).getData()
                        if(newSnapshot.childrenCount > 0){
//                            print(newSnapshot)
//                            print(newSnapshot.childSnapshot(forPath: uid).childSnapshot(forPath: "createdBy").value as! String)
//                            print(newSnapshot.childSnapshot(forPath: uid).childSnapshot(forPath: "incoming").value as! String)
//                            print(newSnapshot.childSnapshot(forPath: uid).childSnapshot(forPath: "isAvailable").value as! Bool)
                            incoming = newSnapshot.childSnapshot(forPath: uid).childSnapshot(forPath: "incoming").value as! String
                            createdBy = newSnapshot.childSnapshot(forPath: uid).childSnapshot(forPath: "createdBy").value as! String
                            isAvailable = newSnapshot.childSnapshot(forPath: uid).childSnapshot(forPath: "isAvailable").value as! Bool
                            performSegue(withIdentifier: "goToCall", sender: self)
                        }
                    }catch{
                        print("error creating room or getting new room")
                    }
                }
            }catch{
                print("error getting data from firebase : "+"\(error)")
            }
            //=============================
           //vimp observer listner functions of firebase are not working right now for me so there might be some crashes as after creating room there might be some problem so see that at last add listners or observers at your room creations
            //actually what will happen after creating the room user will go to video call even if no one has joined but we want it to stay on connecting controller until someone else has joined that can be done observer or listner hence not implemented that for now but will implement at last or future
            //test this using two simulators simultaneous
            //==============================
            
//            database
//                .child("users")
//                .queryOrdered(byChild: "status")
//                .queryEqual(toValue: 0)
//                .queryLimited(toFirst: 1)
//                .observe(.childChanged) { snapshot in
//                    if(snapshot.childrenCount > 0){
//                        //room available
//                        print("yes\n")
//                    }else{
//                        //room not available
//                        print("not\n")
//                        database
//                            .child("users")
//                            .child(self.uid)
//                            .setValue(["createdBy":self.uid,"incoming":self.uid,"isAvailable":true,"status":0]){
//                                Error, DatabaseReference in
//                                guard Error == nil else{
//                                    
//                                    print("error occured while adding data to database : \(String(describing: Error))")
//                                    return}
//                                
//                            }
//                        database.child("users")
//                            .child(self.uid).observe(.childChanged) { snapshot in
//                                if snapshot.hasChild("status"){
//                                    //                                if(Int(snapshot.childSnapshot(forPath: "status")) == 1){
//                                    //
//                                    //                                }
//                                    print(snapshot)
//                                    self.performSegue(withIdentifier: "goToCall", sender: self)
//                                }
//                            }
//                    }
//                }
        }
    }
    
    func saveData(uId:String, isAvailable:Bool, status:Int){
        var ref: DatabaseReference!

        ref = Database.database(url: "https://socup-23829-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
        
//        let firebaseUser = dataModel(uId: uId, city: city, name: name)
    
        
        ref.child("users").child(uId).setValue(["createdBy":uId,"incoming":uId,"isAvailable":isAvailable,"status":status]) { Error, DatabaseReference in
            guard Error == nil else{
                print("error occured while adding data to database : \(String(describing: Error))")
                return}
            
        }
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let callVC = segue.destination as? callController
        else{return}
        
        callVC.uid = uid
        callVC.createdBy = createdBy
        callVC.incoming = incoming
        callVC.isAvailable = isAvailable
        
    }
    
}
