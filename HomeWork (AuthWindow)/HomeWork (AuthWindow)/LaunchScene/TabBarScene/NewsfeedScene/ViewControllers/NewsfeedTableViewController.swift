
//  NewsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//

import UIKit
import SnapKit

protocol NewsfeedItemTapped {
    func newsfeedItemTapped(cell: UITableViewCell)
}

enum CellType: Int {
    case header = 0, text, link, photos, video, audio, docs, poll, footer
}

class NewsfeedTableViewController: UIViewController {
    
    private let service = NewsfeedAdapter()
    private let sectionFactory = SectionFactory()
    private let factory = NewsfeedFactory()
    private var pushTransition = PushImageViewTransitionAnimation()
    private var popTransition = PopImageViewTransitionAnimation()
    
    private var newsfeedItems = NewsfeedItems()
    private var newsfeedStartDate: String = ""
    private var tableView: UITableView!
    private var varibleSection = [CellType]()
    private var isLoading = false
    
    override func loadView() {
        super.loadView()
        loadNewsfeed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        configTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
    }
    
    
    private func loadNewsfeed(){
        service.fetchData { [weak self] newsfeed in
            guard let self = self else { return }
            self.newsfeedItems = self.factory.constructNewsItem(from: newsfeed)!
            self.tableView.reloadData()
        }
    }
    
    private func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configTableView() {
        tableView = UITableView(frame: self.view.bounds)
        
        tableView.separatorStyle = .none
        tableView.register(HeaderNewsCell.self, forCellReuseIdentifier: HeaderNewsCell.reuseID)
        tableView.register(FooterNewsCell.self, forCellReuseIdentifier: FooterNewsCell.reuseID)
        tableView.register(TextNewsCell.self, forCellReuseIdentifier: TextNewsCell.reuseID)
        tableView.register(LinkNewsCell.self, forCellReuseIdentifier: LinkNewsCell.reuseID)
        tableView.register(PhotoNewsCell.self, forCellReuseIdentifier: PhotoNewsCell.reuseID)
        tableView.register(DocTableViewCell.self, forCellReuseIdentifier: DocTableViewCell.reuseID)
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.reuseID)
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseID)
        self.view.addSubview(self.tableView)
        
        configRefreshControl()
        
    }
    
    private func configRefreshControl() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.tintColor = .lightGray
        self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshNewsfeed), for: .valueChanged)
    }
    
    @objc private func refreshNewsfeed() {
        guard let date = self.newsfeedItems.newsItems.first?.date else {return}
        service.fetchData(from: String(date)){ [weak self] newsfeed in
            guard let self = self else { return }
            guard var newItems = self.factory.constructNewsItem(from: newsfeed)?.newsItems else {return}
            newItems.remove(at: 0)
            if newItems.count > 0 {
                self.newsfeedItems.newsItems.insert(contentsOf: newItems, at: 0)
                let indexSet = IndexSet(integersIn: 0 ..< newItems.count)
                self.tableView.insertSections(indexSet, with: .automatic)
                self.newsfeedStartDate = String(newItems.first?.date ?? 0)
            }
        }
    }
}

//MARK: - tableview data source
extension NewsfeedTableViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsfeedItems.newsItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.varibleSection = self.sectionFactory.sectionConstruct(for: newsfeedItems.newsItems[section])
        return self.varibleSection.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let separateView: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 5))
            view.backgroundColor = .opaqueSeparator
            return view
        }()
        return separateView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// получаем актуальную новость и инициализируем ее содержимое
        let currentNews = newsfeedItems.newsItems[indexPath.section]
        self.varibleSection = self.sectionFactory.sectionConstruct(for: currentNews)
        let cellType = varibleSection[indexPath.row]
        
        /// для разных типов ячеек в секции создаем свою
        switch cellType {
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderNewsCell.reuseID, for: indexPath) as! HeaderNewsCell
            if let header = currentNews.header {
                headerCell.configCellForFriend(header)
            }
            return headerCell
        case .text:
            let textCell = tableView.dequeueReusableCell(withIdentifier: TextNewsCell.reuseID, for: indexPath) as! TextNewsCell
            textCell.configCell(for: currentNews.text)
            return textCell
        case .link:
            let linkCell = tableView.dequeueReusableCell(withIdentifier: LinkNewsCell.reuseID, for: indexPath) as! LinkNewsCell
            linkCell.delegate = self
            if let linkViewModel = currentNews.link {
                linkCell.configCell(for: linkViewModel)
            }
            return linkCell
        case .photos:
            let photosCell = tableView.dequeueReusableCell(withIdentifier: PhotoNewsCell.reuseID, for: indexPath) as! PhotoNewsCell
            photosCell.delegate = self
            if let photoViewModels = currentNews.photos {
                photosCell.configCell(for: photoViewModels)
            }
            return photosCell
        case .video:
            let videoCell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.reuseID, for: indexPath) as! VideoTableViewCell
            if let videoViewModels = currentNews.videos {
                videoCell.configCell(for: videoViewModels)
            }
            return videoCell
        case .audio:
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as! Cell
            return cell
        case .docs:
            let docsCell = tableView.dequeueReusableCell(withIdentifier: DocTableViewCell.reuseID, for: indexPath) as! DocTableViewCell
            if let docViewModels = currentNews.docs {
                docsCell.configCell(for: docViewModels)
            }
            return docsCell
        case .poll:
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as! Cell
            return cell
        case .footer:
            let footerCell = tableView.dequeueReusableCell(withIdentifier: FooterNewsCell.reuseID, for: indexPath) as! FooterNewsCell
            footerCell.configCell(for: currentNews)
            return footerCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentNews = newsfeedItems.newsItems[indexPath.section]
        self.varibleSection = self.sectionFactory.sectionConstruct(for: currentNews)
        let cellType = varibleSection[indexPath.row]
        switch cellType {
        case .photos:
            return self.tableView.frame.width
        case .docs:
            guard let docsCount = currentNews.docs?.count else { return 0 }
            return CGFloat(docsCount * 60)
        default:
            return UITableView.automaticDimension
        }
    }
}

//MARK: TransitionDelegate
extension NewsfeedTableViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPathCell = self.tableView.indexPathsForVisibleRows,
              let selectedCell = self.tableView.cellForRow(at: selectedIndexPathCell.first!) as? PhotoNewsCell,
              let selectedCellSuperview = selectedCell.superview else {return nil}
        pushTransition.imageInitFrame = selectedCellSuperview.convert(selectedCell.layer.frame, to: nil)
        pushTransition.imageInitFrame = selectedCell.layer.frame
        pushTransition.imageInitFrame = CGRect(
            x: pushTransition.imageInitFrame.origin.x ,
            y: pushTransition.imageInitFrame.origin.y + 50,
            width: pushTransition.imageInitFrame.size.width,
            height: pushTransition.imageInitFrame.size.height + 70
        )
        return pushTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //TODO возвращение в ячейку коллекции
        return popTransition
    }
}

//MARK: - NewsfeedItemTapped
extension NewsfeedTableViewController: NewsfeedItemTapped {
    
    func newsfeedItemTapped(cell: UITableViewCell) {
        if let cell = cell as? PhotoNewsCell {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "imageShowController") as? ImagePresentViewController,
                  let index = cell.photoNewsfeedCollectionView.indexPathsForSelectedItems?.first
            else {return}
            vc.currentIndexPuthFoto = index.row
            let urlStr = cell.photoViewModels[index.row].photo
            guard let url = URL(string: urlStr) else {return}
            vc.firstImageView.kf.setImage(with: url)
            
            vc.firstImageView.kf.indicatorType = .activity
            vc.photoAlbum = cell.photoViewModels
            vc.transitioningDelegate = self
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } else if let cell = cell as? LinkNewsCell {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "WebViewController") as? WebViewController else {return}
            vc.urlString = cell.linkURL
            vc.transitioningDelegate = self
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
//MARK: - UITableViewDataSourcePrefetching
extension NewsfeedTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else {
            return
        }
        if maxSection > newsfeedItems.newsItems.count - 3,
           !isLoading {
            isLoading.toggle()
            service.fetchNewsfeed(with: self.newsfeedItems.nextForm) { [weak self] newsfeed in
                guard let self = self else { return }
                guard let newItems = self.factory.constructNewsItem(from: newsfeed)?.newsItems else {return}
                let indexSet = IndexSet(integersIn: self.newsfeedItems.newsItems.count ..< self.newsfeedItems.newsItems.count + newItems.count)
                self.newsfeedItems.newsItems.append(contentsOf: newItems)
                self.tableView.insertSections(indexSet, with: .automatic)
                self.newsfeedItems.nextForm = newsfeed.nextFrom ?? ""
                self.isLoading.toggle()
            }
        }
    }
}
