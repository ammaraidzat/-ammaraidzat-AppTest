//
//  ViewController.swift
//  (ammaraidzat)AppTest
//
//  Created by Ammar Aidzat on 23/03/2023.
//

import UIKit
import Combine

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Contact>! = nil
    let vm: ContactsViewModel = ContactsViewModel()
    var subscription: AnyCancellable?
    
    enum Section {
        case main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contacts"
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        
        subscription = vm.$reloadMainView
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.reloadCollectionView()
            }
        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Contact>()
        snapshot.appendSections([.main])
        snapshot.appendItems(vm.contact)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "open-details", let nextVc = segue.destination as? ContactDetailViewController {
            nextVc.contactInDisplay = sender as? Contact
            nextVc.vm = vm
        }
    }
}


extension ContactsViewController {
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ContactsViewController {
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ContactRow, Contact> { (cell, indexPath, contact) in
            cell.label.text = contact.firstname
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 1
            cell.label.textAlignment = .center
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Contact>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, contact: Contact) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: contact)
        }

    }
}

extension ContactsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let contact = vm.contact[indexPath.item]
        performSegue(withIdentifier: "open-details", sender: contact)
    }
    
}

