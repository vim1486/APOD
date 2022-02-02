//
//  APIClient.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import Foundation

 protocol APIClient {
    var networkClient: NetworkClientType { get }
}
