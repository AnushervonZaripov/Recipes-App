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
        case .search(query: let request):
            parameters ["number"] = "10"
            parameters ["query"] = "\(request)"
        case .getTrendingRecipes:
            ""
        case .getRecentRecipes:
            ""
        case .complexSearch(sort: let sort, number: let number, offset: let offset, minLikes: let minLikes):
            ""
        case .search(query: let query):
            ""
        }
        
        return parameters
    }
    
    private func makeTask<T: Codable>(for url: URL, apiKey: String, using session: URLSession = .shared, completion: @escaping(Result<T,NetworkError>)-> Void) {
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        
        session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.invalidURL))
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "No HTTPURLResponse", code: 0, userInfo: nil)
                completion(.failure(.serverError(statusCode: error.code)))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No Data", code: 0, userInfo: nil)
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
