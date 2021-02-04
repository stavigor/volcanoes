//
//  TableViewCell.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 25.01.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if titleLabel != nil {
            titleLabel.adjustsFontSizeToFitWidth = true
        }
        if cellImage != nil {
//            cellImage.layer.borderWidth = 0.15
//            cellImage.layer.borderColor = UIColor.black.cgColor
//            cellImage.layer.cornerRadius = 10
            cellImage.layer.shadowColor = UIColor.black.cgColor
            cellImage.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            cellImage.layer.shadowOpacity = 0.2
            cellImage.layer.shadowRadius = 3
        }
        if containerView != nil {
//            containerView.layer.cornerRadius = 15
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            containerView.layer.shadowOpacity = 0.2
            containerView.layer.shadowRadius = 3
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImage(_ urlString: String) {
        if let cachedData = CacheManager.getVideoCache(urlString) {
            self.cellImage.image = UIImage(data: cachedData)
            return
        }
        
        let url = URL(string: urlString)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                // Create the image object
                let image = UIImage(data: data!)
                
                //Set the ImageView
                DispatchQueue.main.async {
                    self.cellImage.image = image
                }
                
            }
        }
        task.resume()
    }

}
