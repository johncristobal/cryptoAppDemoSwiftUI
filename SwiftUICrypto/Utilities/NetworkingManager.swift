//
//  NetworkingManager.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 12/06/26.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
    
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from URL \(url)"
            case .unknown:
                return "[⚠️] Unknown error ocurred"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error>? {
        
        guard let token = Bundle.main.object(forInfoDictionaryKey: "API_TOKEN") as? String else {
            print("No token given")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print(error.localizedDescription)
        case .finished:
            break
        }
    }
}
