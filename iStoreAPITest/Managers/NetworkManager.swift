//
//  NetworkManager.swift
//  iStoreAPITest
//
//  Created by Eldar on 05.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let hostURL = "https://raw.githubusercontent.com/nassdk/iStoreApi/master/notification.json"
    
    func getNotifications(succes: @escaping ([NotificationModel]) -> Void, onError: @escaping (String) -> Void) {
        AF
            .request(hostURL, method: .get, parameters: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let dictArray = value as? [[String: Any]] {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: dictArray, options: .fragmentsAllowed)
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode([NotificationModel].self, from: data)
                            DispatchQueue.main.async {
                                succes(result)
                            }
                        } catch {
                            DispatchQueue.main.async {
                               onError(error.localizedDescription)
                            }
                        }
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        onError(error.localizedDescription)
                    }
                }
        }
    }
    
}
