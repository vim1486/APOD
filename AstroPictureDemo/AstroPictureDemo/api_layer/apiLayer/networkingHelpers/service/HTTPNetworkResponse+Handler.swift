//
//  HTTPNetworkResponse.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import Foundation

public struct HTTPNetworkResponse {
    static func handleNetworkResponse(for response: HTTPURLResponse, data: Data?) -> HTTPNetworkError {
        switch response.statusCode {
        case 200...299: return .success
        case 400...500:
            if let responseData = data {
                do {
                    let errorData = try JSONDecoder().decode(GenericErrorData.self, from: responseData)
                    return HTTPNetworkError.badRequest(errorData)
                } catch { 
                    return HTTPNetworkError.badRequest(nil)
                }
            }
            return HTTPNetworkError.badRequest(nil)
        default: return HTTPNetworkError.badRequest(nil)
        }
    }
}
