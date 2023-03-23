//
//  ContactRow.swift
//  (ammaraidzat)AppTest
//
//  Created by Ammar Aidzat on 23/03/2023.
//

import UIKit

class ContactRow: UICollectionViewCell {
    static let reuseIdentifier = "contact-cell-reuse-identifier"
    let label = UILabel()
    let iconImageView = UIImageView()
    let boarderView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension ContactRow {
    func configure() {
        boarderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(boarderView)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        boarderView.addSubview(label)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        boarderView.addSubview(iconImageView)

        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        iconImageView.backgroundColor = UIColor(red: 1, green: 140/255, blue: 0, alpha: 1)
        iconImageView.layer.cornerRadius = 35

        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: boarderView.leadingAnchor, constant: inset),
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: boarderView.bottomAnchor, constant: -5),
            label.trailingAnchor.constraint(equalTo: boarderView.trailingAnchor, constant: -inset),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 70),
            iconImageView.widthAnchor.constraint(equalToConstant: 70),
            iconImageView.centerXAnchor.constraint(equalTo: boarderView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: boarderView.centerYAnchor, constant: -15),

            boarderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            boarderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            boarderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            boarderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
            ])
        
    }
    
    
}

