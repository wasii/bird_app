//
//  AddVarietyViewController.swift
//  Bird App
//
//  Created by TCS on 26/05/2021.
//

import UIKit
import SkyFloatingLabelTextField

class AddVarietyViewController: BaseViewController {

    @IBOutlet weak var name: SkyFloatingLabelTextField!
    @IBOutlet weak var nameCounter: UILabel!
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
        name.delegate = self
    }
    @IBAction func donePressed(_ sender: Any) {
        if let species = tbl_species {
            db?.insert_tbl_varieties(name: name.text!, speciesId: species.id!, { _ in
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.delegate?.addNewVariety()
                    }
                }
            })
        }
    }
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddVarietyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length <= 50 {
            nameCounter.text = "\(newString.length)/50"
            return true
        }
        return false
    }
}
