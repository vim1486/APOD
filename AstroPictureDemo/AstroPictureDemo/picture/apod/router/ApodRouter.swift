//
//  AppConstants.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//


import Foundation
import UIKit

class ApodRouter:PresenterToRouterProtocol{
    
    static func createModule() -> ApodViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ApodViewController") as! ApodViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = ApodPresenter()
        let interactor: PresenterToInteractorProtocol = ApodInteractor()
        let router:PresenterToRouterProtocol = ApodRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:kStoryBoardName,bundle: Bundle.main)
    }
}
