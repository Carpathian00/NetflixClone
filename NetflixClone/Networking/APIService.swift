//
//  APIService.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 13/04/23.
//

import Foundation

protocol APIServiceProtocol {
    func callApi<T: Codable>(with url: String, model: T.Type, completion: @escaping (Result<T, Error>) -> ())
}

class APIService: APIServiceProtocol {
    
    func callApi<T>(with url: String, model: T.Type, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable, T : Encodable {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let data = data {
                do {
                    let modelData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(modelData))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
