//
//  CardView.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

final class CardView: UIView {
    
    private var viewAction: (() -> (Void))?
    private let backView = UIView()
    private var flipView: UIView?
    var delegate: StackContainerView?
    
    //MARK: - Properties
    var dataSource : Player! {
        didSet {
            changeFlipView(type: .front)
        }
    }
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        setupViews()
        
        viewAction = firstTap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Configuration
    private func addSubviews() {
        [backView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }     
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupViews() {
        backView.backgroundColor = .black
        backView.layer.cornerRadius = 24
        backView.clipsToBounds = true
    }
    
    private func setViewConstraints() {
        guard let flipView = flipView else { return }
        [flipView].forEach {
            backView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                flipView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
                flipView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
                flipView.heightAnchor.constraint(equalTo: backView.heightAnchor, constant: -4),
                flipView.widthAnchor.constraint(equalTo: backView.widthAnchor, constant: -4),
//                flipView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 2),
//                flipView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -2),
//                flipView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 2),
//                flipView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -2),
            ])
            
            flipView.layer.cornerRadius = 24
            flipView.clipsToBounds = true
        }
        layoutIfNeeded()
    }
    
    @objc
    func tapAction() {
        viewAction?()
    }
    
    func firstTap() {
        switch dataSource.playerType {
        case .player:
            changeFlipView(type: .civ)
        case .spy:
            changeFlipView(type: .spy)
        }
        
        UIView.transition(with: self, duration: 0.6, options: .transitionFlipFromRight, animations: nil, completion: nil)
        viewAction = secondTap
    }
    
    func secondTap() {
        delegate?.didSwipeCard(on: self)
    }
    
    private func changeFlipView(type: FlipViewType) {
        flipView?.removeFromSuperview()
        switch type {
        case .front:
            let view = FrontCard()
            view.configure(with: dataSource)
            flipView = view
            setViewConstraints()
        case .civ:
            let view = CivilianCard()
            view.configure(with: dataSource, location: delegate?.getLocation() ?? "")
            flipView = view
            setViewConstraints()
        case .spy:
            let view = SpyCard()
            view.configure(with: dataSource)
            flipView = view
            setViewConstraints()
        }
    }
}

enum FlipViewType {
    case front
    case civ
    case spy
}
