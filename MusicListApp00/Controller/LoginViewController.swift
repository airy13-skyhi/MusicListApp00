//
//  LoginViewController.swift
//  MusicListApp00
//
//  Created by Manabu Kuramochi on 2021/05/19.
//

import UIKit
import Firebase
import FirebaseAuth
import DTGradientButton


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let firebaseAuth = Auth.auth()
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        loginButton.setGradientBackgroundColors([UIColor(hex:"E21F70"), UIColor(hex:"FF4D2C")], direction: .toBottom, for: .normal)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        if textField.text?.isEmpty != true {
            
            UserDefaults.standard.set(textField.text, forKey: "userName")
            
        }else {
            
            //空なら振動させる
            let generator = UINotificationFeedbackGenerator().notificationOccurred(.error)
            print("振動")
            
            
            
        }
        
        
        firebaseAuth.signInAnonymously { Result, Error in
            
            if Error == nil {
                
                guard let user = Result?.user else { return }
                
                let userID = user.uid
                UserDefaults.standard.set(userID, forKey: "userID")
                
                let saveProfile = SaveProfile(userID: userID, userName: self.textField.text!)
                
                saveProfile.saveProfile()
                self.dismiss(animated: true, completion: nil)
                
                
                
            }else {
                
                print(Error?.localizedDescription as Any)
            }
            
        }
        
        
        
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
