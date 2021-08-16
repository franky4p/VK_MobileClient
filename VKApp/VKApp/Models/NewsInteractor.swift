//
//  NewsInteractor.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 16.08.2021.
//

import Foundation

class NewsInteractor: NewsInteractorInputProtocol {
    weak var interactorOutput: NewsInteractorOutputProtocol?
    
    func loadNews() {
        if let result = Keeper.loadData(MyNews.self) {
            interactorOutput?.handleNewsLoaded(result)
        }
    }
}
