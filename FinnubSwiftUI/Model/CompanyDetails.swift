//
//  CompanyDetails.swift
//  FinnubSwiftUI
//
//  Created by Angelos Staboulis on 3/5/23.
//

import Foundation
struct CompanyDetails:Identifiable{
    var id = UUID()
    var country:String!
    var currency:String!
    var exchange:String!
    var ipo:String!
    var marketCapitalization : String!
    var name:String!
    var phone:String!
    var shareOutstanding:String!
    var ticket:String!
    var webUrl:String!
    var logo:String!
    var finnhubIndustry:String!
}
