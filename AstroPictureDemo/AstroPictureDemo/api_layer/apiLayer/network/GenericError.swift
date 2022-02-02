//
//  GenericErrorData.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import Foundation

public struct GenericErrorData: Codable {
    let message: String?
    let status: String?
    let errorCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case status
        case message = "msg"
        case errorCode = "code"
    }
    
    public init(message: String?, status: String?, errorCode: String?) {
        self.message = message
        self.status = status
        self.errorCode = errorCode
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        message = try? container.decode(String.self, forKey: .message)
        errorCode = try? container.decode(String.self, forKey: .errorCode)
        if let value = try? container.decode(Int.self, forKey: .status) {
            status = String(value)
        } else {
            status = try? container.decode(String.self, forKey: .status)
        }
    }
}
