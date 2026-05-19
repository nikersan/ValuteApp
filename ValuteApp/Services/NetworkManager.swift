//
//  NetworkManager.swift
//  ValuteApp
//
//  Created by Nikita Chuklov on 16.05.2026.
//

import Foundation

final class NetworkManager {
    private let decoder = JSONDecoder()
    
    func fetch() async throws -> [Valute] {
        guard let url = URL(string: "") else { throw NSError() }
        
        var request = URLRequest(url: url, timeoutInterval: 15.0)
        request.httpMethod = ""
        let (data, response) = try await URLSession.shared.data(for: request)
        let currencies = try decoder.decode([Valute].self, from: data)
        return currencies
    }
    
    func fetch<Model>(from urlString: String) async throws -> Model where Model: Decodable {
        guard let url = URL(string: urlString) else { throw NSError() }
        
        var request = URLRequest(url: url, timeoutInterval: 15.0)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let model = try decoder.decode(Model.self, from: data)
        return model
    }
}
