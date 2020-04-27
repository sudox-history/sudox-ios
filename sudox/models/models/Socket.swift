//
//  Socket.swift
//  Sudox-ios
//
//  Created by Никита Казанцев on 07.04.2020.
//  Copyright © 2020 Sudox. All rights reserved.
//
import Foundation
import Starscream

class Network {
    
    static var address = "http://sudox.ru:5000"

    static let shared = Network()
    
    var SecWebSocketAccept = ""
    
    public var websocket: WebSocket?

    public var isConnected = false
    
    
    init() {
        self.websocket?.delegate = self
        connect()
    }
    
    deinit {
        disconnect()
    }
    
    func connect() {
        guard let url = URL(string: Network.address) else {
            print("could not create url from " + Network.address)
            return
        }
        websocket = WebSocket(request: URLRequest(url: URL(string: Network.address)!))
        
        websocket?.connect()
    }
    
    func disconnect() {
        websocket?.disconnect()
    }
    
    func restoreRegSession(_ auth_id: String) -> Bool
    {
        var isRestored = false
        
        print("Sending createSession")
        print("{\"method_name\": \"auth.createSession\",\"data\": {\"auth_id\": " + (auth_id) + "}}")
        
        send("{\"method_name\": \"auth.createSession\",\"data\": {\"auth_id\": " + (auth_id) + "}}")
        
        // если сервер ответил нам на наш id
        websocket?.onEvent = { event in
            switch event {
            // handle events just like above...
            case .text(let string):
                // читаем коды ответа и в случае положительного результата переходим на др экран
                let data: [String: Any]  = string.convertToDictionary()!
                print(data)
                switch (data["result"] as! Int )
                {
                    case 0:
                        print("RESTORED SESSION")
                        isRestored = true
                        
                    default:
                        print("SESSION RESTORATION FAILED")
                        
                        break
                }
                
            case .connected(_):
                break
            case .disconnected(_, _):
                break
            case .binary(_):
                break
            case .pong(_):
                break
            case .ping(_):
                break
            case .error(_):
                break
            case .viablityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                break
            }
        }
        
        return isRestored
    }
    
    
    func send(_ data: Data) {
        websocket?.write(data: data)
    }
    
    func send(_ string: String) {
        websocket?.write(string: string)
    }

    // websocket delegate
    func websocketDidConnect(_ websocket: Starscream.WebSocket) {
        
    }

    func websocketDidDisconnect(_ websocket: Starscream.WebSocket, error: NSError?) {
        
    }

    func websocketDidReceiveData(_ websocket: Starscream.WebSocket, data: Data) {
        
    }

    func websocketDidReceiveMessage(_ socket: WebSocket, text: String) {
        print("websocketDidReceiveMessage")
    }
}

extension Network: WebSocketDelegate{
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print(event)
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocketGLOBAL is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocketGLOBAL is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("ReceivedGLOBAL text: \(string)")
        case .binary(let data):
            print("ReceivedGLOBAL data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viablityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocketGLOBAL encountered an error: \(e.message)")
        } else if let e = error {
            print("websocketGLOBAL encountered an error: \(e.localizedDescription)")
        } else {
            print("websocketGLOBAL encountered an error")
        }
    }
}
