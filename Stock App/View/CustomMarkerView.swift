//
//  CustomMarkerView.swift
//  Stock App
//
//  Created by Aigerim Abdurakhmanova on 03.08.2022.
//

import UIKit
import Charts

class CustomMarkerView: MarkerView {
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let view: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMarker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpMarker() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        layer.masksToBounds = true
//        layer.cornerRadius = 5
//        layer.cornerCurve = .continuous
        
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.offset.x = -self.frame.size.width / 2.0
        self.offset.y = -150 //chart view height
    }
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        label.text = "\(entry.y) USD"
        layoutIfNeeded()
    }
}
