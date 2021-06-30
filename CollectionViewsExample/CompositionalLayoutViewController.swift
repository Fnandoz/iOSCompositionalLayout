//
//  CompositionalLayoutViewController.swift
//  CollectionViewsExample
//
//  Created by Fernando Gomes on 30/06/21.
//

import UIKit

private let reuseIdentifier = "cell"
let headerId = "headerId"
let categoryHeaderId = "categoryHeaderId"

class CompositionalLayoutViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let itens: [UIColor] = [.red, .purple, .blue, .cyan, .yellow, .red, .green, .magenta, .systemTeal]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: categoryHeaderId, withReuseIdentifier: headerId)

        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.reloadData()
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.firstLayoutSection()
            case 1: return self.secondLayoutSection()
            default: return self.thirdLayoutSection()
            }
        }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension:
        .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func secondLayoutSection() -> NSCollectionLayoutSection {

       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
    heightDimension: .absolute(100))

       let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 15)

       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
    heightDimension: .estimated(500))

       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

       let section = NSCollectionLayoutSection(group: group)
     section.contentInsets.leading = 15

       section.boundarySupplementaryItems = [
    NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension:
    .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: categoryHeaderId, alignment:
    .topLeading)
    ]

     return section
    }
    
    private func thirdLayoutSection() -> NSCollectionLayoutSection {

       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:
    .fractionalHeight(1))

       let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets.bottom = 15

       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
    heightDimension: .fractionalWidth(0.35))

       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 2)

       let section = NSCollectionLayoutSection(group: group)

       section.orthogonalScrollingBehavior = .continuous

       return section
    }

}


extension CompositionalLayoutViewController: UICollectionViewDelegate {}

extension CompositionalLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 9
        default:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        cell.backgroundColor = itens.randomElement()
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
               
       return header
    }
}
