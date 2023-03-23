//
//  textfieldtable.swift
//  (ammaraidzat)AppTest
//
//  Created by Ammar Aidzat on 23/03/2023.
//

import UIKit
import Combine

class TableTextFieldCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    private var textFieldToken: Any?
    var textChanged: ((String?) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        textFieldToken = NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main, using: { [weak self] notification in
            guard let textField = notification.object as? UITextField else {
                return
            }
            self?.textChanged?(textField.text)
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
