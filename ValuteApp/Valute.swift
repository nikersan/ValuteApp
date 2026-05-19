//
//  Valute.swift
//  ValuteApp
//
//  Created by Nikita Chuklov on 16.05.2026.
//

import Foundation
import SwiftData

// MARK: - Rate

//@Model
class Rate: Decodable {
    enum CodingKeys: CodingKey {
            case current, previous
    }
    
    let current: Double
    let previous: Double
    var history: [Double] = []
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        current = try container.decode(Double.self, forKey: .current)
        previous = try container.decode(Double.self, forKey: .previous)
    }
    init(current: Double,
         previous: Double) {
        self.current = current
        self.previous = previous
    }
    
    func decode(from decoder: Decoder) throws {
        
    }
    
    func updateHistory(with rate: Double) {
        history.append(rate)
    }
}

// MARK: - Valute

//@Model
class Valute: Decodable {
    enum CodingKeys: CodingKey {
        case name, numCode, code, rate
    }
    let name: String
    let numCode: String
    let code: String
    let rate: Rate
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        numCode = try container.decode(String.self, forKey: .numCode)
        code = try container.decode(String.self, forKey: .code)
        rate = try container.decode(Rate.self, forKey: .rate)
    }
    init(name: String,
         numCode: String,
         code: String,
         rate: Rate) {
        self.name = name
        self.numCode = numCode
        self.code = code
        self.rate = rate
    }
}


// MARK: - ValuteDescription

struct ValuteDescription: Decodable {
    enum CodingKeys: String, CodingKey {
        case numCode = "Cur_Code"
        case code = "Cur_Abbreviation"
        case name = "Cur_Name"
    }
    
    let numCode: String
    let code: String
    let name: String
}

// MARK: - Response

struct Response: Decodable {
    enum ResponseKeys: String, CodingKey {
        case valute = "Valute"
    }
    
    let valutes: [ValuteDetail]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseKeys.self)
        let values: [String: ValuteDetail] = try container.decode([String:ValuteDetail].self, forKey: .valute)
        self.valutes = values.map { $0.value }
    }
}

// MARK: - ValuteDetail

struct ValuteDetail: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case numCode = "NumCode"
        case code = "CharCode"
        case nominal = "Nominal"
        case value = "Value"
        case previous = "Previous"
    }
    
    let id: String
    let numCode: String
    let code: String
    let nominal: Int
    let value: Double
    let previous: Double
}
