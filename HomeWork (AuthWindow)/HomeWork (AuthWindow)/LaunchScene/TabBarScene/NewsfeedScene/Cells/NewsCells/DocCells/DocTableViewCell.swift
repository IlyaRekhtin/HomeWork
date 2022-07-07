//
//  DocTableViewCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class DocTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    static let reuseID = "docTableViewCell"
    
    var docs = [Doc](){
        didSet {
            self.reloadData()
        }
    }
    
    var docsCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Doc>!
    private let layout: NSCollectionLayoutSection = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension:.fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }()
    var delegate: NewsfeedItemTapped?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        self.docsCollectionView.delegate = self
        createDataSourse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for docs: [Doc]) {
        self.docs = docs
        setConstraints()
    }
}
//MARK: - CollectionView
 extension DocTableViewCell {
    //    //MARK: - Setup collectionView
    func setupCollectionView() {
        docsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionLayout())
        docsCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        docsCollectionView.isScrollEnabled = false
        docsCollectionView.showsHorizontalScrollIndicator = false
        docsCollectionView.showsVerticalScrollIndicator = false
        docsCollectionView.delegate = self
        docsCollectionView.register(DocViewCell.self, forCellWithReuseIdentifier: DocViewCell.reuseID)
    }
    
    //    //MARK: - create composition layout
    func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
                return self.layout
        }
        return layout
    }
    //    //MARK: - create Data Source
    func createDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<Int, Doc>(collectionView: self.docsCollectionView,
                                                                    cellProvider: { (collectionView, indexPuth, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocViewCell.reuseID, for: indexPuth) as! DocViewCell
            cell.configCell(for: self.docs[indexPuth.row])
            return cell
        })
    }
    
    func reloadData(){
        var snapShot = NSDiffableDataSourceSnapshot<Int, Doc>()
        snapShot.appendSections([1])
        snapShot.appendItems(docs)
        dataSource.apply(snapShot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.newsfeedItemTapped(cell: self)
        
    }
}
//MARK: - make constraints
private extension DocTableViewCell {
    func setConstraints() {
        self.contentView.addSubview(docsCollectionView)
        docsCollectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

