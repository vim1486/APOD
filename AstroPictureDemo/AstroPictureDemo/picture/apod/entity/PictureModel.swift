//
//  PictureModel.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import Foundation

struct PictureModel: Codable {
    
    internal var copyright:String
    internal var date:String
    internal var explanation:String
    internal var hdurl:String
    internal var media_type:String
    internal var service_version:String
    internal var title:String
    internal var url:String
    internal var thumbnail_url:String
    
    enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdurl
        case media_type
        case service_version
        case title
        case url
        case thumbnail_url
    }
    
    init(from decoder: Decoder) throws {
        
        let _apod = try decoder.container(keyedBy: CodingKeys.self)
        
        copyright = try _apod.decodeIfPresent(String.self, forKey: .copyright) ?? ""
        date = try _apod.decodeIfPresent(String.self, forKey: .date) ?? ""
        explanation = try _apod.decodeIfPresent(String.self, forKey: .explanation) ?? ""
        hdurl = try _apod.decodeIfPresent(String.self, forKey: .hdurl) ?? ""
        media_type = try _apod.decodeIfPresent(String.self, forKey: .media_type) ?? ""
        service_version = try _apod.decodeIfPresent(String.self, forKey: .service_version) ?? ""
        title = try _apod.decodeIfPresent(String.self, forKey: .title) ?? ""
        url = try _apod.decodeIfPresent(String.self, forKey: .url) ?? ""
        thumbnail_url = try _apod.decodeIfPresent(String.self, forKey: .thumbnail_url) ?? ""
    }
}
