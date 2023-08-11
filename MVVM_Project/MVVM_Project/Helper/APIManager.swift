//
//  APIManager.swift
//  MVVM_Project
//
//  Created by Mac on 11/08/23.
//

import UIKit

enum DataError: Error{
    case invalidResponse
    case invalidURL
    case invalideData
    case network(Error?)
}
typealias Handler = (Result<[Product], DataError >)-> Void


//singleton design pattern
final class APIManager{
    static let shared = APIManager()
   private init(){}
    
    func fetchProducts(complition: @escaping Handler) {
        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else {
                complition(.failure(.invalideData))
                return
            }
            guard let response = response as? HTTPURLResponse,
            200 ... 299 ~= response.statusCode  else {
                complition(.failure(.invalidResponse))
                return
            }
            do{
                let products = try! JSONDecoder().decode([Product].self, from: data)
                complition(.success(products))
            }catch{
                complition(.failure(.network(error)))
            }
        }.resume()
        
    }
}
/*
class A{
    func configuration(){
        let manager = APIManager()
        manager.temp()
        
        APIManager.shared.temp()
    }
}*/
