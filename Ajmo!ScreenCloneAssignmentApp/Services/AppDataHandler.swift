//
//  AppDataHandler.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 23/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation

class AppDataHandler{
    
    var results = [Data]()
    
    func getData(callBack: @escaping ([Data]) -> Void){
        JSONParser.shared.fetch(urlString: "https://api.ajmo.hr/v3/news/index?isPromoted=0&page=1&perPage=10") { (result: Result<WhatsUpModel, RequestError>) in
            switch result{
            case .success(let model):
                model.data.forEach { (data) in
                    self.results.append(data)
                }
                callBack(self.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
