//
//  WebSocketConnectionStart.swift
//  FinnubSwiftUI
//
//  Created by Angelos Staboulis on 4/5/23.
//

import Foundation
import Starscream


public class WebSocketConnectionStart:NSObject,WebSocketDelegate,ObservableObject{
    var connection:WebSocket!
    var isConnected: Bool = false
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
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
        case .error(_):
            self.isConnected = false
        }
    }
    func socketConnect(){
        let url = URL(string:"wss://ws.finnhub.io?token=ch2pehpr01qs9g9uur50ch2pehpr01qs9g9uur5g")
        var request = URLRequest(url: url!)
        request.timeoutInterval = 5
        connection =  WebSocket(request: request)
        connection.delegate = self
        connection.connect()
    }
    public func socketClose() {
        connection.disconnect()
    }
}

