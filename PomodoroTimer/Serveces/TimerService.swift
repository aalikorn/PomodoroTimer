//
//  TimerService.swift
//  PomodoroTimer
//
//  Created by Даша Николаева on 23.02.2025.
//

import Foundation

protocol TimerServiceDelegate: AnyObject {
    func timerDidUpdate(time: Int)
    func timerDidSwitchMode(isWorkTime: Bool)
}

class TimerService {
    weak var delegate: TimerServiceDelegate?
    private var timer: Timer?
    private var remainingTime: Int = 0
    private var isWorkTime = true
    var workTime: Int
    var restTime: Int
    
    init(workTime: Int, restTime: Int) {
        self.workTime = workTime
        self.restTime = restTime
    }

    func start() {
        self.remainingTime = self.isWorkTime ? workTime : restTime
        startCountdown()
    }

    private func startCountdown() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.delegate?.timerDidUpdate(time: self.remainingTime)
            } else {
                self.isWorkTime.toggle()
                self.remainingTime = self.isWorkTime ? workTime : restTime 
                self.delegate?.timerDidSwitchMode(isWorkTime: self.isWorkTime)
            }
        }
    }

    func finish() {
        timer?.invalidate()
    }
    
    func pause() {
        timer?.invalidate()
    }
    
    func resume() {
        startCountdown()
    }
}


