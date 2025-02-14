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
    var dataList = [Helper]()
    var urlbase1 = "https://api.ajmo.hr/v3/news/index?isPromoted=0&page="
    var urlBase2 = "&perPage=10"
    var delegate : APIErrorDelegate?
    
    func getData(pageNumber: String, callBack: @escaping ([DataGettable], Bool) -> Void){
        JSONParser.shared.fetch(urlString: urlbase1 + pageNumber + urlBase2) { (result: Result<WhatsUpModel, RequestError>) in
            switch result{
            case .success(let model):
                model.data.forEach { (data) in
                    let model = Helper()
                    model.id = data.id
                    model.caption = data.caption
                    model.title = data.title
                    if !data.links[0].linkType.rawValue.isStringNilOrEmpty(){
                        model.linkType = data.links[0].linkType.rawValue
                    }else{
                         model.linkType = "event"
                    }
                    model.createdAt = data.createdAt
                    model.imageURL = data.imageURL
                    model.datumDescription = data.datumDescription

                    data.gallery.forEach { (gal) in
                        model.picture = gal.picture
                    }
                    model.isHighlighted = data.isHighlighted

                    self.dataList.append(model)
                }
                callBack(self.dataList, true)
            case .failure(let error):
                self.delegate?.getError(error: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
}
