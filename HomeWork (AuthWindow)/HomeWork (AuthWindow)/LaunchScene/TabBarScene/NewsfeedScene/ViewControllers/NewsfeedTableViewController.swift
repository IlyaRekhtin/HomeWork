//
//  NewsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//


import UIKit
import RealmSwift

class NewsfeedTableViewController: UITableViewController {
    enum CellType: Int {
        case header = 0, text, link, photos, video, audio, docs, poll, footer
    }
    
    private let service = NewsfeedService()
    private var varibleSection = [CellType]()
    
    var news = DataManager.data.news
    var users = DataManager.data.users
    var groups = DataManager.data.groups
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        tableView.separatorStyle = .none
        tableView.register(HeaderNewsCell.self, forCellReuseIdentifier: HeaderNewsCell.reuseID)
        tableView.register(FooterNewsCell.self, forCellReuseIdentifier: FooterNewsCell.reuseID)
        tableView.register(TextNewsCell.self, forCellReuseIdentifier: TextNewsCell.reuseID)
        tableView.register(LinkNewsCell.self, forCellReuseIdentifier: LinkNewsCell.reuseID)
        tableView.register(PhotoNewsCell.self, forCellReuseIdentifier: PhotoNewsCell.reuseID)
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseID)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_ :)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        
    }
    
    // MARK: - Table view data source
    
    
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
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderNewsCell.reuseID, for: indexPath) as! HeaderNewsCell
        let textCell = tableView.dequeueReusableCell(withIdentifier: TextNewsCell.reuseID, for: indexPath) as! TextNewsCell
        let linkCell = tableView.dequeueReusableCell(withIdentifier: LinkNewsCell.reuseID, for: indexPath) as! LinkNewsCell
        let photosCell = tableView.dequeueReusableCell(withIdentifier: PhotoNewsCell.reuseID, for: indexPath) as! PhotoNewsCell
        let footerCell = tableView.dequeueReusableCell(withIdentifier: FooterNewsCell.reuseID, for: indexPath) as! FooterNewsCell
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as! Cell
        
        let currentNews = news[indexPath.section]
        let photosForPhoto = (currentNews.photos?.items)
        let attachments = currentNews.attachments
        let text = currentNews.text
        let photosForPost = sortAttachmentForPhotos(attachments?.filter{$0.type == .photo})
        let links = sortAttachmentForLinks(attachments?.filter{$0.type == .link})
        
        self.varibleSection = sectionConstruct(for: currentNews)
        let cellType = varibleSection[indexPath.row]
        
        switch cellType {
        case .header:
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
            textCell.configCell(for: text!)
            return textCell
        case .link:
            linkCell.configCell(for: links.first!)
            return linkCell
        case .photos:
            if currentNews.type == .post {
                photosCell.configCell(for: photosForPost)
            } else {
                photosCell.configCell(for: Array(photosForPhoto!))
            }
            return photosCell
        case .video:
            return cell
        case .audio:
            return cell
        case .docs:
            return cell
        case .poll:
            return cell
        case .footer:
            footerCell.configCell(for: currentNews)
            return footerCell
        }
    }
}

//MARK: - private
private extension NewsfeedTableViewController {
    
    func sectionConstruct(for news: News) -> [CellType] {
        var section = [CellType]()
        section.append(.header)
        switch news.type {
        case .photo:
            if news.text != nil, news.text != "" {
                section.append(.text)
            }
            if news.photos != nil {
                section.append(.photos)
            }
        case .post:
            if let attachments = news.attachments {
                let link = attachments.filter{$0.type == .link}
                let photos = attachments.filter{$0.type == .photo}
                let audio = attachments.filter{$0.type == .audio}
                let video = attachments.filter{$0.type == .video}
                let docs = attachments.filter{$0.type == .doc}
                let poll = attachments.filter{$0.type == .poll}
                
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
    
    func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    
}
