//
//  StartTimerPresenter.swift
//  PomodoroTimer
//
//  Created by Даша Николаева on 23.02.2025.
//

import Foundation

protocol StartTimerPresenterProtocol: AnyObject {
    func startTimer(workTime: Int, restTime: Int)
}

class StartTimerPresenter: StartTimerPresenterProtocol {
    var timerPresenter: TimerPresenterProtocol!
    weak var view: startTimerViewProtocol!
    
    func startTimer(workTime: Int, restTime: Int) {
        let task = Task(workTime: workTime, restTime: restTime)
        let timerPresenter = TimerPresenter(task: task)
        view.presentTimer(presenter: timerPresenter)
    }
}
