//
//  ViewModel.swift
//  FinnubSwiftUI
//
//  Created by Angelos Staboulis on 3/5/23.
//

import Foundation
import Combine
class ViewModel:ObservableObject{
    var symbols:[Symbols]=[]
    var quotes:[PriceTarget]=[]
    var listFinhub:[Finnhub]=[]
    var details:[CompanyDetails]=[]
    private var apishared:APIManager!
    init(){
        apishared = APIManager.shared
    }
    func fetchListPrices() async throws -> [Finnhub]{
        return try await withUnsafeThrowingContinuation{ continuation in
            Task.init{
                symbols = try await apishared.fetchSymbols()
                for symbol in 0..<symbols.count{
                    quotes.append(contentsOf: try await apishared.fetchQuote(symbol: symbols[symbol].symbol))
                    let record = Finnhub(symbol: symbols[symbol].symbol, price: quotes[symbol].price)
                    listFinhub.append(record)
                }
               
                continuation.resume(returning:listFinhub)
            }
        }
                
        
    }
    func fetchCompanyDetails(symbol:String) async throws -> [CompanyDetails]{
        return try await withUnsafeThrowingContinuation{ continuation in
            Task.init{
                details =  try await apishared.fetchCompanyDetails(symbol: symbol)
                continuation.resume(returning:details)
            }
        }
                
        
    }
}
