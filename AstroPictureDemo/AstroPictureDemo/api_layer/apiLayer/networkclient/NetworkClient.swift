//
//  NetworkClientType.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import Foundation

protocol NetworkClientType {
    func getRequest(path: String, parameters: [String: String], completionHandler: @escaping (PictureModel?)->Void)
}

public class NetworkClient: NSObject, NetworkClientType {
    
    var task: URLSessionTask?
    let baseUrl: String
    var headers: [String: String] = [:]
    var session: URLSession?
    
    func getRequest(path: String, parameters: [String : String], completionHandler: @escaping (PictureModel?) -> Void) {
        sendRequest(request: buildRequest(path: path, urlParameters: parameters)) { (apod) in
            DispatchQueue.main.async {
                completionHandler(apod);
            }
        }
    }
    
    func sendRequest(request: URLRequest, completionHandler: @escaping (PictureModel?)->Void) {
        if session == nil {
            session = URLSession.shared
        }
    
        task = session!.dataTask(with: request, completionHandler: { data, response, error in

            if error != nil {
                if let genericError = error as NSError?,
                   genericError.code == NSURLErrorNotConnectedToInternet,
                   genericError.domain == NSURLErrorDomain {
                    return
                }
                return
            }

            if let response = response as? HTTPURLResponse {
                let result = HTTPNetworkResponse.handleNetworkResponse(for: response, data: data)
                switch result {
                case .success:
                        guard let data = data else{
                            return
                        }
                        
                        do{
                            let type = PictureModel.self
                            let decoder = JSONDecoder()
                            let apod = try decoder.decode(type, from: data)
                            completionHandler(apod);
                        }catch _ {
                            completionHandler(nil);
                        }
                    
                default:
                    completionHandler(nil);
                }
            }
        })
        self.task?.resume()
    }

    private func buildRequest(
        path: String,
        httpMethod: HTTPMethod = .get,
        urlParameters: [String: String] = [:],
        body: Encodable? = nil
    ) -> URLRequest {

        let url = URL(string: self.baseUrl)!.appendingPathComponent(path)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if !urlParameters.isEmpty {
            urlComponents?.queryItems = urlParameters.map {key, value in
                URLQueryItem(name: key,
                             value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            }
        }
        var request = URLRequest(url: (urlComponents?.url!)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        request.httpMethod = httpMethod.rawValue
        if !headers.isEmpty {
            request.allHTTPHeaderFields = headers
        }
        request.httpBody = body?.toData()

        return request
    }

    public func cancel() {
        self.task?.cancel()
    }

    public init(baseUrl: String, headers: [String: String] = [:]) {
        self.baseUrl = baseUrl
        self.headers = headers
    }
}
