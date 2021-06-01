import UIKit

class AllBirdsTableCell: UITableViewCell {
    override class func description() -> String {
        return "AllBirdsTableCell"
    }
    @IBOutlet weak var sex: UIImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var ring_number: UILabel!
    @IBOutlet weak var cage_number: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var tableViewHeight: CGFloat = 102
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
