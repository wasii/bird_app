import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
        
        if #available(iOS 13.0, *) {
            controller.modalPresentationStyle = .overFullScreen
        }
        
        present(controller, animated: true, completion: nil)
    }
}
