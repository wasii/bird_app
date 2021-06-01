import UIKit
import SkyFloatingLabelTextField

class AddMutationViewController: BaseViewController {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var name: SkyFloatingLabelTextField!
    @IBOutlet weak var nameCounter: UILabel!
    @IBOutlet weak var symbol: SkyFloatingLabelTextField!
    @IBOutlet weak var symbolCounter: UILabel!
    
    
    
    //Mutation Type View
    @IBOutlet weak var MutationTypeView: UIView!
    
    //Alelles View
    @IBOutlet weak var AlellesView: UIView!
    
    //Alelles Type View
    @IBOutlet weak var AlellesTypeView: UIView!
    var delegate: AddNewItems?
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTopCornersRounded(roundView: mainView)
    }
}
