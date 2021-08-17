//
//  NewsModul.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 17.08.2021.
//

import Foundation
import Swinject

class NewsModul {
    let container = Container()
    
    init() {
        setup()
    }
    
    func makeNewsViewController() -> NewsTableViewController {
        return container.resolve(NewsTableViewController.self)!
    }
}

private extension NewsModul {
    typealias PresenterProtocol = NewsViewOutputProtocol & NewsInteractorOutputProtocol
    
    func setup() {
        container.register(NewsInteractorInputProtocol.self) { _ in
            NewsInteractor()
        }.initCompleted { (r, c) in
            let interactor = c as! NewsInteractor
            interactor.interactorOutput = r.resolve(NewsInteractorOutputProtocol.self)
        }
        container.register(PresenterProtocol.self) { _ in
            NewsPresenter()
        }.initCompleted { (r, c) in
            let presenter = c as! NewsPresenter
            presenter.interactorInput = r.resolve(NewsInteractorInputProtocol.self)
            presenter.viewInput = r.resolve(NewsViewInputProtocol.self)
        }
        container.register(NewsInteractorOutputProtocol.self) { r in
            r.resolve(PresenterProtocol.self)!
        }
        container.register(NewsViewOutputProtocol.self) { r in
            r.resolve(PresenterProtocol.self)!
        }
        container.register(NewsViewInputProtocol.self) { r in
            r.resolve(NewsTableViewController.self) ?? NewsTableViewController()
        }
        container.register(NewsTableViewController.self) { r in
            let viewController = NewsTableViewController()
            if let viewOutput = r.resolve(NewsViewOutputProtocol.self) {
                viewController.viewOutput = viewOutput
            }
            return viewController
        }
    }
}
