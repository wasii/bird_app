import UIKit
import SkyFloatingLabelTextField

class OriginViewController: BaseViewController {

    @IBOutlet weak var father: SkyFloatingLabelTextField!
    @IBOutlet weak var mother: SkyFloatingLabelTextField!
    @IBOutlet weak var breederTypeView: UIView!
    @IBOutlet weak var detailTypeView: UIView!
    @IBOutlet weak var breeder: SkyFloatingLabelTextField!
    @IBOutlet weak var buyPrice: SkyFloatingLabelTextField!
    @IBOutlet weak var boughtOn: SkyFloatingLabelTextField!
    
    
    @IBOutlet var selectedImages: [UIImageView]!
    var isMale = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        father.delegate = self
        mother.delegate = self
        breeder.delegate = self
        buyPrice.delegate = self
        boughtOn.delegate = self
        
        breederTypeView.isHidden = true
        detailTypeView.isHidden = true
        breeder.text = " "
        buyPrice.text = " "
        boughtOn.text = "Select Date"
    }
    
    @IBAction func provenanceTapped(_ sender: UIButton) {
        selectedImages.forEach { (image) in
            image.image = UIImage(named: "radioUnmark")
        }
        selectedImages[sender.tag].image = UIImage(named: "radioMark")
        switch sender.tag {
        case 0:
            breederTypeView.isHidden = true
            detailTypeView.isHidden = true
            break
        case 1:
            breederTypeView.isHidden = false
            detailTypeView.isHidden = false
            break
        case 2:
            breederTypeView.isHidden = false
            detailTypeView.isHidden = true
            break
        default:
            break
        }
    }
}
extension OriginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0, 1:
            let storyboard = UIStoryboard(name: "Popups", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "chooseABirdNav") as! UINavigationController
            if #available(iOS 13.0, *) {
                controller.modalPresentationStyle = .overFullScreen
            }
            if textField.tag == 0 {
                isMale = true
                (controller.children.first as! ChooseABirdViewController).sexType = "Male"
                (controller.children.first as! ChooseABirdViewController).heading = "Choose Father"
            } else {
                isMale = false
                (controller.children.first as! ChooseABirdViewController).heading = "Choose Mother"
            }
            controller.modalTransitionStyle = .crossDissolve
            (controller.children.first as! ChooseABirdViewController).delegate = self
            Helper.topMostController().present(controller, animated: true, completion: nil)
            break
        case 2:
            break
        case 3:
            if textField.text == " " {
                textField.text = ""
            }
            return true
        case 4:
            break
        default: break
        }
        return false
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 3 {
            if textField.text!.count >= 0 {
                textField.text = " "
            }
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 3 {
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length <= 7 {
                return true
            }
            return false
        } else {
            return true
        }
    }
    
    
}

extension OriginViewController: UpdateListing {
    func updateStatus(status: String) {
        if isMale {
            self.father.text = status
        } else {
            self.mother.text = status
        }
    }
    func updateSpecies(species: TBL_SPECIES) {}
    func updateVarieties(varieties: TBL_VARIETIES) {}
}
