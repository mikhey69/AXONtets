import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON



class MaincScreenTVC: UITableViewController {
    
    var count = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Loading")
            self.addChild(vc!)
            self.view.addSubview((vc?.view)!)
        }
        self.tableView.isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.update), name: NSNotification.Name("Update"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func update() {
        print("done")
        self.tableView.isScrollEnabled = true
        tableView.reloadData()
        tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: UITableView.RowAnimation.fade)
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.userList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! MainScreenCell
        let user = appDelegate.userList[indexPath.row]
        cell.id = user.id.value
        cell.imgView.layer.cornerRadius = 35
        cell.imgView.image = UIImage(named: "")
        DispatchQueue.global().async {
            Alamofire.request(URL(string: user.picture.large)!).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                }
            }
        }
        
        
        let first = String(user.name.first.first ?? "a").uppercased() + String(user.name.first.dropFirst())
        let last = String(user.name.last.first ?? "a").uppercased() + String(user.name.last.dropFirst())
        cell.nameLbl.text = "\(first) \(last)"
        cell.ageLbl.text = "\(user.dob.age)"
        cell.imgView.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainScreenCell
        performSegue(withIdentifier: "showDetails", sender: cell.id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let id = sender as! String
            let vc = segue.destination as! DetailsView
            vc.id = id
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
