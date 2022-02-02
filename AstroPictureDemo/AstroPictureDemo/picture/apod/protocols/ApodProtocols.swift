//
//  ApodProtocols.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 30/01/2022.
//


import Foundation
import UIKit

protocol ViewToPresenterProtocol: AnyObject{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetching(day:String)
}

protocol PresenterToViewProtocol: AnyObject{
    func showPicture(picture:PictureModel)
    func showError()
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule()-> ApodViewController
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchPicture(day:String)
}

protocol InteractorToPresenterProtocol: AnyObject {
    func onFetchedSuccess(picture:PictureModel)
    func onFetchFailed()
}
