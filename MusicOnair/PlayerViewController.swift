//
//  PlayerViewController.swift
//  MusicOnair
//
//  Created by LeeYongJin on 2021/08/10.
//

import UIKit
import AVFoundation
import Foundation

class PlayerViewController: UIViewController {

    @IBOutlet weak var artworkImg: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackArtist: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
