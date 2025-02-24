//
//  Utils.swift
//  PomodoroTimer
//
//  Created by Даша Николаева on 23.02.2025.
//

import Foundation

class Utils {
    static func formatTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
