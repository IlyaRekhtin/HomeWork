
//  NewsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//

import UIKit

protocol NewsfeedItemTapped {
    func newsfeedItemTapped(cell: UITableViewCell)
}

class NewsfeedTableViewController: UIViewController {
    
    enum CellType: Int {
        case header = 0, text, link, photos, video, audio, docs, poll, footer
    }
    
    private var news = [News]()
    private var profiles = [Profile]()
    private var groups = [Group]()
    private let service = NewsfeedService()
    private var tableView: UITableView!
    private var newsfeedStartDate: String!
    private var newsfeedNewxtFrom: String = ""
    private var pushTransition = PushImageViewTransitionAnimation()
    private var popTransition = PopImageViewTransitionAnimation()
    private var varibleSection = [CellType]()
    private var isLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        configTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        loadNewsfeed()
    }
    
    
    private func loadNewsfeed(){
        service.getURL()
            .then(on: .global(), service.fetchData(_:))
            .then(on: .global(), service.parsedData(_:))
            .done(on: .main) { [weak self] newsfeed in
                guard let self = self else { return }
                self.news = newsfeed.items
                self.profiles = newsfeed.profiles
                self.groups = newsfeed.groups
                self.newsfeedNewxtFrom = newsfeed.nextFrom ?? ""
                self.newsfeedStartDate = String(newsfeed.items.first?.date ?? 0)
                self.tableView.reloadData()
            }.catch { error in
                print(error.localizedDescription)
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
        configRefreshControl()
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
    }
    
    private func configRefreshControl() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.tintColor = .lightGray
        self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshNewsfeed), for: .valueChanged)
    }
    
    @objc private func refreshNewsfeed() {
        guard let date = self.newsfeedStartDate else {return}
        service.getURL(from: date)
            .then(on: .global(), service.fetchData(_:))
            .then(on: .global(), service.parsedData(_:)).done(on: .main) { [weak self] newsfeed in
                guard let self = self else { return }
                var newItems = newsfeed.items
                newItems.remove(at: 0)
                if newItems.count > 0 {
                    self.news.insert(contentsOf: newItems, at: 0)
                    let indexSet = IndexSet(integersIn: 0 ..< newItems.count)
                    self.tableView.insertSections(indexSet, with: .automatic)
                    self.newsfeedStartDate = String(newItems.first?.date ?? 0)
                }
            }.ensure {
                self.tableView.refreshControl?.endRefreshing()
            }.catch { error in
                print(error.localizedDescription)
            }
    }
}

//MARK: - tableview data source
extension NewsfeedTableViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.varibleSection = sectionConstruct(for: news[section])
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
        
        let currentNews = news[indexPath.section]
        let attachments = currentNews.attachments
        self.varibleSection = sectionConstruct(for: currentNews)
        let cellType = varibleSection[indexPath.row]
        
        switch cellType {
        case .header:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderNewsCell.reuseID, for: indexPath) as! HeaderNewsCell
            if currentNews.sourceID < 0 {
                if let group = groups.filter({-$0.id == currentNews.sourceID}).first {
                    headerCell.configCellForGroup(group, for: currentNews)
                }
            } else {
                if let profile = profiles.filter({$0.id == currentNews.sourceID}).first {
                    headerCell.configCellForFriend(profile, for: currentNews)
                }
            }
            return headerCell
        case .text:
            let textCell = tableView.dequeueReusableCell(withIdentifier: TextNewsCell.reuseID, for: indexPath) as! TextNewsCell
            
            if let text = currentNews.text {
                textCell.configCell(for: text)
            }
            return textCell
        case .link:
            let linkCell = tableView.dequeueReusableCell(withIdentifier: LinkNewsCell.reuseID, for: indexPath) as! LinkNewsCell
            
            let links = sortAttachmentForLinks(attachments?.filter{$0.type == .link})
            linkCell.delegate = self
            linkCell.configCell(for: links.first!)
            return linkCell
        case .photos:
            let photosCell = tableView.dequeueReusableCell(withIdentifier: PhotoNewsCell.reuseID, for: indexPath) as! PhotoNewsCell
            photosCell.delegate = self
            
            if currentNews.type == .post {
                let photosItemForPostType = sortAttachmentForPhotos(attachments?.filter{$0.type == .photo})
                photosCell.configCell(for: photosItemForPostType)
            } else {
                if let photosItemForPhotoType = (currentNews.photos?.items) { // убираем оционал
                    photosCell.configCell(for: Array(photosItemForPhotoType))
                }
            }
            return photosCell
        case .video:
            let videoCell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.reuseID, for: indexPath) as! VideoTableViewCell
            let videos = sortAttachmentForVideo(attachments?.filter{$0.type == .video})
            videoCell.configCell(for: videos)
            return videoCell
        case .audio:
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as! Cell
            return cell
        case .docs:
            let docsCell = tableView.dequeueReusableCell(withIdentifier: DocTableViewCell.reuseID, for: indexPath) as! DocTableViewCell
            let docs = sortAttachmentForDocs(attachments?.filter{$0.type == .doc})
            docsCell.configCell(for: docs)
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
        let currentNews = news[indexPath.section]
        let attachments = currentNews.attachments
        self.varibleSection = sectionConstruct(for: currentNews)
        let cellType = varibleSection[indexPath.row]
        switch cellType {
        case .header:
            return UITableView.automaticDimension
        case .text:
            return UITableView.automaticDimension
        case .link:
            return UITableView.automaticDimension
        case .photos:
            let photosItemForPostType = sortAttachmentForPhotos(attachments?.filter{$0.type == .photo})
            switch photosItemForPostType.count {
            case 1:
                if let image = photosItemForPostType.last {
                    let width = self.view.frame.width
                    let ratio = Photo.ratio(for: image)
                    print(ratio)
                    let itemHight = width * ratio
                    print(itemHight)
                   return itemHight
                } else {
                    return self.view.frame.width
                }
            default:
                return self.view.frame.width
            }
        case .video:
            return self.view.frame.width
        case .audio:
            return UITableView.automaticDimension
        case .docs:
            guard let docsCount = attachments?.filter({$0.type == .doc}).count else { return 0 }
            return CGFloat(docsCount * 60)
        case .poll:
            return UITableView.automaticDimension
        case .footer:
            return UITableView.automaticDimension
        }
    }
}
//MARK: - private helpers methods
private extension NewsfeedTableViewController {
    ///  Определяем количество и тип строк исходя из содержимого News
    /// - Parameter news: cвойство с типом News
    /// - Returns: массив типов ячеек в соответствии с перечислением
    func sectionConstruct(for news: News) -> [CellType] {
        
        //возврощвемый массив
        var section = [CellType]()
        // первая строка всегда hendler(аватар и название источника новости)
        section.append(.header)
        // проверяем тип новости
        switch news.type {
        case .photo:
            // в новости есть текст?
            if news.text != nil, news.text != "" {
                section.append(.text) // добавляем строку если да
            }
            // в новости есть фотографии
            if news.photos != nil {
                section.append(.photos)// добавляем строку если да
            }
        case .post:
            // проверяем что массив с вложениями не пуст
            if let attachments = news.attachments {
                // фильтруем в соответствии с каждым типом вложения
                let link = attachments.filter{$0.type == .link}
                let photos = attachments.filter{$0.type == .photo}
                let audio = attachments.filter{$0.type == .audio}
                let video = attachments.filter{$0.type == .video}
                let docs = attachments.filter{$0.type == .doc}
                let poll = attachments.filter{$0.type == .poll}
                
                // в наличии значит добавляем
                if news.text != nil, news.text != "" {
                    section.append(.text)
                }
                if link.count != 0 {
                    section.append(.link)
                }
                if photos.count != 0 {
                    section.append(.photos)
                }
                if video.count != 0 {
                    section.append(.video)
                }
                if audio.count != 0 {
                    section.append(.audio)
                }
                if docs.count != 0 {
                    section.append(.docs)
                }
                if poll.count != 0 {
                    section.append(.poll)
                }
                section.append(.footer)
            }
        case .none:
            section.append(.footer)
        }
        return section
    }
    
    
    
    
    func sortAttachmentForPhotos(_ attachments: [Attachment]?) -> [Photo] {
        guard let attachments = attachments else {
            return []
        }
        var items = [Photo]()
        attachments.forEach { attachment in
            guard let photo = attachment.photo else {return}
            items.append(photo)
        }
        return items
    }
    
    func sortAttachmentForLinks(_ attachments: [Attachment]?) -> [Link] {
        guard let attachments = attachments else {
            return []
        }
        var items = [Link]()
        attachments.forEach { attachment in
            guard let link = attachment.link else {return}
            items.append(link)
        }
        return items
    }
    
    func sortAttachmentForDocs(_ attachments: [Attachment]?) -> [Doc] {
        guard let attachments = attachments else {
            return []
        }
        var items = [Doc]()
        attachments.forEach { attachment in
            guard let doc = attachment.doc else {return}
            items.append(doc)
        }
        return items
    }
    
    func sortAttachmentForVideo(_ attachments: [Attachment]?) -> [Video] {
        guard let attachments = attachments else {
            return []
        }
        var items = [Video]()
        attachments.forEach { attachment in
            guard let video = attachment.video else {return}
            items.append(video)
        }
        return items
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

//MARK: - PhotoNewsCellDelegate
extension NewsfeedTableViewController: NewsfeedItemTapped {
    
    func newsfeedItemTapped(cell: UITableViewCell) {
        if let cell = cell as? PhotoNewsCell {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "imageShowController") as? ImagePresentViewController,
                  let index = cell.photoNewsfeedCollectionView.indexPathsForSelectedItems?.first
            else {return}
            vc.currentIndexPuthFoto = index.row
            let urlStr = Photo.max(in: Array(cell.photos[index.row].sizes))
            guard let url = URL(string: urlStr) else {return}
            vc.firstImageView.kf.setImage(with: url)
            
            vc.firstImageView.kf.indicatorType = .activity
            vc.photoAlbum = cell.photos
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

extension NewsfeedTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else {
            return
        }
        
        if maxSection > news.count - 3,
           !isLoading {
            isLoading.toggle()
            
            service.getURL(with: self.newsfeedNewxtFrom)
                .then(on: .global(), service.fetchData(_:))
                .then(on: .global(), service.parsedData(_:))
                .get{ [weak self] newsfeed in
                    self?.newsfeedNewxtFrom = newsfeed.nextFrom ?? ""
                }
                .done(on: DispatchQueue.main) { [weak self] newsfeed in
                    guard let self = self else { return }
                    let indexSet = IndexSet(integersIn: self.news.count ..< self.news.count + newsfeed.items.count)
                    self.news.append(contentsOf: newsfeed.items)
                    self.tableView.insertSections(indexSet, with: .automatic)
                    self.newsfeedNewxtFrom = newsfeed.nextFrom ?? ""
                }.ensure {
                    self.isLoading = false
                }.catch { error in
                    print(error)
                }
        }
    }
}
