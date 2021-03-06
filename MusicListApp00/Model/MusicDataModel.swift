//
//  MusicDataModel.swift
//  MusicListApp00
//
//  Created by Manabu Kuramochi on 2021/05/20.
//

import Foundation
import Firebase
import PKHUD


class MusicDataModel {
    
    var artistName:String! = ""
    var musicName:String! = ""
    var previewURL:String! = ""
    var imageString:String! = ""
    var userID:String! = ""
    var userName:String! = ""
    var artistViewUrl:String! = ""
    let ref:DatabaseReference!
    
    var key:String! = ""
    
    
    //外部データを内部に取り込む
    init (artistName:String,musicName:String,previewURL:String,imageString:String,userID:String,userName:String) {
        
        self.artistName = artistName
        self.musicName = musicName
        self.previewURL = previewURL
        self.imageString = imageString
        self.userID = userID
        self.userName = userName
        
        ref = Database.database().reference().child("users").child(userID).childByAutoId()
    }
    
    
    //DataSnapshotを引き換えに、値をつくる
    init(snapshot:DataSnapshot) {
        
        ref = snapshot.ref
        if let value = snapshot.value as? [String:Any] {
            
            artistName = value["artistName"] as? String
            musicName = value["musicName"] as? String
            previewURL = value["previewURL"] as? String
            imageString = value["imageString"] as? String
            userID = value["userID"] as? String
            userName = value["userName"] as? String
        }
        
    }
    
    func toContents() -> [String:Any] {
        
        return ["artistName":artistName!,"musicName":musicName!,"previewURL":previewURL!,"imageString":imageString!,"userID":userID!,"userName":userName!]
        
    }
    
    
    
    func save() {
        
        ref.setValue(toContents())
        
    }
    
    
    
}

