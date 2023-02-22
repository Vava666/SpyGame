//
//  FinalView.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

class FinalView: UIView {
    weak var delegate: FinalViewControllerDelegate?
    let timerView = TimerView()
    let spyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setup() {
        addSubviews()
        setupConstraints()
        setupViews()
    }
    
    private func addSubviews() {
        [timerView, spyLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -16),
            timerView.heightAnchor.constraint(equalTo: widthAnchor),
            timerView.widthAnchor.constraint(equalTo: widthAnchor),
            
            spyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            spyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            spyLabel.heightAnchor.constraint(equalTo: widthAnchor),
            spyLabel.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    private func setupViews() {
        backgroundColor = .black
        timerView.layer.cornerRadius = 100
        
        spyLabel.textColor = .red
        spyLabel.textAlignment = .center
        spyLabel.font = UIFont.systemFont(ofSize: 24)
        spyLabel.isHidden = true
    }
    
    func showTheSpy(name: String) {
        spyLabel.isHidden = false
        spyLabel.text = name
    }
    
    func configure(with timer: Int) {
        timerView.timerCallBack = { [weak self] in
            let name = self?.delegate?.getSpyName()
            self?.showTheSpy(name: name ?? "")
        }
        timerView.runTimer(with: 1)
    }
}
