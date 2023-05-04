//
//  WebSocketConnectionStart.swift
//  FinnubSwiftUI
//
//  Created by Angelos Staboulis on 4/5/23.
//

import Foundation
import Starscream


public class WebSocketConnectionStart:NSObject, ObservableObject  {
    var connection:WebSocket!
    var isConnected: Bool = false

    func socketConnect(){
        let url = URL(string:"wss://ws.finnhub.io?token=ch2pehpr01qs9g9uur50ch2pehpr01qs9g9uur5g")
        let request = URLRequest(url: url!)
        connection =  WebSocket(request: request)
        connection.connect()
    }

    public func subscribe(symbol: String) {
        let messageString = "{\"type\":\"subscribe\",\"symbol\":\"\(symbol)\"}"
        connection.write(string: messageString) {
            debugPrint("everyting is ok")
        }
    }

   
    func handleEvent() {
        connection.onEvent = { event in
            switch event {
            case .connected(let headers):
                self.isConnected = true
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                self.isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                self.isConnected = false
            case .error(let error):
                self.isConnected = false
            }
        }
    }
  

    public func socketClose() {
        connection.disconnect()
    }
}

