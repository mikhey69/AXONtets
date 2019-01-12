import UIKit
import AlamofireImage
import Alamofire

class DetailsView: UIViewController {
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var contactInfo: UITableView!
    
    var id = ""
    var user: User!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("id \(id)")
        user = appDelegate.userList.filter({$0.id.value == id}).first
        
        self.title = "AXON Detils"
        imgView.layer.cornerRadius = 60
        imgView.clipsToBounds = true
        
        DispatchQueue.global().async {
            Alamofire.request(URL(string: self.user.picture.large)!).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        self.imgView.image = image
                    }
                }
            }
        }
    }
}

extension DetailsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        cell.textLabel?.textColor = UIColor.white
        cell.callBut.isHidden = true
        switch indexPath.row {
        case 0:
            let first = String(user.name.first.first ?? "a").uppercased() + String(user.name.first.dropFirst())
            let last = String(user.name.last.first ?? "a").uppercased() + String(user.name.last.dropFirst())
            cell.nameLbl.text = "\(first) \(last)"
        case 1:
            cell.nameLbl.text = user.gender
        case 2:
            cell.nameLbl.text = String((user.dob.date).dropLast(10))
        case 3:
            cell.nameLbl.text = user.email
        case 4:
            cell.nameLbl.text = user.phone
            cell.callBut.isHidden = false
            cell.phone = user.phone
            
        default:
            break
        }
        
        return cell
    }
}
