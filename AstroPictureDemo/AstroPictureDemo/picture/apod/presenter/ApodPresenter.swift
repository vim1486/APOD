//
//  ApodPresenter.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//

import Foundation
import UIKit

class ApodPresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetching(day: String) {
        interactor?.fetchPicture(day: day)
    }
}

extension ApodPresenter: InteractorToPresenterProtocol {
    func onFetchedSuccess(picture: PictureModel) {
        view?.showPicture(picture: picture)
    }
    
    func onFetchFailed() {
        view?.showError()
    }
}
