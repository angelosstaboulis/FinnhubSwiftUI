//
//  ContentView.swift
//  FinnubSwiftUI
//
//  Created by Angelos Staboulis on 3/5/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON
struct ContentView: View {
    @State var viewModel = ViewModel()
    @State var listPrices:[Finnhub]=[]
    var body: some View {
        VStack{
            Text("FinnHub")
        }
        List(listPrices,id:\.id){ record in
            HStack{
                Text(record.symbol).padding(20.0)
                Text(record.price).foregroundColor(.green)

            }.frame(width:600,height:50)
           
        }
        .onAppear {
            Task.init{
                listPrices = try await viewModel.fetchListPrices()
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
