//
//  TrendingCollectionViewCell.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import UIKit
import SDWebImage

class TrendingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var imgHandle: UIImageView!
    @IBOutlet weak var lblHandleTitle: UILabel!
    @IBOutlet weak var lblSubText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    //configure
    func configure(post: Post) {
        lblInformation.text = "Independent Content"
        lblHandleTitle.text = post.handle.rawValue
        lblSubText.text = post.title
        lblTime.text = post.liveAt
        let id = String(post.muxPlaybackID)
        
        guard let url = URL(string: post.profilePic) else {
            return
        }
        
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    self.imgHandle.image = UIImage(data: data)
                }
            }
        }

        self.imgPost.setImageSD(url: "https://image.mux.com/\(id)/thumbnail.png")
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//

}

extension UIImageView {
    func setImageSD(url: String, placeholderImage name:String = "imgProfilePlaceHolder", imageLoadCompletion:((_ image:UIImage?) -> Void)? = nil) {
        guard let urlImage = URL(string: url) else { self.image = UIImage(named: name); return }
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: urlImage) { image, error, type, url in
            if error == nil {
                imageLoadCompletion?(image)
            }else {
                imageLoadCompletion?(nil)
            }
        }
    }
}
