//
//  SearchViewController.swift
//  MusicListApp00
//
//  Created by Manabu Kuramochi on 2021/05/19.
//

import UIKit
import PKHUD
import Alamofire
import SwiftyJSON
import DTGradientButton
import Firebase
import FirebaseAuth
import ChameleonFramework



class SearchViewController: UIViewController, UITextFieldDelegate {
    
    
    var artistNameArray = [String]()
    var musicNameArray = [String]()
    var previewURLArray = [String]()
    var imageStringArray = [String]()
    var userID = String()
    var userName = String()
    var autoID = String()
    
    
    var userDefaults = UserDefaults.standard
    
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userDefaults.object(forKey: "autoID") != nil {
            
            autoID = userDefaults.object(forKey: "autoID") as! String
            print(autoID)
            
        }else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(identifier: "LoginViewController")
            
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
            
        }
        
        if userDefaults.object(forKey: "userID") != nil && userDefaults.object(forKey: "userName") != nil {
            
            userID = userDefaults.object(forKey: "userID") as! String
            userName = userDefaults.object(forKey: "userName") as! String
        }
        
        searchTextField.delegate = self
        searchTextField.becomeFirstResponder()
        
        
        favButton.setGradientBackgroundColors([UIColor(hex:"E21F70"), UIColor(hex:"FF4D2C")], direction: .toBottom, for: .normal)
        
        listButton.setGradientBackgroundColors([UIColor(hex:"FF8960"), UIColor(hex:"FF62A5")], direction: .toBottom, for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.flatRed()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        searchTextField.resignFirstResponder()
    }
    
    
    
    @IBAction func moveToSelectCardView(_ sender: Any) {
        
        
        
    }
    
    
    func moveToCard() {
        
        performSegue(withIdentifier: "selectVC", sender: nil)
        
    }
    
    
    func startParse(keyword:String) {
        
        HUD.show(.progress)
        
        imageStringArray = [String]()
        previewURLArray = [String]()
        artistNameArray = [String]()
        musicNameArray = [String]()
        
        let urlString = "https://itunes.apple.com/search?term=\(keyword)&country=jp"
        let encodeUrlString:String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AF.request(encodeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            
            print(response)
            
            switch response.result {
            
            
            case .success(_):
                
                let json:JSON = JSON(response.data as Any)
                var resultCount:Int = json["resultCount"].int!
                
                for i in 0 ..< resultCount {
                    
                    var artWorkUrl = json["result"][i]["artworkUrl60"].string
                    let previewUrl = json["result"][i]["previewUrl"].string
                    let artistName = json["result"][i]["artistName"].string
                    let trackCensoredName = json["result"][i]["trackCensoredName"].string
                    
                    if let range = artWorkUrl?.range(of: "60*60bb") {
                        
                        artWorkUrl?.replaceSubrange(range, with: "320*320bb")
                        
                    }
                    
                    
                    self.imageStringArray.append(artWorkUrl!)
                    self.previewURLArray.append(previewUrl!)
                    self.artistNameArray.append(artistName!)
                    self.musicNameArray.append(trackCensoredName!)
                    
                    if self.musicNameArray.count == resultCount {
                        
                        self.moveToCard()
                    }
                }
                
                
            case .failure(let error):
                print(error)
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
