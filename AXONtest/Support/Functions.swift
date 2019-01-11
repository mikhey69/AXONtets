//
//  Functions.swift
//  AXONtest
//
//  Created by softevol on 1/11/19.
//  Copyright © 2019 softevol. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class Functions: NSObject {
    
    private override init() { }
    static let shared = Functions()
    
    
    
    func requestUser() {
        
        //request
        Alamofire.request(URL(string: "https://randomuser.me/api/") ?? "").responseJSON { [weak self] (response) in
            guard response.result.value != nil else {
                print("response error")
                return
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            print("top")
            let json = JSON(response.result.value!)
            let user = Functions.shared.tern(jsonRes: json)
            appDelegate.userList.append(user)
            //for 20 items
            if appDelegate.userList.count < 20 {
                self?.requestUser()
            }
            
            DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
            }
        }
    }
    
    func tern(jsonRes: JSON) -> User {
        //error handle
        let json = jsonRes["results"].arrayValue.first!
        let name = Name.init(title: json["name"]["title"].stringValue,
                             first: json["name"]["first"].stringValue,
                             last: json["name"]["last"].stringValue)
        let coordinates = Coordinates.init(latitude: json["location"]["coordinates"]["latitude"].stringValue,
                                           longitude: json["location"]["coordinates"]["longitude"].stringValue)
        let timezone = Timezonee.init(offset: json["location"]["timezone"]["offset"].stringValue,
                                      description: json["location"]["timezone"]["description"].stringValue)
        
        
        let location = Location.init(street: json["location"]["street"].stringValue,
                                     city: json["location"]["city"].stringValue,
                                     state: json["location"]["state"].stringValue,
                                     postcode: json["location"]["postcode"].stringValue,
                                     coordinates: coordinates,
                                     timezone: timezone)
        
        let login = Login.init(uuid: json["login"]["uuid"].stringValue,
                               username: json["login"]["username"].stringValue,
                               password: json["login"]["uuid"].stringValue,
                               salt: json["login"]["salt"].stringValue,
                               md5: json["login"]["md5"].stringValue,
                               sha1: json["login"]["sha1"].stringValue,
                               sha256: json["login"]["sha256"].stringValue)
        
        let dob = Dob.init(date: json["dob"]["date"].stringValue,
                           age: json["dob"]["age"].intValue)
        
        let registered = Registered.init(date: json["registered"].stringValue,
                                         age: json["age"].intValue)
        
        let id = Id.init(name: json["id"]["name"].stringValue,
                         value: json["id"]["value"].stringValue)
        
        
        let picture = Picture.init(large: json["picture"]["large"].stringValue,
                                   medium: json["picture"]["medium"].stringValue,
                                   thumbnail: json["picture"]["thumbnail"].stringValue)
        
        let user = User.init(gender: json["gender"].stringValue,
                             name: name,
                             location: location,
                             email: json["email"].stringValue,
                             login: login,
                             dob: dob,
                             registered: registered,
                             phone: json["phone"].stringValue,
                             cell: json["cell"].stringValue,
                             id: id,
                             picture: picture,
                             nat: json["nat"].stringValue)
        return user
    }
    
    
}
