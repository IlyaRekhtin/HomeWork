//
//  HeaderSearchGruopController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 09.03.2022.
//

import UIKit


class HeaderSearchBar: UITableViewHeaderFooterView {
    
    static let reuseID = "headerForSearchBar"
    
    var searchBar: UISearchBar?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        
    }
    
    
}
