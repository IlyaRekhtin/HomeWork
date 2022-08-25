//
//  VideoDurationView.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.06.2022.
//

import UIKit
import SnapKit

final class VideoDurationView: UIView {
    
    private var duration: Int = 0 {
        didSet {
            self.time(duration: self.duration)
        }
    }
    
    private let lableForTime: UILabel = {
        var lable = UILabel(frame: .zero)
        lable.font = UIFont.subTextFont
        lable.textColor = .white
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        self.backgroundColor = .clear
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTime(for duration: Int) {
        self.duration = duration
        
    }
    
    private func time(duration: Int) {
        let hour = duration / 3600 == 0 ? "00" : String(duration / 3600)
        let minutes = (duration % 3600) / 60 == 0 ? "00" : String((duration % 3600) / 60)
        let seconds = (duration % 3600) % 60 == 0 ? "00" : String((duration % 3600) % 60)
        self.lableForTime.text =  "▶︎ \(hour):\(minutes):\(seconds)"
    }
    
    private func makeConstraints() {
        self.addSubview(lableForTime)
        lableForTime.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(3)
        }
    }
    
}
