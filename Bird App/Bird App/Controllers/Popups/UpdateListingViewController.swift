import UIKit

class UpdateListingViewController: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    
    var heading: String?
    var species: [TBL_SPECIES]?
    var varieties: [TBL_VARIETIES]?
    var mutation: [TBL_MUTATION]?
    
    var delegate: UpdateListing?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ListingTableCell", bundle: nil), forCellReuseIdentifier: ListingTableCell.description())
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 45
        self.makeTopCornersRounded(roundView: self.mainView)
        
        if let h = heading {
            title = h
            self.tableView.isHidden = false
        }
        if let s = species {
            addSingleNavigationButtons()
            addAddButton(type: "species")
            title = "Select Species"
            if s.count > 0 {
                self.tableView.isHidden = false
            } else {
                self.errorMessage.text = "No Species Found"
            }
        }
        if let v = varieties {
            addSingleNavigationButtons()
            addAddButton(type: "varieties")
            title = "Select Varieties"
            if v.count > 0 {
                self.tableView.isHidden = false
            } else {
                self.errorMessage.text = "No Varieties Found"
            }
        }
        if let m = mutation {
            addSingleNavigationButtons()
            addAddButton(type: "mutation")
            title = "Select Mutation"
            if m.count > 0 {
                self.tableView.isHidden = false
            } else {
                self.errorMessage.text = "No Mutation Found"
            }
        }
    }
    private func addAddButton(type: String) {
        let add = UIButton()
        add.setImage(UIImage(named: "add"), for: .normal)
        if type == "species" {
            add.addTarget(self, action: #selector(addSpecies), for: .touchUpInside)
        } else if type == "varieties" {
            add.addTarget(self, action: #selector(addVarieties), for: .touchUpInside)
        } else if type == "mutation" {
            
        }
        let addBtn = UIBarButtonItem(customView: add)
        
        self.navigationItem.rightBarButtonItem = addBtn
    }
    @objc func addSpecies() {
        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddSpeciesViewController") as! AddSpeciesViewController
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        controller.delegate = self
        Helper.topMostController().present(controller, animated: true, completion: nil)
    }
    @objc func addVarieties() {
        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddVarietyViewController") as! AddVarietyViewController
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        controller.delegate = self
        Helper.topMostController().present(controller, animated: true, completion: nil)
    }
    @objc func addMutation() {
        let storyboard = UIStoryboard(name: "Popups", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddMutationViewController") as! AddMutationViewController
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


extension UpdateListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.species?.count {
            return count
        }
        if let count = self.varieties?.count {
            return count
        }
        return STATUS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableCell.description()) as? ListingTableCell else {
            fatalError()
        }
        if let species = self.species {
            cell.txtLabel.text = species[indexPath.row].name
            return cell
        }
        if let variety = self.varieties {
            cell.txtLabel.text = variety[indexPath.row].name
            return cell
        }
        cell.txtLabel.text = STATUS[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            if let species = self.species {
                self.delegate?.updateSpecies(species: species[indexPath.row])
                return
            }
            if let variety = self.varieties {
                self.delegate?.updateVarieties(varieties: variety[indexPath.row])
                return
            }
            self.delegate?.updateStatus(status: STATUS[indexPath.row])
        }
    }
}


extension UpdateListingViewController: AddNewItems {
    func addNewSpecies() {
        self.species = db?.read_tbl_species(query: "SELECT * FROM TBL_SPECIES")
        reloadTable()
    }
    func addNewVariety() {
        self.varieties = db?.read_tbl_varieties(query: "SELECT * FROM tbl_varieties WHERE speciesId = '\(tbl_species?.id ?? 0)'")
        reloadTable()
    }
    func addNewMutation() {}
    
    func reloadTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let v = self.varieties {
                if v.count > 0 {
                    self.tableView.isHidden = false
                } else {
                    self.errorMessage.text = "No Varieties Found"
                }
            }
            self.tableView.reloadData()
        }
    }
}
