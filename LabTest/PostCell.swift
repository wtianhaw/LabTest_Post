//
//  PostCell.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblThumbnail: UIImageView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblThumnail2: UIImageView!
    @IBOutlet weak var descriptionStackView: UIStackView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblShareCount: UILabel!
    @IBOutlet weak var lblViewCount: UILabel!
    
    var model: Datum? {
        didSet {
            guard let model = model else { return }
            lblTitle.text = model.name
            ImageLoadingHelper.loadImageWithUrl(urlString: model.icon ?? "", imageView: self.lblThumbnail)
            
            ImageLoadingHelper.loadImageWithUrl(urlString: model.backgroundUrl ?? "", imageView: self.bgImageView, mode: .scaleToFill, corner: 0)
            
            ImageLoadingHelper.loadImageWithUrl(urlString: model.icon ?? "", imageView: self.lblThumnail2)
            lblName.text = model.name
            lblJobTitle.text = model.coName
            lblDate.text = model.timestamp?.msgTimestampToDateTimeString()
            
            lblDescription.text = model.description
            
            lblLikeCount.text = model.likeCount?.description
            lblShareCount.text = model.shareCount?.description
            lblViewCount.text = model.viewCount?.description
            
            descriptionStackView.backgroundColor = Constant.hexStringToUIColor(hex: model.color?.bar?.bottom ?? "FFFFFF")
            topView.backgroundColor = Constant.hexStringToUIColor(hex: model.color?.bar?.top ?? "FFFFFF")
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        self.contentView.backgroundColor = .blue
    }
    
}
