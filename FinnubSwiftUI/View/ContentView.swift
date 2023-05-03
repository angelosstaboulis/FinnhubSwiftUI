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
    @StateObject var viewModel = ViewModel()
    @State var listPrices:[Finnhub]=[]
    @State var details = Finnhub()
    var body: some View {
        NavigationView{
            List(listPrices,id:\.id){ record in
                NavigationLink {
                    DetailsView(recordDetails: $details).onAppear{
                        details = record
                    }
                } label: {
                    HStack{
                         Text(record.symbol)
                         Text(record.price).foregroundColor(.green)
                    }
                }
            }.navigationBarTitle("Finnhub", displayMode: .inline)
        }
        .onAppear{
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
