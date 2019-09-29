//
//  MySegmentedControl.swift
//  swift-my-segmented-control-sample
//
//  Created by devWill on 2018/07/04.
//  Copyright © 2018年 devWill. All rights reserved.
//

import UIKit

protocol MySegmentControlDelegate: class {
    func tapped(index: Int)
}

class MySegmentedControl: UIView {
    struct DataSource {
        var title: String
        var isNonRegistered: Bool
    }

    private let borderWidth: CGFloat = 0.5
    private let borderColor = UIColor.cyan
    
    private var selectedColor = UIColor.blue
    private var normalColor = UIColor.blue
    private var nonregisteredColor = UIColor.blue

    weak var delegate: MySegmentControlDelegate?
    var dataSource = [DataSource](){
        didSet {
            setButtons()
            reloadButtonsView()
        }
    }

    var selectedButtom = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }
    
    private func setLayout() {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = selectedColor.cgColor
    }
    
    private func setButtons() {
        guard let stackView = self.subviews.first as? UIStackView else {
            fatalError("StackView not set")
        }
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        for index in 0...dataSource.count - 1 {
            let label = UILabel()

            label.tag = index + 10
            label.text = "\(index)"
            label.textAlignment = .center
            label.layer.borderWidth = borderWidth
            label.layer.borderColor = selectedColor.cgColor
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
            label.addGestureRecognizer(tapGesture)
            stackView.addArrangedSubview(label)
        }
    }
    @objc func singleTap(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else {
            return
        }
        let index = tag - 10
        if index == selectedButtom {
            return
        }
        selectedButtom = index
        reloadButtonsView()
        if let delegate = delegate {
            delegate.tapped(index: selectedButtom)
        }
    }
    
    private func reloadButtonsView() {
        guard let stackView = self.subviews.first as? UIStackView else {
            fatalError("StackView not set")
        }
        for index in 0...dataSource.count - 1 {
            guard let label = stackView.arrangedSubviews[index] as? UILabel else {
                return
            }
            if !dataSource.isEmpty{
                label.text = dataSource[index].title
                if dataSource[index].isNonRegistered {
                    setNonRegietered(label: label)
                } else {
                    setNormal(label: label)
                }
            }
        }
        guard let label = stackView.arrangedSubviews[selectedButtom] as? UILabel else {
            return
        }
        setSelected(label: label)
    }
    
    private func setSelected(label: UILabel) {
        label.backgroundColor = selectedColor
        label.textColor = .white
    }
    private func setNormal(label: UILabel) {
        label.backgroundColor = .white
        label.textColor = normalColor
    }
    private func setNonRegietered(label: UILabel) {
        label.backgroundColor = nonregisteredColor
        label.textColor = normalColor
    }
}

extension MySegmentedControl {
    @IBInspectable var selected: UIColor {
        get {
            return self.selectedColor
        }
        set {
            self.selectedColor = newValue
        }
    }
    @IBInspectable var normal: UIColor {
        get {
            return self.normalColor
        }
        set {
            self.normalColor = newValue
        }
    }
    @IBInspectable var nonRegistered: UIColor {
        get {
            return self.nonregisteredColor
        }
        set {
            self.nonregisteredColor = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
}
