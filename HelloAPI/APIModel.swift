//
//  APIModel.swift
//  HelloAPI
//
//  Created by 黃柏瀚 on 2022/6/25.
//

import UIKit
import Alamofire

class APIModel  {
    
    //單例化:防止他人串改
    static var share = APIModel()
    private var apiURL = "https://randomuser.me"
    private init(){
        
    }
    
    func queryRandomUserAlamofire(completion:@escaping (_ Data:Any?,_ respError: Error?)->())->(){
        let url = apiURL + "/api/"
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: nil).responseJSON { respons in
                    switch respons.result{
                        case .success(_):
                            return completion(respons.data,nil)
                        case .failure(let error):
                            return completion(nil,error)
            }
        }
    }
    
}

    
