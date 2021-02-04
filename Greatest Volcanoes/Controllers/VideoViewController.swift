//
//  VideoViewController.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 27.01.2021.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VideoViewController: UIViewController {
    
    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.load(withVideoId: "LQwZwKS9RPs")
                
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 3
    }

}

