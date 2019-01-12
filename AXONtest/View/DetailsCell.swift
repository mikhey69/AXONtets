import UIKit

class DetailsCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var callBut: UIButton!
    
    var phone = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    @IBAction func callTap(_ sender: Any) {
        //caling
        print("call \(phone)")
        callTo(number: phone)
    }
    
    private func callTo(number: String) {
        let url = URL(string: "telprompt://\(phone)")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: {
                (success) in
                print("Open \(url!): \(success)")
            })
        } else {
            print("error")
        }
    }
}
