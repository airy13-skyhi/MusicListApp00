//
//  SaveProfile.swift
//  MusicListApp00
//
//  Created by Manabu Kuramochi on 2021/05/19.
//

import Foundation
import Firebase
import PKHUD


class SaveProfile {
    
    var userID:String = ""
    var userName:String = ""
    var ref:DatabaseReference!
    
    init(userID:String, userName:String) {
        
        self.userID = userID
        self.userName = userName
        
        ref = Database.database().reference().child("profile").childByAutoId()
        
    }
    
    
    init(snapShot:DataSnapshot) {
        
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any] {
            
            userID = (value["userID"] as? String)!
            userName = (value["userName"] as? String)!
        }
    }
    
    
    func toContents() -> [String:Any] {
        
        return ["userID":userID, "userName":userName as Any]
    }
    
    
    
    func saveProfile() {
        
        ref.setValue(toContents())
        UserDefaults.standard.set(ref.key, forKey: "autoID")
    }
    
    
}



