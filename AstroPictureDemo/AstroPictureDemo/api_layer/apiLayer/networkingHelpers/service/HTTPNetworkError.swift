//
//  HTTPNetworkError.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import Foundation

public enum HTTPNetworkError: Error {
    case success
    case badRequest(GenericErrorData?)
    case other(String)

    public var errorData: GenericErrorData? {
        switch self {
        case .badRequest(let errorData):
            return errorData
        default:
            return nil
        }
    }

    public var errorMessage: String {
        switch self {
        case .success:
            return "Success"
        case .badRequest(let errorData):
            return errorData?.message ?? "Bad Request received"
        default:
            return "Default error"
        }
    }
}
