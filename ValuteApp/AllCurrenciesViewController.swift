//
//  AllCurrenciesViewController.swift
//  ValuteApp
//
//  Created by Nikita Chuklov on 16.05.2026.
//

import UIKit

class AllCurrenciesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkManager()
        Task {
            do {
                let descriptions: [ValuteDescription] = try await networkManager.fetch(from: "https://api.nbrb.by/exrates/currencies")
                let detailResponse: Response = try await networkManager.fetch(from: "https://www.cbr-xml-daily.ru/daily_json.js")
                let valutesDetails = detailResponse.valutes
                
                
                var valutes: [Valute] = []
                
                for detail in valutesDetails {
                    guard let description = descriptions.first(where: { $0.code == detail.code }) else { continue }
                    let rate = Rate(current: detail.value, previous: detail.previous)
                    let valute = Valute(name: description.name,
                                        numCode: detail.numCode,
                                        code: detail.code,
                                        rate: rate)
                    valutes.append(valute)
                
//              var valutes: [Valute] = []
                    
//                try valutesDetails.forEach { detail in
//                    guard let description = descriptions.first(where: { $0.code == detail.code }) else { return }
//                    var valuteJSON: [String: Any] = [:]
//                    // name, numCode, code, rate
//                    valuteJSON["name"] = description.name
//                    valuteJSON["numCode"] = detail.numCode
//                    valuteJSON["code"] = detail.code
//                    var rateJSON: [String: Any] = [:]
//                    rateJSON["current"] = detail.value
//                    rateJSON["previous"] = detail.previous
////                    if let rateData = try? JSONSerialization.data(withJSONObject: rateJSON),
////                       let rate = try? JSONDecoder().decode(Rate.self, from: rateData) {
//                        valuteJSON["rate"] = rateJSON
//                  //  }
//                    
//                    let valuteData = try JSONSerialization.data(withJSONObject: valuteJSON)
//                    let valute = try JSONDecoder().decode(Valute.self, from: valuteData)
//                    valutes.append(valute)
                    
                }
                print(valutes)
                valutes.sort(by: {$0.name < $1.name})
                print("success")
            } catch {
                print(error)
            }
        }
    }


}

