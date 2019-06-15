//
//  RyanairClient.swift
//  RyanairFlights
//
//  Created by Dario Fanjul on 13/06/2019.
//  Copyright © 2019 Dario Fanjul. All rights reserved.
//

import Foundation

final class RyanairClient {
    
    //MARK: - Private
    private var session: URLSession
    private var configuration: Configuration
    
    //MARK: - Lifecycle
    init(urlSession: URLSession = URLSession.shared, configuration: Configuration = Configuration()) {
        self.session = urlSession
        self.configuration = configuration
    }
    
    //MARK: - Actions
    func request<T: EndPointType>(endpoint: T, completion: @escaping (T.response?, Error?) -> Void) -> URLSessionDataTask? {
        let urlComponents = endpoint.urlComponents
        guard let url = urlComponents.url else {
            completion(nil, NetworkError.invalidURL)
            return nil
        }
        let request = URLRequest(url: url)
        configuration.networkActivity.startedRequest()
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            self?.configuration.networkActivity.stoppedRequest()
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200...300 ~= statusCode else {
                let code = (response as? HTTPURLResponse)?.statusCode
                DispatchQueue.main.async {
                    completion(nil, NetworkError.serverError(code))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, NetworkError.invalidData)
                }
                return
            }
            
            let result = endpoint.processResponse(data: data)
            DispatchQueue.main.async {
                completion(result.0, result.1)
            }
        }
        task.resume()
        
        return task
    }
}

extension RyanairClient {
    
    struct Configuration {
        let networkActivity: NetworkActivityType.Type = NetworkActivity.self
    }
    
}

extension RyanairClient: APIClientType {}
