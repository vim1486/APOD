//
//  ApodInteractor.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//


import Foundation

class ApodInteractor: PresenterToInteractorProtocol{
    
    var presenter: InteractorToPresenterProtocol?
    
    func fetchPicture(day: String) {
        
        let networkClient = NetworkClient(baseUrl: kbaseUrl)
        networkClient.getRequest(path: kApiEndpoint,
                                 parameters: [
                                    ApiKeys.thumbs.rawValue: true.description,
                                    ApiKeys.date.rawValue: day,
                                    ApiKeys.api_key.rawValue: kApiKey,], completionHandler: { apod in
                                        DispatchQueue.main.async {
                                            if(apod != nil) {
                                                self.presenter?.onFetchedSuccess(picture: apod!)
                                            }else {
                                                self.presenter?.onFetchFailed()
                                            }
                                        }
                                    })
    }
}
