import UIKit
import SkyFloatingLabelTextField
import DatePickerDialog

class BasicViewController: BaseViewController {

    @IBOutlet weak var basicName: SkyFloatingLabelTextField!
    @IBOutlet weak var basicNameCounter: UILabel!
    @IBOutlet weak var species: SkyFloatingLabelTextField!
    @IBOutlet weak var variety: SkyFloatingLabelTextField!
    @IBOutlet weak var dateofbanding: SkyFloatingLabelTextField!
    @IBOutlet weak var status: SkyFloatingLabelTextField!
    @IBOutlet weak var cage: SkyFloatingLabelTextField!
    @IBOutlet weak var cageCounter: UILabel!
    
    @IBOutlet var sexImage: [UIImageView]!
    @IBOutlet var sexButton: [UIButton]!
    
    let datePicker = DatePickerDialog(
        textColor: .nativeBlueColor(),
        buttonColor: .nativeBlueColor(),
        font: UIFont.boldSystemFont(ofSize: 17),
        showCancelButton: true
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        basicName.delegate = self
        species.delegate = self
        variety.delegate = self
        dateofbanding.delegate = self
        status.delegate = self
        cage.delegate = self
        
        view.backgroundColor = UIColor.white
    }
    
    func openDatePicker(title: String, handler: @escaping(_ success: Bool,_ date: String) -> Void) {
        datePicker.show(title,
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        maximumDate: Date(),
                        datePickerMode: .date,
                        window: self.view.window) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                handler(true, formatter.string(from: dt))
            }
        }
    }
    
    @IBAction func sexBtnTapped(_ sender: UIButton) {
        sexButton.forEach { (btn) in
            btn.isSelected = false
        }
        sexImage.forEach { (image) in
            image.image = UIImage(named: "radioUnmark")
        }
        
        sexButton[sender.tag].isSelected = true
        sexImage[sender.tag].image = UIImage(named: "radioMark")
    }
    
}

extension BasicViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0, 5:
            return true
        case 1:
            let storyboard = UIStoryboard(name: "Popups", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "listingNav") as! UINavigationController
            if #available(iOS 13.0, *) {
                controller.modalPresentationStyle = .overFullScreen
            }
            controller.modalTransitionStyle = .crossDissolve
            (controller.children.first as! UpdateListingViewController).species = db?.read_tbl_species(query: "SELECT * FROM TBL_SPECIES")
            (controller.children.first as! UpdateListingViewController).delegate = self
            Helper.topMostController().present(controller, animated: true, completion: nil)
            break
        case 2:
            if self.species.text == "" {
                
                return false
            }
            let storyboard = UIStoryboard(name: "Popups", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "listingNav") as! UINavigationController
            if #available(iOS 13.0, *) {
                controller.modalPresentationStyle = .overFullScreen
            }
            controller.modalTransitionStyle = .crossDissolve
            (controller.children.first as! UpdateListingViewController).varieties = db?.read_tbl_varieties(query: "SELECT * FROM tbl_varieties WHERE speciesId = '\(tbl_species?.id ?? 0)'")
            (controller.children.first as! UpdateListingViewController).delegate = self
            Helper.topMostController().present(controller, animated: true, completion: nil)
            break
        case 3:
            self.openDatePicker(title: "Date of Banding") { (granted, date) in
                if granted {
                    self.dateofbanding.text = date
                }
            }
            break
        case 4:
            let storyboard = UIStoryboard(name: "Popups", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "listingNav") as! UINavigationController
            if #available(iOS 13.0, *) {
                controller.modalPresentationStyle = .overFullScreen
            }
            controller.modalTransitionStyle = .crossDissolve
            (controller.children.first as! UpdateListingViewController).heading = "Select Status"
            (controller.children.first as! UpdateListingViewController).delegate = self
            Helper.topMostController().present(controller, animated: true, completion: nil)
            break
        default: break
        }
        return false
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 0
        if textField.tag == 0 {
            maxLength = 30
        } else {
            maxLength = 15
        }
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length <= maxLength {
            if textField.tag == 0 {
                basicNameCounter.text = "\(newString.length)/30"
            } else {
                cageCounter.text = "\(newString.length)/15"
            }
            return true
        }
        return false
    }
}


extension BasicViewController: UpdateListing {
    func updateStatus(status: String) {
        self.status.text = status
    }
    func updateSpecies(species: TBL_SPECIES) {
        tbl_species = species
        self.species.text = species.name
    }
    func updateVarieties(varieties: TBL_VARIETIES) {
        tbl_varieties = varieties
        self.variety.text = varieties.name
    }
}
