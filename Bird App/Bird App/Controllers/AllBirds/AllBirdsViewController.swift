import UIKit

class AllBirdsViewController: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var animationDuration: TimeInterval = 0.3
    var delay: TimeInterval = 0.01
    var currentTableAnimation: TableAnimation = .fadeIn(duration: 0.3, delay: 0.01) {
        didSet {
//            self.tableViewHeaderText = currentTableAnimation.getTitle()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeTopCornersRounded(roundView: self.mainView)
        self.tableView.register(UINib(nibName: AllBirdsTableCell.description(), bundle: nil), forCellReuseIdentifier: AllBirdsTableCell.description())
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
        
        self.tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    @IBAction func addNewBird(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddNewBirdRootViewController") as! AddNewBirdRootViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
extension AllBirdsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AllBirdsTableCell().tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AllBirdsTableCell.description(), for: indexPath) as? AllBirdsTableCell {
            if (indexPath.row % 2) == 0 {
                cell.sex.image = UIImage(named: "male")
            } else {
                cell.sex.image = UIImage(named: "female")
            }
            return cell
        }
        fatalError()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AllBirdDetailsViewController") as! AllBirdDetailsViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}
