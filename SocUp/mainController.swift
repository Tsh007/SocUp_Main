//
//  mainController.swift
//  SocUp
//
//  Created by Tejash Singh on 26/03/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import AVFoundation

class mainController: UIViewController {

    
    var ref: DatabaseReference! = Database.database(url: "https://socup-23829-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    
    var uID = ""

    
    func askPermission() async {
        let videoStatus = AVCaptureDevice.authorizationStatus(for: .video)
        let audioStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        while ( audioStatus != .authorized || videoStatus != .authorized){
            if audioStatus == .denied || audioStatus == .restricted || videoStatus == .denied || videoStatus == .restricted{
                goToSettings()
                break
            }else{
                await AVCaptureDevice.requestAccess(for: .video)
                await AVCaptureDevice.requestAccess(for: .audio)
            }
            
        }
        
//        let status = AVCaptureDevice.authorizationStatus(for: .video)
//    if(status == .authorized){
//        print("autho")
//    }else if(status == .denied){//usefull
//        print("denied")
//    }else if(status == .notDetermined){
//        print("not determined")
//    }else if(status == .restricted){
//        print("restricted")
//    }else{
//        print("none")
//    }
        
    }
    
    func isAuthorized() -> Bool{
        let audioStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        let videoStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if audioStatus == .authorized && videoStatus == .authorized{
            return true
        }else {
            return false
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{@MainActor in
            
            if let userID = Auth.auth().currentUser?.uid{
                do {
                    uID = userID
                    let snapshot = try await ref.child("Profiles/\(userID)/coins").getData()
                    let coins = snapshot.value as? Int ?? 0
                    print("\(coins)" + " from main controller")
                    coinLabel.text="You Have : \(coins)"
                    
                    
                } catch {
                    print(error)
                }
                
            }
            
        }
        
    }
    
    @IBOutlet var coinLabel: UILabel!
    
    
    @IBAction func findPressed(_ sender: UIButton) {
        Task { @MainActor in
            if isAuthorized() == true{
                performSegue(withIdentifier: "goToConnecting", sender: self)
            }else{
                await askPermission()
            }
        }
    }
    
    func goToSettings(){
        
        //this generates an alert for going to settings and granting the permissions
        
        let alertController = UIAlertController(title: "TITLE", message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
             }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let connectingVC = segue.destination as? connectingController
        else{return}
        
        connectingVC.uid = uID
    }
    
}
            
