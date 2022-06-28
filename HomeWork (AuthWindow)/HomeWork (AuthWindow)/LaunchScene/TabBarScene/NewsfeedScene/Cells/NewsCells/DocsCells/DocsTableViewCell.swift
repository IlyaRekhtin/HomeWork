//
//  DocsNewsCell.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 02.06.2022.
//

import UIKit
import SnapKit

final class DocsTableViewCell: UITableViewCell {
    
    static var reuseID = "docsNewsCell"
    
   
    private var docs = [Doc]()
    
    var tableView: UITableView!
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        createDataSourse()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(for docs: [Doc]) {
        self.docs = docs
        reloadData()
    }
    
    
}

//MARK: - make constraints
private extension DocsTableViewCell {
  func  makeConstraints() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(5)
        }
    }
}

private extension DocsTableViewCell {
    //    //MARK: - Setup collectionView
    func setupCollectionView() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 100), collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(DocViewCell.self, forCellWithReuseIdentifier: DocViewCell.reuseID)
    }
    
    //    //MARK: - create composition layout
    func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, collectionEnvironment) -> NSCollectionLayoutSection? in
                return self.createLayout()
        }
        return layout
    }
    
    func createLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension:.fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    //    //MARK: - create Data Source
    func createDataSourse() {
        dataSource = UICollectionViewDiffableDataSource<Int, Doc>(collectionView: self.collectionView,
                                                                    cellProvider: { (collectionView, indexPuth, model) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocCollectionViewCell.reuseID, for: indexPuth) as! DocCollectionViewCell
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
}

