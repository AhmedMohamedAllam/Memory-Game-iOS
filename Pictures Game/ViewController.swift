//
//  ViewController.swift
//  Pictures Game
//
//  Created by LinuxPlus on 4/14/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet weak var imageView10: UIImageView!
    @IBOutlet weak var imageView11: UIImageView!
    @IBOutlet weak var imageView12: UIImageView!
    @IBOutlet weak var imageView13: UIImageView!
    @IBOutlet weak var imageView14: UIImageView!
    @IBOutlet weak var imageView15: UIImageView!
    @IBOutlet weak var imageView16: UIImageView!
    
    var images: [UIImage] = [#imageLiteral(resourceName: "img1"), #imageLiteral(resourceName: "img2"), #imageLiteral(resourceName: "img3"), #imageLiteral(resourceName: "img4"), #imageLiteral(resourceName: "img5"), #imageLiteral(resourceName: "img6"), #imageLiteral(resourceName: "img7"), #imageLiteral(resourceName: "img8")]
    var numberOfClicks:Int = 0
    var sum:Int = 0
    var clickedImageViews:[UIImageView] = []
    var imageViews: [UIImageView] = []
    var round:Int = 1
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        imageViews = [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, imageView7, imageView8, imageView9, imageView10, imageView11, imageView12, imageView13, imageView14, imageView15, imageView16]
        
        generateRandomImages(&imageViews)
        turnImageViewGestueresOn(imageViews)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let imageViewTapped = tapGestureRecognizer.view as? UIImageView {
            numberOfClicks += 1
            clickedImageViews.insert(imageViewTapped, at: (numberOfClicks - 1) % 2)
            let index: Int = imageViewTapped.tag
            imageViewTapped.isUserInteractionEnabled = false
            imageViewTapped.image = images[index % 8]
            
            //wait 2 seconds in the second click
            if numberOfClicks % 2 == 0{
                setImageViewEnabled(false)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {self.flipImages()})
            }
        }
    }
    
    func turnImageViewGestueresOn(_ imageViewsList: [UIImageView]) {
        let length = imageViewsList.count
         for i in 0..<length{
            let TapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(tapGestureRecognizer:)))
            imageViewsList[i].isUserInteractionEnabled = true
            imageViewsList[i].tag = i
            imageViewsList[i].image = #imageLiteral(resourceName: "qm")
            imageViewsList[i].addGestureRecognizer(TapGesture)
        }
        
    }
    func generateRandomImages(_ imageViews:inout [UIImageView]){
        let IVLength: Int = imageViews.count
        for i in 0..<IVLength{
            let j = Int(arc4random_uniform(UInt32(IVLength - 1)))
            if i != j {
                swap(&imageViews[i], &imageViews[j])
            }
        }
        
        for i in 0..<IVLength{
            imageViews[i].image = images[i % 8]
        }
    }
    
    func flipImages(){
            if abs(clickedImageViews[0].tag - clickedImageViews[1].tag) == 8{
                clickedImageViews[0].isHidden = true
                clickedImageViews[1].isHidden = true
                score += 10
                scoreLabel.text = String(score)
                if score % 80 == 0{
                    startNewRound()
                }
            }else{
                clickedImageViews[0].image = #imageLiteral(resourceName: "qm")
                clickedImageViews[1].image = #imageLiteral(resourceName: "qm")
            }
            setImageViewEnabled(true)
    }
    
    
    func setImageViewEnabled(_ isEnabled: Bool){
        for IV in imageViews{
            IV.isUserInteractionEnabled = isEnabled
        }
    }
    
    func startNewRound() {
        round = round + 1
        roundLabel.text = String(round)
        for IV in imageViews{
            IV.isHidden = false
            generateRandomImages(&imageViews)
            turnImageViewGestueresOn(imageViews)
        }
    }
    
    


}

