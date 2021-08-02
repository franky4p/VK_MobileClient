//
//  Session.swift
//  Task1
//
//  Created by macbook on 15.12.2020.
//

import Foundation
import Unrealm


final class Session {
    var token: String?
    var userId: Int?
    let session =  URLSession(configuration: URLSessionConfiguration.default)
    
    static let shared = Session()
    
    private init() {}
    
    func requestToAPI<T: Decodable>(url: URLRequest, typeReceiver: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = self.session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            do {
//                                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
//                                                       print(json)
                let results = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
        }
        task.resume()
    }
    
    func getDateFromServer<T>(typeDate: T.Type, request: URLRequest) where T:Decodable, T:Realmable {
        Session.shared.requestToAPI(url: request, typeReceiver: Root<T>.self) { results in
            var data: [T] = [T]()
            switch results {
            case .success(let response):
                response.response.items.forEach {
                    data.append($0)
                }
                
                Keeper.saveData(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateFromServer() {
        let opq = OperationQueue()
        let requestFriends = RequestVK.requestListFriens()
        let requestGroup = RequestVK.requestListGroupsUser()
        let requestNews = RequestVK.requestNews()
        
        let opFriend = GetDataOperation(request: requestFriends, typeDate: Friend.self)
        opFriend.completionBlock = {
            Keeper.saveData(opFriend.data)
        }
        let opGroup = GetDataOperation(request: requestGroup, typeDate: MyGroup.self)
        opGroup.completionBlock = {
            Keeper.saveData(opGroup.data)
        }
        let opNews = GetDataOperation(request: requestNews, typeDate: MyNews.self)
        opNews.completionBlock = {
            Keeper.saveData(opNews.data)
        }
        
        opq.addOperation(opFriend)
        opq.addOperation(opGroup)
        opq.addOperation(opNews)
    }
}

final class RequestVK {
    static let scheme: String = "https"
    static let versionVK: String = "5.126"
    static let hostAPI: String = "api.vk.com"
    
    static func requestConnectVK() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7702628"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends, wall"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: versionVK),
            URLQueryItem(name: "state", value: "228")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return request
    }
    
    static func requestListFriens() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = hostAPI
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: versionVK),
            URLQueryItem(name: "fields", value: "nickname, photo_100")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return request
    }
    
    static func requestListGroupsUser() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = hostAPI
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: versionVK),
            URLQueryItem(name: "extended", value: "1")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return request
    }
    
    static func requestFotoUser() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = hostAPI
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: versionVK),
            URLQueryItem(name: "extended", value: "1")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return request
    }
    
    static func requestGroupsSearch(_ q: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = hostAPI
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: versionVK),
            URLQueryItem(name: "q", value: q)
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return request
    }
    
    static func requestNews() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = hostAPI
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: versionVK),
            URLQueryItem(name: "filters", value: "post, photo"),
            URLQueryItem(name: "fields", value: "nickname, photo_100")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return request
    }
}

