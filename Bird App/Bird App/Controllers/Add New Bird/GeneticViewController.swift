import UIKit
import SkyFloatingLabelTextField

class GeneticViewController: BaseViewController {

    @IBOutlet weak var genotype: SkyFloatingLabelTextField!
    @IBOutlet weak var genotypeCounter: UILabel!
    @IBOutlet weak var phenotype: SkyFloatingLabelTextField!
    @IBOutlet weak var phenotypeCounter: UILabel!
    @IBOutlet weak var mutation: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        genotype.delegate = self
        phenotype.delegate = self
        mutation.delegate = self
    }
}

extension GeneticViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 50
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length <= maxLength {
            if textField.tag == 0 {
                genotypeCounter.text = "\(newString.length)/50"
            } else {
                phenotypeCounter.text = "\(newString.length)/50"
            }
            return true
        }
        return false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 2 {
            let storyboard = UIStoryboard(name: "Popups", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AddMutationViewController") as! AddMutationViewController
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
            return false
        }
        return true
    }
}

extension GeneticViewController: AddNewItems {
    func addNewSpecies() {}
    func addNewVariety() {}
    func addNewMutation() {
    }
    
}
