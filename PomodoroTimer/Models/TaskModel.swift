//
//  startTimerModel.swift
//  PomodoroTimer
//
//  Created by Даша Николаева on 23.02.2025.
//

import Foundation

struct Task {
    var workTime: Int
    var restTime: Int
}

enum CountdownState {
    case work
    case rest
}
