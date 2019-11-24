//
//  ImageAPI.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 21/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Alamofire
import AlamofireImage

final class ImageWorker {
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func downloadImage(url: String, completion: @escaping (UIImage?, String) -> Void) {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage, url)
        } else {
            Alamofire.request(url).responseImage { response in
                if let image = response.result.value {
                    imageCache.setObject(image, forKey: url as NSString)
                    completion(image, url)
                }
            }
        }
        
    }
}
