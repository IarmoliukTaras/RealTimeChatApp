//
//  Extensions.swift
//  RealTimeChatApp
//
//  Created by 123 on 14.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadUsingCacheWith(url: String) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            self.image = cachedImage
            return
        }
        
        if let aUrl = URL(string: url) {
            URLSession.shared.dataTask(with: aUrl, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    guard let downloadedImage = UIImage(data: data) else { return }
                    imageCache.setObject(downloadedImage, forKey: url as NSString)
                    self.image = downloadedImage
                }
                
            }).resume()
        }
    }
}
