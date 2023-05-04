//
//  DetailsView.swift
//  FinnubSwiftUI
//
//  Created by Angelos Staboulis on 3/5/23.
//

import SwiftUI
struct DetailsView: View {
    @StateObject var viewModelDetails = ViewModel()
    @Binding var recordDetails:Finnhub
    @State var detailsArray:[CompanyDetails]=[]
    @State var details = CompanyDetails()
    @State var imageURL:URL!
    var body: some View {
        VStack{
            HStack{
                Text("Name").foregroundColor(.red)
                Text(details.name ?? "")
            }.frame(width: 390,height:70,alignment: .leading)
            HStack{
                Text("Currency").foregroundColor(.red)
                Text(details.currency ?? "")
            }.frame(width: 390,height:70,alignment: .leading)
            HStack{
                Text("Country").foregroundColor(.red)
                Text(details.country ?? "")
            }.frame(width: 390,height:70,alignment: .leading)
            HStack{
                Text("Phone").foregroundColor(.red)
                Text(details.phone ?? "")
            }.frame(width: 390,height:70,alignment: .leading)
            HStack{
                Text("Exchange").foregroundColor(.red)
                Text(details.exchange ?? "")
            }.frame(width: 390,height:70,alignment: .leading)
        }.navigationBarTitle("Company Details", displayMode: .inline)
        .onAppear{
            Task.init{
                detailsArray.removeAll()
                detailsArray = try await viewModelDetails.fetchCompanyDetails(symbol: recordDetails.symbol)
                details = detailsArray[0]
            }
        }
        VStack{
            HStack{
                Text("MarketCapitalization").foregroundColor(.red)
                Text(details.marketCapitalization ?? "")
            }.frame(width: 390,height:70,alignment: .leading)
            HStack{
                Text("Logo").foregroundColor(.red)
                Text(details.logo ?? "")
               
            }.frame(width: 390,height:70,alignment: .leading)
               
            HStack{
                Text("WebUrl").foregroundColor(.red)
                Text(details.webUrl ?? "")
            }.frame(width: 390,height:70,alignment: .leading)
            HStack{
                Text("Ticket").foregroundColor(.red)
                Text(details.ticket ?? "")
            }.frame(width: 390,height:70,alignment: .leading)
            
        }
     
    }
               
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(recordDetails: .constant(.init()))
    }
}
