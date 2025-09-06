//
//  NetworkManager.swift
//  Recipes App
//
//  Created by Zaripov Anushervon  on 03/09/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case noData
    case serverError(statusCode: Int)
}

struct NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    private func createURL(for endpoint: Endpoint, with query: String? = nil) -> URL?{
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endpoint.path
        
        components.queryItems = makeParameters(for: endpoint, with: query).map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return components.url
    }
    
    private func makeParameters(for endpoint: Endpoint, with query: String? = nil) -> [String: String] {
        var parameters = [String: String]()
        parameters["apiKey"] = API.apiKey
        
        switch endpoint {
        case .search(let query, let number, let offset):
            parameters["query"] = query
            parameters["number"] = "\(number)"
            parameters["offset"] = "\(offset)"
            parameters["addRecipeInformation"] = "true"
            
        case .trendingRecipes(let number, let offset):
            parameters["sort"] = "popularity"
            parameters["number"] = "\(number)"
            parameters["offset"] = "\(offset)"
            parameters["addRecipeInformation"] = "true"
            
        case .recentRecipes(let number, let offset):
            parameters["sort"] = "random"
            parameters["number"] = "\(number)"
            parameters["offset"] = "\(offset)"
            parameters["addRecipeInformation"] = "true"
            
        case .popularRecipes(let number, let offset, let cuisine):
            parameters["sort"] = "popularity"
            parameters["number"] = "\(number)"
            parameters["offset"] = "\(offset)"
            parameters["minLikes"] = "10"
            if let cuisine = cuisine {
                parameters["cuisine"] = cuisine
            }
            parameters["addRecipeInformation"] = "true"
            
        case .recipeInformation(_, let includeNutrition):
            parameters["includeNutrition"] = includeNutrition ? "true" : "false"
        }
        
        return parameters
    }

    private func makeTask<T: Codable>(for url: URL, apiKey: String, using session: URLSession = .shared, completion: @escaping(Result<T,NetworkError>)-> Void) {
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        
        session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(.invalidURL))
            }
            
            guard response is HTTPURLResponse else {
                let error = NSError(domain: "No HTTPURLResponse", code: 0, userInfo: nil)
                completion(.failure(.serverError(statusCode: error.code)))
                return
            }
            
            guard let data = data else {
                _ = NSError(domain: "No Data", code: 0, userInfo: nil)
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
