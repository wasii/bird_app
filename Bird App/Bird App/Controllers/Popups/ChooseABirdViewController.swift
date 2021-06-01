//
//  ChooseABirdViewController.swift
//  Bird App
//
//  Created by TCS on 23/05/2021.
//

import UIKit

class ChooseABirdViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var heading: String?
    var sexType: String?
    var delegate: UpdateListing?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let heading = heading {
            title = heading
        }
        self.tableView.register(UINib(nibName: AllBirdsTableCell.description(), bundle: nil), forCellReuseIdentifier: AllBirdsTableCell.description())
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
extension ChooseABirdViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AllBirdsTableCell().tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AllBirdsTableCell.description(), for: indexPath) as? AllBirdsTableCell {
            if let _ = sexType {
                cell.sex.image = UIImage(named: "male")
            } else {
                cell.sex.image = UIImage(named: "female")
            }
            return cell
        }
        fatalError()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            if let _ = self.sexType {
                self.delegate?.updateStatus(status: "Father")
            } else {
                self.delegate?.updateStatus(status: "Mother")
            }
        }
    }
}

