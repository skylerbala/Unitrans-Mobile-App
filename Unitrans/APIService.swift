//
//  APIService.swift
//  Unitrans
//
//  Created by Skyler Bala on 8/21/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

//import Foundation
//import SwiftyJSON
//
//class APIService: NSObject {
//    lazy var endPoint: String = {
//        return "https://webservices.nextbus.com/service/publicJSONFeed?command=routeConfig&a=unitrans"
//    }()
//    
//    enum Result<T> {
//        case Success(T)
//        case Error(String)
//    }
//    
//    func getDataWith(completion: @escaping (Result<[String: AnyObject]>) -> Void) {
//        guard let url = URL(string: endPoint) else { return }
//        
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard error == nil else { return }
//            guard let data = data else { return }
//    
//            let json = JSON(data: data)
//            completion(json)
//        }.resume()
//    }
//
//}
//
//
