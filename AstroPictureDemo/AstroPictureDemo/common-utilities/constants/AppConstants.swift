//
//  AppConstants.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import Foundation

let kProgressIndicatorTag:Int = 999

let kMaxCachedImageCount = 1

let kMaxCachedImageSize = 25 * 1024 * 1024

let kbaseUrl:String = "https://api.nasa.gov/"

let kApiEndpoint:String = "planetary/apod"

let kApiKey = "s33WJmOuKbCPHimtxE0wrSysVa0erXJNfyG8f6TS"

let kDateFormat = "YYYY-MM-dd"

let kStoryBoardName = "Main"

let kPictureCellName = "PictureCell"

let kYouTube = "youtube"

let kPlaceholderImage = "imagePlaceholder"

enum ApiKeys: String {
    case date
    case api_key
    case count
    case thumbs
    case startDate = "start_date"
    case endDate = "end_date"
}

enum MediaType: String {
    case video
    case image
}

extension Date {
    
    func toDateString() -> String {

    // Create Date Formatter
    let dateFormatter = DateFormatter()

    // Set Date Format
    dateFormatter.dateFormat = kDateFormat

    // Convert Date to String
    return dateFormatter.string(from: self)
    }
    
    public enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
    }
}
