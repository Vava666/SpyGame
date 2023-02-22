//
//  TimerView.swift
//  SpyGame
//
//  Created by Artem Vavilov on 21.02.2023.
//

import UIKit

final class TimerView: UIView {
    var timerCallBack: (() -> (Void))?
    private let view = UIView()
    private let label = UILabel()
    private var timer: Timer?
    private var runCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        [view, label].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.heightAnchor.constraint(equalTo: view.widthAnchor),
            view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalTo: view.widthAnchor),
            label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
        ])
        
        view.backgroundColor = .orange
        view.clipsToBounds = true
        view.layer.cornerRadius = UIScreen.main.bounds.width / 4
        
        label.font = .systemFont(ofSize: 52, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        
        showView(show: false)
    }
    
    private func showView(show: Bool) {
        view.isHidden = !show
        label.isHidden = !show
    }
    
    private func setLabelText(text: String) {
        label.text = text
    }
    
    func runTimer(with time: Int) {
        runCount = time
        showView(show: true)
        setLabelText(text: "\(runCount)")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        showView(show: false)
    }
    
    @objc
    private func fireTimer() {
        runCount -= 1
        setLabelText(text: "\(runCount)")
        if runCount == 0 {
            stopTimer()
            timerCallBack?()
        }
    }
}
