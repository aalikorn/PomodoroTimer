//
//  TimerPresenter.swift
//  PomodoroTimer
//
//  Created by Даша Николаева on 23.02.2025.
//

import Foundation

protocol TimerPresenterProtocol: TimerServiceDelegate {
    func pause()
    func finish()
    func start()
    func resume()
    func attachView(view: TimerViewProtocol?)
    init(task: Task)
    func getRestTimeString() -> String
    func getWorkTimeString() -> String
    func getWorkTime() -> TimeInterval
    func getRestTime() -> TimeInterval
    func isPaused() -> Bool
}

class TimerPresenter: TimerPresenterProtocol {
    
    weak var view: TimerViewProtocol?
    private let timerService: TimerService
    private let task: Task
    private var paused: Bool
    
    func isPaused() -> Bool {
        return self.paused
    }
    
    func getWorkTimeString() -> String {
        return Utils.formatTime(task.workTime)
    }
    
    func getRestTimeString() -> String {
        return Utils.formatTime(task.restTime)
    }
    
    func getWorkTime() -> TimeInterval {
        return TimeInterval(task.workTime)
    }
    
    func getRestTime() -> TimeInterval {
        return TimeInterval(task.restTime)
    }
    
    func timerDidUpdate(time: Int) {
        view?.timerDidUpdate(Utils.formatTime(time))
    }
    
    func timerDidSwitchMode(isWorkTime: Bool) {
        view?.timerDidSwitchMode(isWorkTime: isWorkTime)
    }
    
    required init(task: Task) {
        self.task = task
        self.paused = false
        timerService = TimerService(workTime: task.workTime, restTime: task.restTime)
        timerService.delegate = self
    }
    
    func attachView(view: TimerViewProtocol? = nil) {
        self.view = view
    }
    
    func start() {
        timerService.start()
    }
    
    func resume() {
        timerService.resume()
        paused = false
    }
    
    func pause() {
        timerService.pause()
        paused = true
    }
    
    func finish() {
        timerService.finish()
        view?.dismissTimer()
    }
}
