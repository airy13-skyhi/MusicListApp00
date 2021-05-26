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
        cardSwiper.register(nib: UINib(nibName: "CardViewCell", bundle: nil), forCellWithReuseIdentifier: "CardViewCell")
        
        cardSwiper.reloadData()
        
    }
    
    
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return artistNameArray.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: index) as? CardViewCell {
            
            verticalCardSwiperView.backgroundColor = UIColor.randomFlat()
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            
            
            let artistName = artistNameArray[index]
            let musicName = musicNameArray[index]
            cardCell.setRandomBackgroundColor()
            cardCell.artistNameLabel.text = artistName
            cardCell.artistNameLabel.textColor = UIColor.white
            cardCell.musicNameLabel.text = musicName
            cardCell.musicNameLabel.textColor = UIColor.white
            
            cardCell.artWorkImageView.sd_setImage(with: URL(string: imageStringArray[index]), completed: nil)
            
            return cardCell
        }
        
        return CardCell()
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
        
        indexNumber = index
        
        if swipeDirection == .Right {
            
            likeartistNameArray.append(artistNameArray[indexNumber])
            likemusicNameArray.append(musicNameArray[indexNumber])
            likepreviewURLArray.append(previewURLArray[indexNumber])
            likeimageStringArray.append(imageStringArray[indexNumber])
            
            if likeartistNameArray.count != 0 && likemusicNameArray.count != 0 && likepreviewURLArray.count != 0 && likeimageStringArray.count != 0 {
                
                let musicDataModel = MusicDataModel(artistName: artistNameArray[indexNumber], musicName: musicNameArray[indexNumber], previewURL: previewURLArray[indexNumber], imageString: imageStringArray[indexNumber], userID: userID, userName: userName)
                
                musicDataModel.save()
            }
            
        }
        
        
        artistNameArray.remove(at: index)
        musicNameArray.remove(at: index)
        previewURLArray.remove(at: index)
        imageStringArray.remove(at: index)
        
    }
    
    
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        
        indexNumber = index
        
        if swipeDirection == .Right {
            
            likeartistNameArray.append(artistNameArray[indexNumber])
            likemusicNameArray.append(musicNameArray[indexNumber])
            likepreviewURLArray.append(previewURLArray[indexNumber])
            likeimageStringArray.append(imageStringArray[indexNumber])
            
            if likeartistNameArray.count != 0 && likemusicNameArray.count != 0 && likepreviewURLArray.count != 0 && likeimageStringArray.count != 0 {
                
                let musicDataModel = MusicDataModel(artistName: artistNameArray[indexNumber], musicName: musicNameArray[indexNumber], previewURL: previewURLArray[indexNumber], imageString: imageStringArray[indexNumber], userID: userID, userName: userName)
                
                musicDataModel.save()
            }
            
        }
        
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
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
