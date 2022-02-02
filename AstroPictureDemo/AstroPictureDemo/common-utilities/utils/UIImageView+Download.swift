//
//  UIImageView+Download.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 01/02/2022.
//

import UIKit

extension UIImageView {
    
    private func downloadImageIfRequired(from url: URL) {
        // Check for cached image.
        if let image = CacheManager.shared.getImage(for: url.absoluteString) {
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
        let shared = CacheManager.shared
        URLSession.shared.downloadTask(with: url) { [weak self, weak shared] responseURL, response, error in
            guard let responseURL = responseURL,
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = try? Data(contentsOf: responseURL), error == nil,
                let responseImage = UIImage(data: data)
                else { return }
            // Cache image
            shared?.set(image: responseImage, for: url.absoluteString as NSString)
            
            DispatchQueue.main.async { [weak self] in
                self?.image = responseImage
                hideProgressIndicator(view: self!)
            }
        }.resume()
    }

    func setImage(from string: String, placeholder: String = kPlaceholderImage) {
        guard let url = URL(string: string) else { return }
        image = UIImage(named: placeholder)
        downloadImageIfRequired(from: url)
    }
}
