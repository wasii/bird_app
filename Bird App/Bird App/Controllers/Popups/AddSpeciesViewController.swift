//
//  AddSpeciesViewController.swift
//  Bird App
//
//  Created by TCS on 26/05/2021.
//

import UIKit
import SkyFloatingLabelTextField

class AddSpeciesViewController: BaseViewController {

    @IBOutlet weak var name: SkyFloatingLabelTextField!
    @IBOutlet weak var nameCounter: UILabel!
    @IBOutlet weak var incubatingDays: SkyFloatingLabelTextField!
    @IBOutlet weak var bandingDays: SkyFloatingLabelTextField!
    
    var delegate: AddNewItems?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.7)
        
        name.placeholder = "Enter Name"
        name.title = "Name (*)"
        name.selectedTitle = "Name (*)"
        name.titleColor = UIColor.nativeBlueColor()
        name.selectedLineColor = UIColor.nativeBlueColor()
        name.selectedTitleColor = UIColor.nativeBlueColor()
        name.tag = 0
        
        name.delegate = self
        
        incubatingDays.placeholder = "Incubating Days"
        incubatingDays.title = "Incubating Days (*)"
        incubatingDays.selectedTitle = "Incubating Days (*)"
        incubatingDays.titleColor = UIColor.nativeBlueColor()
        incubatingDays.selectedLineColor = UIColor.nativeBlueColor()
        incubatingDays.selectedTitleColor = UIColor.nativeBlueColor()
        incubatingDays.keyboardType = .numberPad
        incubatingDays.tag = 1
        incubatingDays.delegate = self
        
        bandingDays.placeholder = "Banding Days"
        bandingDays.title = "Banding Days (*)"
        bandingDays.selectedTitle = "Banding Days (*)"
        bandingDays.titleColor = UIColor.nativeBlueColor()
        bandingDays.selectedLineColor = UIColor.nativeBlueColor()
        bandingDays.selectedTitleColor = UIColor.nativeBlueColor()
        bandingDays.keyboardType = .numberPad
        bandingDays.tag = 2
        bandingDays.delegate = self
    }
    @IBAction func donePressed(_ sender: Any) {
        db?.insert_tbl_species(name: name.text!, incubatingDays: incubatingDays.text!, bandingDays: bandingDays.text!, { _ in
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                    self.delegate?.addNewSpecies()
                }
            }
        })
        
    }
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension AddSpeciesViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 0
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
        switch textField.tag {
        case 0:
            maxLength = 80
            break
            
        case 1, 2:
            maxLength = 2
            break
        default:
            break
        }
        if newString.length <= maxLength {
            if textField.tag == 0 {
                nameCounter.text = "\(newString.length)/80"
            }
            return true
        }
        return false
    }
}
