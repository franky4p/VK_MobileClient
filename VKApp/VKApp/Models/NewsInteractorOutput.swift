//
//  NewsInteractorOutput.swift
//  VKApp
//
//  Created by Pavel Khlebnikov on 16.08.2021.
//

import Foundation
import Unrealm

protocol NewsInteractorOutputProtocol: AnyObject {
    func handleNewsLoaded(_ news: Results<MyNews>)
}
