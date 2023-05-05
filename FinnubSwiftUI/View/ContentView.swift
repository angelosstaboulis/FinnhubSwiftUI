//
//  ContentView.swift
//  FinnubSwiftUI
//
//  Created by Angelos Staboulis on 3/5/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import FinnhubSwift
import Starscream
struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var listPrices:[Finnhub]=[]
    @State var listPricesSorted:[Finnhub]=[]
    @StateObject var socket = WebSocketConnection()
    @StateObject var connection = WebSocketConnectionStart()
    @State var details = Finnhub()
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Button {
                        listPrices = listPrices.sorted { Double($0.price)! < Double($1.price)! }
                    } label: {
                        Text("Price")
                    }.frame(width:100,height:40,alignment: .center).background(Color.green).cornerRadius(15.0)
                    
                }.frame(width:300,height:50,alignment: .trailing)
                List(listPrices,id:\.id){ record in
                    
                    NavigationLink {
                        DetailsView(recordDetails: $details).onAppear{
                            details = record
                        }
                    } label: {
                        HStack{
                            Text(record.symbol).padding(5)
                        }.frame(width:200,height:50)
                        HStack{
                            Text(record.price).foregroundColor(.green).padding(25.0)
                        }.frame(width:110,height:50)
                        
                    }
                }.navigationBarTitle("Finnhub", displayMode: .inline)
            }
        }.onAppear{
            Task.init{
                listPrices = try await viewModel.fetchListPrices()
            }
            connection.socketConnect()
            
        }
    }
 }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
