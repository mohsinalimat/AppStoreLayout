//
//  AppsViewController.swift
//  AppStoreLayout
//
//  Created by Juan Laube on 6/8/19.
//  Copyright © 2019 Juan Laube. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let headerKind = "Header"

    private var dataSource: UICollectionViewDiffableDataSource<AppsSection, Int>!

    var sections = [
        AppsSection(id: UUID(), title: "Featured", layout: .galleryLarge, items: [1, 2, 3, 4, 5, 6, 7, 8, 9]),
        AppsSection(id: UUID(), title: "Apps you might like", layout: .galleryMedium, items: [10, 12, 13, 14, 15, 16, 17, 18, 19]),
        AppsSection(id: UUID(), title: "Top free", layout: .iconsSmall, items: [100, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118]),
        AppsSection(id: UUID(), title: "Top paid", layout: .iconsMedium, items: [1000, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009]),
        AppsSection(id: UUID(), title: "Top selling", layout: .iconsLarge, items: [10000, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009]),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        configureDataSource()
        createLayout()
    }

    private func registerCells() {
        collectionView.register(AppsGalleryLargeCollectionViewCell.nib, forCellWithReuseIdentifier: AppsGalleryLargeCollectionViewCell.reuseIdentifier)
        collectionView.register(AppsGalleryMediumCollectionViewCell.nib, forCellWithReuseIdentifier: AppsGalleryMediumCollectionViewCell.reuseIdentifier)
        collectionView.register(AppsIconLargeCollectionViewCell.nib, forCellWithReuseIdentifier: AppsIconLargeCollectionViewCell.reuseIdentifier)
        collectionView.register(AppsIconMediumCollectionViewCell.nib, forCellWithReuseIdentifier: AppsIconMediumCollectionViewCell.reuseIdentifier)
        collectionView.register(AppsIconSmallCollectionViewCell.nib, forCellWithReuseIdentifier: AppsIconSmallCollectionViewCell.reuseIdentifier)

        collectionView.register(AppsSectionHeaderCollectionReusableView.nib, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: AppsSectionHeaderCollectionReusableView.reuseIdentifier)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<AppsSection, Int>(collectionView: collectionView, cellProvider: configureCell)
        dataSource.supplementaryViewProvider = configureSupplementaryViews

        let snapshot = NSDiffableDataSourceSnapshot<AppsSection, Int>()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }

        dataSource.apply(snapshot)
    }

    private func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? {
        let reuseIdentifier: String
        // TODO: this is wrong
        let section = sections[indexPath.section]
        switch section.layout {
        case .galleryLarge: reuseIdentifier = AppsGalleryLargeCollectionViewCell.reuseIdentifier
        case .galleryMedium: reuseIdentifier = AppsGalleryMediumCollectionViewCell.reuseIdentifier
        case .iconsLarge: reuseIdentifier = AppsIconLargeCollectionViewCell.reuseIdentifier
        case .iconsMedium: reuseIdentifier = AppsIconMediumCollectionViewCell.reuseIdentifier
        case .iconsSmall: reuseIdentifier = AppsIconSmallCollectionViewCell.reuseIdentifier
        default: fatalError("This layout is not supported yet")
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }

    private func configureSupplementaryViews(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        switch kind {
        case headerKind:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: headerKind, withReuseIdentifier: AppsSectionHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! AppsSectionHeaderCollectionReusableView
            let section = sections[indexPath.section]
            header.title.text = section.title
            return header
        default:
            return nil
        }
    }

    private func createLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            let section = self.sections[sectionIndex]
            switch section.layout {
            case .galleryLarge: return self.galleryLargeLayout(environment: environment)
            case .galleryMedium: return self.galleryMediumLayout(environment: environment)
            case .iconsLarge: return self.iconsLargeLayout(environment: environment)
            case .iconsMedium: return self.iconsMediumLayout(environment: environment)
            case .iconsSmall: return self.iconsSmallLayout(environment: environment)
            default: fatalError("This layout is not supported yet")
            }
        }

        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    private func galleryLargeLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))

        let itemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: environment.traitCollection.horizontalSizeClass == .compact ? .fractionalWidth(0.9) : .absolute(320),
                                               heightDimension: .absolute(280)),
            subitems: [item])
        itemsGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let section = NSCollectionLayoutSection(group: itemsGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func galleryMediumLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))

        let itemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: environment.traitCollection.horizontalSizeClass == .compact ? .fractionalWidth(0.6) : .absolute(240),
                                               heightDimension: .absolute(200)),
            subitems: [item])
        itemsGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(34)),
            elementKind: headerKind,
            alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: itemsGroup)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func iconsLargeLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let itemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: environment.traitCollection.horizontalSizeClass == .compact ? .fractionalWidth(0.5) : .absolute(200),
                                               heightDimension: .absolute(200)),
            subitems: [item])
        itemsGroup.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(34)),
            elementKind: headerKind,
            alignment: .topLeading)

        let section = NSCollectionLayoutSection(group: itemsGroup)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func iconsMediumLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let itemsGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(200)),
            subitem: item, count: 2)
        itemsGroup.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let nestedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: environment.traitCollection.horizontalSizeClass == .compact ? .fractionalWidth(1.0) : .fractionalWidth(1/3),
                                               heightDimension: .absolute(200)),
            subitems: [itemsGroup])

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(34)),
            elementKind: headerKind,
            alignment: .topLeading)

        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func iconsSmallLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let itemsGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitem: item, count: 3)
        itemsGroup.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let nestedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: environment.traitCollection.horizontalSizeClass == .compact ? .fractionalWidth(1.0) : .fractionalWidth(1/3),
                                               heightDimension: .absolute(200)),
            subitems: [itemsGroup])

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(34)),
            elementKind: headerKind,
            alignment: .topLeading)

        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
