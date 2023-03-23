//
//  TableView.swift
//  (ammaraidzat)AppTest
//
//  Created by Ammar Aidzat on 23/03/2023.
//

import UIKit

class TableHeaderView: UIView {
    let bgView = UIView()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TableHeaderView {
    func configure() {
        //translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = .white
        addSubview(bgView)
        bgView.addSubview(imageView)
        imageView.layer.cornerRadius = 40
        imageView.backgroundColor = UIColor(red: 1, green: 140/255, blue: 0, alpha: 1)
        imageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            //heightAnchor.constraint(equalToConstant: 85),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}


