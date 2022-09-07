//
//  VideoDurationView.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.06.2022.
//

import UIKit
import SnapKit

final class VideoDurationView: UIView {
    
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
    
    init (_ duration: Int) {
        super.init(frame: .zero)
        self.lableForTime.text = self.timeFormat(duration: duration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTime(_ duration: Int){
        self.lableForTime.text = self.timeFormat(duration: duration)
    }
    
    private func timeFormat(duration: Int) -> String {
        let hour = duration / 3600
        let hourStr = hour < 10 ? "0\(hour)" : "\(hour)"
        let minutes = (duration % 3600) / 60
        let minutesStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let seconds = (duration % 3600) % 60
        let secondStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        return  "▶︎ \(hourStr):\(minutesStr):\(secondStr)"
    }
    
    private func makeConstraints() {
        self.addSubview(lableForTime)
        lableForTime.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(3)
        }
    }
    
}
