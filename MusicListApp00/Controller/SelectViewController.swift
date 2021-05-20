//
//  SelectViewController.swift
//  MusicListApp00
//
//  Created by Manabu Kuramochi on 2021/05/20.
//

import UIKit
import VerticalCardSwiper
import SDWebImage
import PKHUD
import Firebase
import ChameleonFramework


class SelectViewController: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
    
    
    
    //receptArray
    var artistNameArray = [String]()
    var musicNameArray = [String]()
    var previewURLArray = [String]()
    var imageStringArray = [String]()
    
    var indexNumber = Int()
    var userID = String()
    var userName = String()
    
    //rightSwipeFavArray
    var likeartistNameArray = [String]()
    var likemusicNameArray = [String]()
    var likepreviewURLArray = [String]()
    var likeimageStringArray = [String]()
    var likeArtistViewUrlArray = [String]()
    
    
    @IBOutlet weak var cardSwiper: VerticalCardSwiper!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        
        
        cardSwiper.reloadData()
        
    }
    
    
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        <#code#>
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        <#code#>
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
