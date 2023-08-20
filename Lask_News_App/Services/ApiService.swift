//
//  NetworkManager.swift
//  Lask_News_App
//
//  Created by MacBook Pro on 15/08/23.
//

import UIKit
import CoreData

enum Category: String {
    
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    
}

//

class ApiService {
    private let apiKey = "bf8cddfa13464e21937c9a90b02725ec"
    
    init() {
        
    }
    
    // malumot ob kelish - Api Get Data
    func getTopHeadlineNews(withCategory category: Category? = nil, withQuery searchText: String? = nil, completionHandler: @escaping (Result<[Article], ApiError>) -> ())  {
        // api Url
        let baseUrl = "https://newsapi.org/v2/top-headlines?"
        
        // finish url
        var urlString = baseUrl + "language=en" + "&apiKey=" + apiKey
        
        // required Parameter: language*, q, country, category and source
        if let category {
            urlString += "&category=" + category.rawValue
        }
        
        if let searchText {
            urlString += "&q=" + searchText
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(ApiError.invalidUrl))
            return
        }
        
//        let request = URLRequest(url: url)
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: request) { data, response, error in
//        }
        
        // URL Session - Get data
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
//            // handling repsonse
//            guard let response = response as? HTTPURLResponse else {
//                return
//            }
            
            // handling error
            // handling data
            guard let data = data, error == nil else {
                completionHandler(.failure(ApiError.networkError))
                return
            }
            // decode
            let decoder = JSONDecoder()
            do {
                let responseData = try decoder.decode(ApiResponse.self, from: data)
                if let articles = responseData.articles {
                    completionHandler(.success(articles))
                } else {
                    completionHandler(.success([]))
                }
            } catch {
                completionHandler(.failure(ApiError.failWhileDecoding))
                print(error)
            }
        }
        task.resume()
    }
    
    
    func getNews(page: Int, pageSize: Int = 20, completion: @escaping (Result<[Article], Error>) -> ()) {
        // URL
        let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=bf8cddfa13464e21937c9a90b02725ec&pageSize=10&page=3"
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }
        // Task
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            // optional checking
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }
            // decode
            do {
                let responsData = try JSONDecoder().decode(ApiResponse.self, from: data)
                if let articles = responsData.articles {
                    completion(.success(articles))
                } else {
                    completion(.success([]))
                }
            } catch {
                completion(.failure(error))
            }
        }
        // Task.resume()
        task.resume()
    }
    func getNews(searchText: String, completion: @escaping (Result<[Article], Error>) -> ()) {
        // URL
        let urlString = "https://newsapi.org/v2/everything?q=\(searchText)&apiKey=bf8cddfa13464e21937c9a90b02725ec&pageSize=10&page=2"
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }
        // Task
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            // optional checking
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }
            // decode
            do {
                let responsData = try JSONDecoder().decode(ApiResponse.self, from: data)
                if let articles = responsData.articles {
                    completion(.success(articles))
                } else {
                    completion(.success([]))
                }
            } catch {
                completion(.failure(error))
            }
        }
        // Task.resume()
        task.resume()
    }
    
    func getNews(withTitle title: String, completion: @escaping (Result<[Article], Error>) -> ()) {
        
        let baseUrl = "https://newsapi.org/v2/everything?"
        
        // finish url
        var urlString = baseUrl + "searchIn=title" + "&apiKey=" + apiKey + "&q=" + title
        
        // required Parameter: language*, q, country, category and source
        
        
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
//            // handling repsonse
//            guard let response = response as? HTTPURLResponse else {
//                return
//            }
            
            // handling error
            // handling data
            guard let data = data, error == nil else {
                completion(.failure(ApiError.networkError))
                return
            }
            // decode
            let decoder = JSONDecoder()
            do {
                let responseData = try decoder.decode(ApiResponse.self, from: data)
                if let articles = responseData.articles {
                    completion(.success(articles))
                } else {
                    completion(.success([]))
                }
            } catch {
                completion(.failure(ApiError.failWhileDecoding))
                print(error)
            }
        }
        task.resume()
    }
}
struct ApiResponse: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
struct Article: Decodable {
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    
    init(articleDB: ArticleDB) {
        
        self.title = articleDB.title
        self.author = articleDB.author
        self.description = articleDB.desc
        self.url = articleDB.url
        self.urlToImage = articleDB.img
        self.publishedAt = articleDB.publishedAt
        
    }
    
    func toCoreDataModel() -> ArticleDB {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let articleDB = ArticleDB(context: context)
        articleDB.title = self.title
        articleDB.desc = self.description
        articleDB.author = self.author
        articleDB.url = self.url
        articleDB.img = self.urlToImage
        articleDB.publishedAt = self.publishedAt
//        articleDB.readAt = Date()
        return articleDB
    }
    
}

enum ApiError: Error {
    case networkError
    case invalidUrl
    case failWhileDecoding
}

