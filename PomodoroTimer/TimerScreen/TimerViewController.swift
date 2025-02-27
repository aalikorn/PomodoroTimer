//
//  TimerPresenterViewController.swift
//  PomodoroTimer
//
//  Created by Даша Николаева on 23.02.2025.
//

import UIKit

protocol TimerViewProtocol: AnyObject {
    func pauseButtonTapped()
    func stopButtonTapped()
    func dismissTimer()
    func timerDidUpdate(_ time: String)
    func timerDidSwitchMode(isWorkTime: Bool)
}

class TimerViewController: UIViewController, TimerViewProtocol {
    //MARK: variables
    var presenter: TimerPresenterProtocol!
    
    private let countdownView = UIView()
    private let countdownLabel = UILabel()
    private let modeLabel = UILabel()
    private let pauseButton = UIButton()
    private let stopButton = UIButton()
    
    private let progressLayer = CAShapeLayer()
    
    //MARK: functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTargets()
        presenter.start()
    }
    
    init(presenter: TimerPresenterProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        presenter.attachView(view: self)
    }
    
    @objc func pauseButtonTapped() {
        if !presenter.isPaused() {
            presenter.pause()
            pauseButton.setImage(UIImage(systemName: "play.fill", withConfiguration: ButtonsConstants.largeConfig), for: .normal)
        } else {
            presenter.resume()
            pauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: ButtonsConstants.largeConfig), for: .normal)
        }
    }
    
    @objc func stopButtonTapped() {
        presenter.finish()
    }
    
    func dismissTimer() {
        dismiss(animated: true, completion: nil)
    }
    
    func timerDidUpdate(_ time: String) {
        countdownLabel.text = time
    }
    
    func timerDidSwitchMode(isWorkTime: Bool) {
        modeLabel.text = isWorkTime ? "Focus" : "Break"
        countdownLabel.text = isWorkTime ? presenter.getWorkTime() : presenter.getRestTime()
    }
    
    func setupTargets() {
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }

    
    private func setupUI() {
        view.backgroundColor = .black
        
        modeLabel.textColor = .white
        modeLabel.font = .systemFont(ofSize: 35, weight: .medium)
        modeLabel.textAlignment = .center
        view.addSubview(modeLabel)
        
        countdownView.backgroundColor = .black
        countdownView.layer.cornerRadius = 150
        countdownView.layer.borderColor = UIColor.white.cgColor
        countdownView.layer.borderWidth = 2
        view.addSubview(countdownView)
        
        countdownLabel.textColor = .white
        countdownLabel.font = .systemFont(ofSize: 60, weight: .bold)
        countdownView.addSubview(countdownLabel)
        
        pauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: ButtonsConstants.largeConfig), for: .normal)
        pauseButton.layer.cornerRadius = 14
        pauseButton.layer.borderColor = UIColor.white.cgColor
        pauseButton.layer.borderWidth = 2
        pauseButton.tintColor = Colors.green
        view.addSubview(pauseButton)
        
        stopButton.setImage(UIImage(systemName: "stop.fill", withConfiguration: ButtonsConstants.largeConfig), for: .normal)
        stopButton.layer.cornerRadius = 14
        stopButton.layer.borderColor = UIColor.white.cgColor
        stopButton.layer.borderWidth = 2
        stopButton.tintColor = Colors.red
        view.addSubview(stopButton)
        
        timerDidSwitchMode(isWorkTime: true)
    }
    
    private func setupConstraints() {
        countdownView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countdownView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countdownView.topAnchor.constraint(equalTo: modeLabel.bottomAnchor, constant: 30),
            countdownView.widthAnchor.constraint(equalToConstant: 300),
            countdownView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        modeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            modeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            modeLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countdownLabel.centerXAnchor.constraint(equalTo: countdownView.centerXAnchor),
            countdownLabel.centerYAnchor.constraint(equalTo: countdownView.centerYAnchor)
        ])
        
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pauseButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
            pauseButton.topAnchor.constraint(equalTo: countdownView.bottomAnchor, constant: 50),
            pauseButton.heightAnchor.constraint(equalToConstant: 110),
            pauseButton.widthAnchor.constraint(equalTo: pauseButton.heightAnchor),
            pauseButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
        ])
        
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
            stopButton.topAnchor.constraint(equalTo: countdownView.bottomAnchor, constant: 50),
            stopButton.widthAnchor.constraint(equalTo: stopButton.heightAnchor),
            stopButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            stopButton.heightAnchor.constraint(equalToConstant: 110),
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
