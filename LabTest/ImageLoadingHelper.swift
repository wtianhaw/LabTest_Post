//
//  ImageLoadingHelper.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation
import UIKit
import Kingfisher
import CoreMedia

class ImageLoadingHelper {
    static func loadImageWithUrl(urlString : String, imageView: UIImageView, placeHolder: UIImage? = nil, mode: UIView.ContentMode = .scaleAspectFit, corner: Double = 30) {
        if urlString != "" {
            let imageUrl = URL(string: urlString)
            DispatchQueue.main.async {
//                imageView.kf.indicatorType = .activity
//                imageView.kf.setImage(with: imageUrl,placeholder: placeHolder, options: [.transition(.fade(0.2))], progressBlock: nil) { (result, error) in
//                    print(error)
//                }
                let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                             |> RoundCornerImageProcessor(cornerRadius: corner)
                imageView.kf.indicatorType = .activity
                imageView.kf.setImage(
                    with: imageUrl,
//                    placeholder: UIImage(named: "placeholderImage"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
                {
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                        imageView.contentMode = mode
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                        imageView.image = UIImage(named: "icon_error")
                        imageView.contentMode = .scaleAspectFit
                        imageView.tintColor = .red
                    }
                }
            }
        }
    }
    
}
