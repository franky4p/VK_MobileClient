//
//  NewsPresenter.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 16.08.2021.
//

import Foundation
import Unrealm

class NewsPresenter: NewsViewOutputProtocol, NewsInteractorOutputProtocol {
    var interactorInput: NewsInteractorInputProtocol = NewsInteractor()
    
    var news: Results<MyNews>?
    var token: NotificationToken?
    weak var viewInput: NewsViewInputProtocol?
    
    func getNews() {
        interactorInput.loadNews()
    }
    
    func handleNewsLoaded(_ news: Results<MyNews>) {
        self.news = news
        viewInput?.handleNewsChange()
    }
}
