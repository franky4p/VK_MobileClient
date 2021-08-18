//
//  NewsInteractor.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 16.08.2021.
//

import Foundation
import Unrealm

class NewsInteractor: NewsInteractorInputProtocol {
    weak var interactorOutput: NewsInteractorOutputProtocol?
    var news: Results<MyNews>?
    var token: NotificationToken?
    
    func loadNews() {
        guard let news = Keeper.loadData(MyNews.self) else {
            return
        }
        
        token = news.observe { [weak self] (changes) in
            switch changes {
            case .error(let error):
                fatalError("\(error)")
            default:
                self?.interactorOutput?.handleNewsLoaded(news)
            }
        }
    }
}
