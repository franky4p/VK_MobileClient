//
//  NewsViewOutput.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 16.08.2021.
//

import Foundation
import Unrealm

protocol NewsViewOutputProtocol {
    var news: Results<MyNews>? { get }
    
    func getNews()
}
