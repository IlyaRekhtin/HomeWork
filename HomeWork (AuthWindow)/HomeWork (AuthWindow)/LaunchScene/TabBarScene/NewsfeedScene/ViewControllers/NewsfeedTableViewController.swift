
//  NewsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//

import UIKit
import RealmSwift

protocol PhotoNewsCellDelegate {
    func cellCollectionItemTapped(cell: PhotoNewsCell)
}

protocol LinkNewsCellDelegate {
    func linkTaped(cell: LinkNewsCell)
}

class NewsfeedTableViewController: UITableViewController {
    
    enum CellType: Int {
        case header = 0, text, link, photos, video, audio, docs, poll, footer
    }
    
    private var pushTransition = PushImageViewTransitionAnimation()
    private var popTransition = PopImageViewTransitionAnimation()
    private let service = NewsfeedService()
    private var varibleSection = [CellType]()
    
    var news = DataManager.data.news
    var users = DataManager.data.users
    var groups = DataManager.data.groups
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        configTableView()
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
        tableView.separatorStyle = .none
        tableView.register(HeaderNewsCell.self, forCellReuseIdentifier: HeaderNewsCell.reuseID)
        tableView.register(FooterNewsCell.self, forCellReuseIdentifier: FooterNewsCell.reuseID)
        tableView.register(TextNewsCell.self, forCellReuseIdentifier: TextNewsCell.reuseID)
        tableView.register(LinkNewsCell.self, forCellReuseIdentifier: LinkNewsCell.reuseID)
        tableView.register(PhotoNewsCell.self, forCellReuseIdentifier: PhotoNewsCell.reuseID)
        tableView.register(DocViewCell.self, forCellReuseIdentifier: DocViewCell.reuseID)
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.reuseID)
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseID)
    }
    
}

//MARK: - tableview data source
extension NewsfeedTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.varibleSection = sectionConstruct(for: news[section])
        return self.varibleSection.count
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let separateView: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 5))
            view.backgroundColor = .opaqueSeparator
            return view
        }()
        return separateView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
                if let profile = users.filter({$0.id == currentNews.sourceID}).first {
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
            return videoCell
        case .audio:
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as! Cell
            return cell
        case .docs:
            let docsCell = tableView.dequeueReusableCell(withIdentifier: DocViewCell.reuseID, for: indexPath) as! DocViewCell
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
        var photos = [Photo]()
        attachments.forEach { attachment in
            guard let photo = attachment.photo else {return}
            photos.append(photo)
        }
        return photos
    }
    
    func sortAttachmentForLinks(_ attachments: [Attachment]?) -> [Link] {
        guard let attachments = attachments else {
            return []
        }
        var links = [Link]()
        attachments.forEach { attachment in
            guard let link = attachment.link else {return}
            links.append(link)
        }
        return links
    }
    
    func sortAttachmentForDocs(_ attachments: [Attachment]?) -> [Doc] {
        guard let attachments = attachments else {
            return []
        }
        var docs = [Doc]()
        attachments.forEach { attachment in
            guard let doc = attachment.doc else {return}
            docs.append(doc)
        }
        return docs
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
extension NewsfeedTableViewController: PhotoNewsCellDelegate {
    func cellCollectionItemTapped(cell: PhotoNewsCell) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "imageShowController") as? ImagePresentViewController else {return}
        guard let index = cell.photoNewsfeedCollectionView.indexPathsForSelectedItems?.first else {return}

        vc.currentIndexPuthFoto = index.row

        DispatchQueue.main.async {
            vc.firstImageView.kf.setImage(with: cell.currentSizePhotos[index.row])
        }
        vc.currentSizePhotos = cell.currentSizePhotos
        vc.firstImageView.kf.indicatorType = .activity
        vc.photoAlbum = cell.photos
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

//MARK: - LinkNewsCellDelegate
extension NewsfeedTableViewController: LinkNewsCellDelegate {
    func linkTaped(cell: LinkNewsCell) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "WebViewController") as? WebViewController else {return}
        vc.urlString = cell.linkURL
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
