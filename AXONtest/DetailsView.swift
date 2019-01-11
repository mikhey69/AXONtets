//
//  DetailsView.swift
//  AXONtest
//
//  Created by mikhey on 1/12/19.
//  Copyright © 2019 softevol. All rights reserved.
//

import UIKit

class DetailsView: UIViewController {
    
    var id = ""
    var user: User!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("id \(id)")
        user = appDelegate.userList.filter({$0.id.value == id}).first
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
