//
//  CacheManager.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import UIKit

public class CacheManager {
    public static let shared = CacheManager()
    private let cache: NSCache<NSString, UIImage>
    private let fileManager = FileManager.default
    private lazy var mainDirectoryUrl: URL = {

    let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return documentsUrl
    }()
    
    private init () {
        cache = NSCache()
        cache.countLimit = kMaxCachedImageCount
        cache.totalCostLimit = kMaxCachedImageSize
    }

    public func set(image: UIImage, for url: NSString) {
        cache.setObject(image, forKey: url)
    }

    public func getImage(for url: String) -> UIImage? {
        cache.object(forKey: url as NSString)
    }
    
    public enum Result<T> {
        case success(T)
        case failure
    }

    func getVideoFile(at stringUrl: String, completionHandler: @escaping (Result<(localURL: URL, serverURL: String?)>) -> Void ) {
        let stringUrl = stringUrl.replacingOccurrences(of: "https", with: "http")
        let file = directoryFor(stringUrl: stringUrl)

        //return file path if already exists in cache directory
        guard !fileManager.fileExists(atPath: file.path)  else {
            completionHandler(Result.success((file, stringUrl)))
            return
        }

        DispatchQueue.global(qos: .background).async {
            URLSession.shared.downloadTask(with:  URL(string: stringUrl)!) { file, response, error in
                DispatchQueue.main.async {
                    file != nil ? completionHandler(Result.success((file!, stringUrl))) : completionHandler(Result.failure)
                }
            }.resume()
        }
    }

    private func directoryFor(stringUrl: String) -> URL {
        let fileURL = URL(string: stringUrl)!.lastPathComponent
        let file = self.mainDirectoryUrl.appendingPathComponent(fileURL)
        return file
    }
}
