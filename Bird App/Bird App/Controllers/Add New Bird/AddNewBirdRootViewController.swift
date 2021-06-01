import UIKit
import SwipeMenuViewController

class AddNewBirdRootViewController: SwipeMenuViewController {

    private var datas: [String] = ["BASIC", "ORIGIN", "GENETIC", "GALLERY", "NOTES", "CONTESTS"]
    var options = SwipeMenuViewOptions()
    var dataCount: Int = 6
    
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        options.tabView.itemView.selectedTextColor = UIColor.nativeBlueColor()
        datas.forEach { data in
            switch data {
            case "BASIC", "NOTES", "CONTESTS":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BasicViewController") as! BasicViewController
                vc.title = data
                self.addChild(vc)
                break
            case "ORIGIN":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OriginViewController") as! OriginViewController
                vc.title = data
                self.addChild(vc)
                break
            case "GENETIC":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "GeneticViewController") as! GeneticViewController
                vc.title = data
                self.addChild(vc)
                break
            case "GALLERY":
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
                vc.title = data
                self.addChild(vc)
                break
            default:break
            }
        }
        
        super.viewDidLoad()
        self.makeTopCornersRounded(roundView: self.mainView)
        view.backgroundColor = UIColor.nativeBlueColor()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "Add New Bird"
//        addSingleNavigationButton()
    }
    private func addSingleNavigationButton() {
        let sync = UIButton()
        sync.setImage(UIImage(named: "female"), for: .normal)
//        sync.addTarget(self, action: #selector(syncServerData), for: .touchUpInside)
        let syncBtn = UIBarButtonItem(customView: sync)
        self.navigationItem.rightBarButtonItem = syncBtn
    }
    private func makeTopCornersRounded(roundView: UIView) {
        roundView.clipsToBounds = true
        roundView.layer.cornerRadius = 60
        roundView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        super.swipeMenuView(swipeMenuView, viewWillSetupAt: currentIndex)
        print("will setup SwipeMenuView")
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        super.swipeMenuView(swipeMenuView, viewDidSetupAt: currentIndex)
        print("did setup SwipeMenuView")
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        super.swipeMenuView(swipeMenuView, willChangeIndexFrom: fromIndex, to: toIndex)
        print("will change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        super.swipeMenuView(swipeMenuView, didChangeIndexFrom: fromIndex, to: toIndex)
        print("did change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }


    // MARK - SwipeMenuViewDataSource

    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return dataCount
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return children[index].title ?? ""
    }

    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = children[index]
        vc.didMove(toParent: self)
        return vc
    }
}
