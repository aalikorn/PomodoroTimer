//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Даша Николаева on 23.02.2025.
//

import UIKit

protocol startTimerViewProtocol: AnyObject {
    func startButtonTapped()
    func plusWorkTimeButtonTapped()
    func plusRestTimeButtonTapped()
    func minusWorkTimeButtonTapped()
    func minusRestTimeButtonTapped()
    func presentTimer(presenter: TimerPresenterProtocol)
    func configurePresenter()
}

class StartTimerViewController: UIViewController, startTimerViewProtocol {
    
    //MARK: variables
    var presenter: StartTimerPresenterProtocol!
    
    private let workTimePickerView = TimePickerView(forWork: true)
    private let restTimePickerView = TimePickerView(forWork: false)
    private let startButton = UIButton()
    
    //MARK: functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePresenter()
        setupUI()
        setupConstraints()
        setupTargets()
    }
    
    func configurePresenter() {
        let presenter = StartTimerPresenter()
        presenter.view = self
        self.presenter = presenter
    }
    
    private func setupTargets() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        workTimePickerView.plusButton.addTarget(self, action: #selector(plusWorkTimeButtonTapped), for: .touchUpInside)
        workTimePickerView.minusButton.addTarget(self, action: #selector(minusWorkTimeButtonTapped), for: .touchUpInside)
        restTimePickerView.plusButton.addTarget(self, action: #selector(plusRestTimeButtonTapped), for: .touchUpInside)
        restTimePickerView.minusButton.addTarget(self, action: #selector(minusRestTimeButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        var workTime: Int
        if let timeLabelText = workTimePickerView.timeLabel.text {
            workTime = Int(timeLabelText)! * 60
        } else {
            workTime = 25 * 60
        }
        
        workTime = 30
       
        
        var restTime: Int
        if let timeLabelText = restTimePickerView.timeLabel.text {
            restTime = Int(timeLabelText)! * 60
        } else {
            restTime = 5 * 60
        }
      
        
        presenter.startTimer(workTime: workTime, restTime: restTime)
    }
    
    func presentTimer(presenter: TimerPresenterProtocol) {
        let timerVC = TimerViewController(presenter: presenter)
        timerVC.modalPresentationStyle = .fullScreen
        present(timerVC, animated: true)
    }
    
    @objc func plusWorkTimeButtonTapped() {
        if let timeStr = workTimePickerView.timeLabel.text {
            var time = Int(timeStr)!
            if time < 60 {
                time += 5
            } else {
                time = 5
            }
            workTimePickerView.timeLabel.text = "\(time)"
        }
    }
    
    @objc func plusRestTimeButtonTapped() {
        if let timeStr = restTimePickerView.timeLabel.text {
            var time = Int(timeStr)!
            if time < 30 {
                time += 5
            } else {
                time = 5
            }
            restTimePickerView.timeLabel.text = "\(time)"
        }
    }
    
    @objc func minusWorkTimeButtonTapped() {
        if let timeStr = workTimePickerView.timeLabel.text {
            var time = Int(timeStr)!
            if time > 5 {
                time -= 5
            } else {
                time = 60
            }
            workTimePickerView.timeLabel.text = "\(time)"
        }
    }
    
    @objc func minusRestTimeButtonTapped() {
        if let timeStr = restTimePickerView.timeLabel.text {
            var time = Int(timeStr)!
            if time > 5 {
                time -= 5
            } else {
                time = 30
            }
            restTimePickerView.timeLabel.text = "\(time)"
        }
    }
    
    private func setupUI() {
        startButton.setTitle("Start", for: .normal)
        startButton.layer.cornerRadius = 14
        startButton.backgroundColor = .white
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        view.addSubview(startButton)
        
        workTimePickerView.setupUI()
        view.addSubview(workTimePickerView)
        
        restTimePickerView.setupUI()
        view.addSubview(restTimePickerView)
    }
    
    private func setupConstraints() {
        workTimePickerView.setupConstraints()
        workTimePickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workTimePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workTimePickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            workTimePickerView.widthAnchor.constraint(equalToConstant: 250),
            workTimePickerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        restTimePickerView.setupConstraints()
        restTimePickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restTimePickerView.topAnchor.constraint(equalTo: workTimePickerView.bottomAnchor, constant: 30),
            restTimePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restTimePickerView.widthAnchor.constraint(equalToConstant: 250),
            restTimePickerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        let startButtonTopConstraint = startButton.topAnchor.constraint(equalTo: restTimePickerView.bottomAnchor, constant: 60)
        startButtonTopConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            startButton.widthAnchor.constraint(equalToConstant: 250),
            startButtonTopConstraint,
            startButton.heightAnchor.constraint(lessThanOrEqualToConstant: 100)
        ])
    }
}


