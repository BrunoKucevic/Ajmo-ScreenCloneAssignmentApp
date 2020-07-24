//
//  JSONParser.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 23/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation


struct JSONParser{

    static let shared = JSONParser()
    func fetch<T: Codable>(urlString: String, completionHandler: @escaping (Result<T, RequestError>) -> ()){

        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            guard error == nil else {
                completionHandler(.failure(.clienError))
                return
            }

            guard let response = urlResponse as? HTTPURLResponse, 200...299 ~= response.statusCode else{
                completionHandler(.failure(.serverError))
                return
            }

            guard let jsonData = data else {return}

            do{
                let parsedData = try JSONDecoder().decode(T.self, from: jsonData)
                completionHandler(.success(parsedData))
            }catch{
                completionHandler(.failure(.serverError))
            }

        }.resume()

    }
}
