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
    private let backgroundLayer = CAShapeLayer()
    
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
            pauseAnimation()
            pauseButton.setImage(UIImage(systemName: "play.fill", withConfiguration: ButtonsConstants.largeConfig), for: .normal)
        } else {
            presenter.resume()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.resumeAnimation()
            }
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
        countdownLabel.text = isWorkTime ? presenter.getWorkTimeString() : presenter.getRestTimeString()
        let duration = isWorkTime ? presenter.getWorkTime() : presenter.getRestTime()
        startProgressAnimation(duration: duration)
    }
    
    func setupTargets() {
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }
    
    private func setupProgressCircle() {
        let path = UIBezierPath(arcCenter: CGPoint(x: 150, y: 150),
                                radius: 148,
                                startAngle: 3 * .pi / 2,
                                endAngle: 7 * .pi / 2,
                                clockwise: true)
        
        backgroundLayer.path = path.cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = 8
        backgroundLayer.lineCap = .round
        countdownView.layer.addSublayer(backgroundLayer)
        
        progressLayer.path = path.cgPath
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 8
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 1

        
        countdownView.layer.addSublayer(progressLayer)
    }
    
    private func startProgressAnimation(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 0
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        progressLayer.add(animation, forKey: "progressAnimation")
    }
    
    private func pauseAnimation() {
        let pausedTime = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
        progressLayer.speed = 0.0
        progressLayer.timeOffset = pausedTime
    }
    
    private func resumeAnimation() {
        let pausedTime = progressLayer.timeOffset
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0
        let timeSincePause = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.beginTime = timeSincePause
    }

    
    private func setupUI() {
        view.backgroundColor = .black
        
        modeLabel.textColor = .white
        modeLabel.font = .systemFont(ofSize: 35, weight: .medium)
        modeLabel.textAlignment = .center
        view.addSubview(modeLabel)
        
        countdownView.backgroundColor = .black
        countdownView.layer.cornerRadius = 150
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
        
        setupProgressCircle()
        
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
