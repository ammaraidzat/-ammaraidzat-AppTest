//
//  contactdetailviewcontroller.swift
//  (ammaraidzat)AppTest
//
//  Created by Ammar Aidzat on 23/03/2023.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    typealias RowTypes = ContactsViewModel.ContactDetailType
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerView: UIView!
    var headerView: TableHeaderView!
    var contactInDisplay: Contact?
    var vm: ContactsViewModel!
    
    var tableSectionData: [Int: [RowTypes]] = [0:[.firstName, .lastName],
                                               1:[.email,.dob]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = TableHeaderView(frame: CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 90)))
        tableView.tableHeaderView = headerView
        datePickerView.isHidden = true
    }
    
    @IBAction func saveButtonPressed(_ button: UIBarButtonItem) {
        guard datePickerView.isHidden else { return }
        if let contactInDisplay = contactInDisplay {
            vm.saveEditedContact(contactInDisplay)
        }
    }
    
    @IBAction func cancelButtonPressed(_ button: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
}


extension ContactDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableSectionData[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "text-cell") as! TableTextFieldCell
        let row: RowTypes = tableSectionData[indexPath.section]![indexPath.row]
        cell.label.text = row.rawValue
        switch row {
        case .firstName:
            cell.textField.text = contactInDisplay?.firstname
            cell.textChanged = {[weak self] newText in
                self?.contactInDisplay?.firstname = newText ?? ""
            }
        case .lastName:
            cell.textField.text = contactInDisplay?.lastname
            cell.textChanged = {[weak self] newText in
                self?.contactInDisplay?.lastname = newText ?? ""
            }
        case .email:
            cell.textField.text = contactInDisplay?.email
            cell.textChanged = {[weak self] newText in
                self?.contactInDisplay?.email = newText
            }
        case .dob:
            if let date = contactInDisplay?.dob {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                cell.textField.text = formatter.string(from: date)
            } else {
                cell.textField.text = nil
            }
            configureDateSectionField(cell.textField)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Main Information":"Sub Information"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.01
    }
    
    
    func configureDateSectionField(_ field: UITextField) {
        let overlayButton = UIButton(type: .custom)
        let pickerImage = UIImage(systemName: "calendar")
        overlayButton.setImage(pickerImage, for: .normal)
        overlayButton.addTarget(self, action: #selector(self.showDatePicker(_:)), for: .touchUpInside)
        overlayButton.tintColor = UIColor(red: 1, green: 140/255, blue: 0, alpha: 1)
        overlayButton.sizeToFit()
        field.rightView = overlayButton
        field.rightViewMode = .always
    }
    
    
    @objc func showDatePicker(_ sender: AnyObject) {
        datePickerView.isHidden = false
    }
    
    @IBAction func datePickerDonePressed(_ sender: UIButton) {
        datePickerView.isHidden = true
        contactInDisplay?.dob = datePicker.date
        tableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
    }
    
}
