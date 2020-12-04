import Foundation
import SwiftUI
import UIKit

typealias Name = String
typealias Region = [Name]

class MushroomCell: UICollectionViewCell {

    var textLabel: UILabel

    override init(frame: CGRect) {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.backgroundColor = .systemGreen
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .center

        textLabel = label
        super.init(frame: frame)
        label.frame = bounds
        addSubview(label)
    }

    @available(*, unavailable, message: "Use init(_:) instead.")
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class MushroomHunter: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Region, Name>!
    var mushrooms: Region = ["Black Trumpet", "Chanterelle", "Giraffe Spots", "Matsutake", "Oyster", "Shitake"]

    override func loadView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 150, height: 150)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 35, bottom: 5, right: 35)

        let compositionalLayout: UICollectionViewCompositionalLayout = {
            let fraction: CGFloat = 1/3
            let inset: CGFloat = 2.5

            let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemsSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section   = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            return UICollectionViewCompositionalLayout(section: section)
        }()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.bounces = true
        collectionView.register(MushroomCell.self, forCellWithReuseIdentifier: "\(MushroomCell.self)")
        dataSource = UICollectionViewDiffableDataSource<Region, Name>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, name) -> MushroomCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MushroomCell.self)", for: indexPath) as! MushroomCell
            cell.textLabel.text = name
            return cell
        })
        collectionView.dataSource = dataSource
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var snapshot = NSDiffableDataSourceSnapshot<Region, Name>()
        snapshot.appendSections([mushrooms])
        snapshot.appendItems(mushrooms)
        dataSource.apply(snapshot)
    }
}

struct MushroomHunter_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BasicVCView<MushroomHunter>()
                .previewDevice("iPod touch")
                .environment(\.sizeCategory, .accessibilityExtraLarge)
            BasicVCView<MushroomHunter>()
                .previewDevice("iPhone SE")
                .environment(\.colorScheme, .dark)
                .environment(\.sizeCategory, .extraSmall)
        }
    }
}
