//
//  GetUserIDModel.swift
//  MusicListApp00
//
//  Created by Manabu Kuramochi on 2021/05/23.
//

import Foundation
import Firebase
import PKHUD


class GetUserIDModel {
    
    var userID:String! = ""
    var userName:String! = ""
    var ref:DatabaseReference! = Database.database().reference().child("profile")
    
    init(snapshot:DataSnapshot) {
        
        ref = snapshot.ref
        
        if let value = snapshot.value as? [String:Any] {
            
            userID = value["userID"] as? String
            userName = value["userName"] as? String
            
            
        }
        
    }
    
    
}

