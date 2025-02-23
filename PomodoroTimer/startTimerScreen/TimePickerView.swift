//
//  TimePickerView.swift
//  PomodoroTimer
//
//  Created by Даша Николаева on 23.02.2025.
//

import UIKit

class TimePickerView: UIView {
    var forWork: Bool!
    
    var titleLabel = UILabel()
    var plusButton: UIButton!
    var minusButton: UIButton!
    var timeLabel = UILabel()
    var minLabel = UILabel()
    
    init(forWork: Bool) {
        super.init(frame: .zero)
        self.forWork = forWork
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        backgroundColor = .black
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 14
        
        titleLabel.font = .systemFont(ofSize: 24, weight: .regular)
        if forWork {
            titleLabel.text = "focus session"
        } else {
            titleLabel.text = "break"
        }
        titleLabel.textColor = .white
        addSubview(titleLabel)
        
        timeLabel.font = .systemFont(ofSize: 32, weight: .bold)
        if forWork {
            timeLabel.text = "25"
        } else {
            timeLabel.text = "5"
        }
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        addSubview(timeLabel)
        
        plusButton = UIButton()
        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        plusButton.setTitleColor(.white, for: .normal)
        plusButton.backgroundColor = .black
        plusButton.layer.borderWidth = 2
        plusButton.layer.borderColor = UIColor.white.cgColor
        plusButton.layer.cornerRadius = 8
        addSubview(plusButton)
        
        minusButton = UIButton()
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        minusButton.setTitleColor(.white, for: .normal)
        minusButton.backgroundColor = .black
        minusButton.layer.borderWidth = 2
        minusButton.layer.borderColor = UIColor.white.cgColor
        minusButton.layer.cornerRadius = 8
        addSubview(minusButton)
        
        minLabel.font = .systemFont(ofSize: 20, weight: .light)
        minLabel.text = "min"
        minLabel.textColor = .white
        addSubview(minLabel)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            timeLabel.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minusButton.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -16),
            minusButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            minusButton.heightAnchor.constraint(equalToConstant: 40),
            minusButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 16),
            plusButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            plusButton.heightAnchor.constraint(equalToConstant: 40),
            plusButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            minLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5)
        ])
    }
}
