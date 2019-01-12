//
//  Loading.swift
//  AXONtest
//
//  Created by mikhey on 1/12/19.
//  Copyright © 2019 softevol. All rights reserved.
//

import UIKit

class Loading: UIViewController {

    @IBOutlet weak var ativity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ativity.startAnimating()
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteView), name: NSNotification.Name("DeleteView"), object: nil)

    }
    
    @objc func deleteView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.view.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        }) { (Bool) in
            self.ativity.stopAnimating()
            self.removeFromParent()
            self.view.removeFromSuperview()
            NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
        }
    }
}
