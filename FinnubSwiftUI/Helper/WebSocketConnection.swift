import Foundation
import FinnhubSwift
class WebSocketConnection:NSObject, ObservableObject {
    func connect() {
        FinnhubLiveClient.shared.subscribe(symbols: ["AAPL", "AMZN", "BINANCE:BTCUSDT", "IC MARKETS:1"])
        FinnhubLiveClient.shared.receiveMessage { result in
            switch result {
            case let .success(success):
            switch success {
              case let .trades(trades):
                  print(trades) // Prints a LiveTrades object
              case let .news(news):
                  print(news) // Prints a LiveNews object
              case let .ping(ping):
                  print(ping) // Prints a Ping object
              case .empty:
                  print("Empty data")
              }
            case let .failure(failure):
                switch failure {
                case .networkFailure:
                    print(failure)
                case .invalidData:
                    print("Invalid data")
                case .unknownFailure:
                    print("Unknown failure")
                }
            }
        }
    }
    func closeConnection(){
        FinnhubLiveClient.shared.closeConnection()
    }
}
