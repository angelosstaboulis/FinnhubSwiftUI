//
//  APIManager.swift
//  FinnubSwiftUI
//
//  Created by Angelos Staboulis on 3/5/23.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON
class APIManager{
    static let shared = APIManager()
    func fetchSymbols() async throws -> [Symbols]{
        return try await withUnsafeThrowingContinuation { continuation in
            let request = URLRequest(url: URL(string:"https://finnhub.io/api/v1/stock/peers?token=ch2pehpr01qs9g9uur50ch2pehpr01qs9g9uur5g&symbol=DAL")!)
            AF.request(request).responseData { response in
                do{
                    switch response.result {
                    case .success( _):
                                                    var items:[Symbols] = []
                                                    let json = try JSON(data: response.data!)
                                                    for item in 0..<json.count{
                                                        items.append(Symbols(symbol: json[item].stringValue))
                                                    
                                                    }
                                                    continuation.resume(returning: items)
                    case .failure( _):
                                                    debugPrint("something went wrong!!!")
                    }
                }
                catch{
                    debugPrint("something went wrong!!!!!")
                }
            }
        }
    }
    func fetchQuote(symbol:String) async throws -> [PriceTarget]{
        return try await withUnsafeThrowingContinuation { continuation in
            let request = URLRequest(url: URL(string:"https://finnhub.io/api/v1/quote?symbol="+String(symbol)+"&token=ch2pehpr01qs9g9uur50ch2pehpr01qs9g9uur5g")!)
            AF.request(request).responseData { response in
                do{
                    switch response.result {
                    case .success( _):
                                                    var items:[PriceTarget] = []
                                                    let json = try JSON(data: response.data!)
                                                    items.append(PriceTarget(price: String(format:"%.2f",json["c"].doubleValue)))
                                                    continuation.resume(returning: items)
                    case .failure( _):
                                                    debugPrint("something went wrong!!!")
                    }
                }
                catch{
                    debugPrint("something went wrong!!!!!")
                }
            }
        }
    }
}
