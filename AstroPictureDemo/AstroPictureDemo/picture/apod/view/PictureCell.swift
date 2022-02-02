//
//  PictureCell.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 01/02/2022.
//

import Foundation
import UIKit

class PictureCell:UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var brief: UITextView!
    @IBOutlet weak var apodImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    var onPlayClick : ((_ sender: UIButton) -> Void)?
    
    func configure(picture:PictureModel){
        showProgressIndicator(view: apodImage)
        title.text = picture.title
        brief.text = picture.explanation
        playButton.isHidden = picture.media_type != MediaType.video.rawValue
        apodImage.setImage(from: picture.media_type != MediaType.video.rawValue ? picture.hdurl : picture.thumbnail_url)
    }
    
    @IBAction func sel_btnPlay(sender : UIButton)  {
        onPlayClick?(sender)
    }
}

