//
//  CheckingViewController.swift
//  Bird App
//
//  Created by TCS on 08/05/2021.
//

import UIKit

class CheckingViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var animationDuration: TimeInterval = 0.4
    var delay: TimeInterval = 0.05
    var currentTableAnimation: TableAnimation = .fadeIn(duration: 0.4, delay: 0.03) {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}
