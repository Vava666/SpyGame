//
//  MainView.swift
//  SpyGame
//
//  Created by Artem Vavilov on 18.02.2023.
//

import UIKit

class MainView: UIView {
    
    var buttonAction: ((Int, Int) -> (Void))?
    var showAllert: ((String) -> (Void))?
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.distribution = .fillEqually
        return stack
    }()
    private let title = UILabel()
    private let numberOfPlayersTitle = UILabel()
    private let numberOfPlayers = UITextField()
    private let numberOfSpiesTitle = UILabel()
    private let numberOfSpies = UITextField()
    private let startButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        addSubviews()
        setupConstraints()
        setupViews()
    }
    
    private func addSubviews() {
        [title,
         stack,
         startButton,
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [numberOfPlayersTitle,
         numberOfPlayers,
         numberOfSpiesTitle,
         numberOfSpies,
        ].forEach {
            stack.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            title.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -32),
            
            stack.heightAnchor.constraint(equalToConstant: 256),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 6),
            stack.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -32),
            
            startButton.heightAnchor.constraint(equalToConstant: 64),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            startButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
        ])
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        title.text = "Game of SPIES!"
        title.textAlignment = .center
        title.textColor = .black
        
        numberOfPlayersTitle.text = "How many players?"
        numberOfPlayersTitle.textColor = .black
        numberOfSpiesTitle.text = "How many spies?"
        numberOfSpiesTitle.textColor = .black
        
        
        numberOfPlayers.placeholder = "do not play alone!"
        numberOfPlayers.returnKeyType = .done
        numberOfPlayers.delegate = self
        numberOfPlayers.keyboardType = .numberPad
        numberOfPlayers.textColor = .black
        
        numberOfSpies.placeholder = "how brave are you?"
        numberOfSpies.returnKeyType = .done
        numberOfSpies.delegate = self
        numberOfSpies.keyboardType = .numberPad
        numberOfSpies.textColor = .black
        
        
        startButton.layer.cornerRadius = 24
        startButton.backgroundColor = .link
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        
        startButton.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonDidTapped() {
        if let numPlayers = numberOfPlayers.text, let numSpies = numberOfSpies.text {
            if let players = Int(numPlayers), let spies = Int(numSpies) {
                if players > spies {
                    buttonAction?(players, spies)
                } else {
                    showAllert?("Players must be more than spies.")
                }
            } else {
                showAllert?("Fill placeholders.")
            }
        }
    }
    
    func clearLabels() {
        numberOfPlayers.text = ""
        numberOfSpies.text = ""
    }
}
extension MainView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let number = Int(text) {
            textField.text = "\(number)"
        }
    }
}
