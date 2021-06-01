import UIKit
import SwipeMenuViewController

var db: DB?
var tbl_species: TBL_SPECIES?
var tbl_varieties: TBL_VARIETIES?

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.nativeBlueColor()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        db = AppDelegate.sharedInstance.database
    }
    func makeTopCornersRounded(roundView: UIView) {
        roundView.clipsToBounds = true
        roundView.layer.cornerRadius = 40
        roundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func addSingleNavigationButtons() {
        let cross = UIButton()
        cross.setImage(UIImage(named: "close"), for: .normal)
        cross.addTarget(self, action: #selector(crossBtnTapped), for: .touchUpInside)
        let crossBtn = UIBarButtonItem(customView: cross)
        
        self.navigationItem.leftBarButtonItem = crossBtn
    }
    @objc func crossBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
