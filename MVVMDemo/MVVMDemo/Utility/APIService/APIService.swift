//
//  APIService.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import Foundation



struct ApiName {

    static let articlesList = "mostviewed/all-sections/"

    

}

protocol APIServiceProtocol {

    func getArticlesList(period : String,complete: @escaping ( _ success: Bool, _ articles: MostPopularArticles?, _ error: Error? )->() )
}

class UrlComponents {
    let path: String
    let baseUrlString = "https://api.nytimes.com/svc/mostpopular/v2/"
    let apiKey = APP_DELEGATE.apiKey
    let searchQuery: String?
    
    
    var url: URL {
        var query = [String]()
        if let searchQuery = searchQuery {
            query.append("\(searchQuery)")
        }
        query.append("api-key=\(apiKey)")
        
        guard let composedUrl = URL(string: "?" + query.joined(separator: "&"), relativeTo: NSURL(string: baseUrlString + path + "?") as URL?) else {
            fatalError("Unable to build request url")
        }
        
        return composedUrl
    }
    
    init(path: String, query: String? = nil) {
        self.path = path
        guard var query = query else {
            self.searchQuery = nil
            return
        }
        
        query = query.replacingOccurrences(of: " ", with: "+")
        self.searchQuery = query
    }
}


class APIService: APIServiceProtocol {
   
    
    private let sessionManager: URLSession = {
        let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
        return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
    }()
   
    // Get Articles List
    func getArticlesList(period : String,complete: @escaping (Bool, MostPopularArticles?, Error?) -> ()) {
        
        let urlComponents = UrlComponents(path: ApiName.articlesList + "\(period).json")
        var request = URLRequest(url: urlComponents.url)
        
        request.httpMethod = "get"
        
        
        sessionManager.dataTask(with: request) { (data, response, error) in
            
            //Handle error case
            guard error == nil else {
                complete( false,nil, error )

                return
            }
            let decoder = JSONDecoder()

            
            guard let data = data,
                let responseData = try? decoder.decode(MostPopularArticles.self, from: data) else {
                complete(false, nil, error)
                    return
            }
            
            
            
            if responseData.status! == APIStatus.ok {



                complete( true, responseData, nil )
            }
            else{
                //Manage the else case
                complete( false,nil, error )

                return
            }
          
          
            }.resume()

    }
    
    
    
    
}





