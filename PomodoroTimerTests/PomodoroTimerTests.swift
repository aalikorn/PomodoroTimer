//
//  PomodoroTimerTests.swift
//  PomodoroTimerTests
//
//  Created by Даша Николаева on 24.02.2025.
//

import XCTest
@testable import PomodoroTimer

final class TimerPresenterTests: XCTestCase {
    class MockTimerView: TimerViewProtocol {
        
        var time: String?
        var isWorkTime: Bool?
        var timerDismissed: Bool = false
        
        func dismissTimer() {
            timerDismissed = true
        }
        
        func pauseButtonTapped() {
            
        }
        
        func stopButtonTapped() {
            
        }
        
        func timerDidUpdate(_ time: String) {
            self.time = time
        }
        
        func timerDidSwitchMode(isWorkTime: Bool) {
            self.isWorkTime = isWorkTime
        }
    }
    
    func testPauseAndResume() throws {
        let task = Task(workTime: 5, restTime: 5)
        let presenter = TimerPresenter(task: task)
        let mockView = MockTimerView()
        presenter.attachView(view: mockView)
        
        presenter.pause()
        XCTAssertTrue(presenter.isPaused(), "Timer is paused")
        presenter.resume()
        XCTAssertFalse(presenter.isPaused(), "Timer is resumed")
    }
    
    func testStop() throws {
        let task = Task(workTime: 5, restTime: 5)
        let presenter = TimerPresenter(task: task)
        let mockView = MockTimerView()
        presenter.attachView(view: mockView)
        
        presenter.finish()
        XCTAssertTrue(mockView.timerDismissed, "Timer is dismissed")
    }
}

final class StartTimerPresenterTests: XCTestCase {
    
    class MockStartTimerView: startTimerViewProtocol {
        var timerPresented: Bool = false
        
        func startButtonTapped() {
        }
        
        func plusWorkTimeButtonTapped() {
        }
        
        func plusRestTimeButtonTapped() {
        }
        
        func minusWorkTimeButtonTapped() {
        }
        
        func minusRestTimeButtonTapped() {
        }
        
        func presentTimer(presenter: any PomodoroTimer.TimerPresenterProtocol) {
            timerPresented = true
        }
        
        func configurePresenter() {
        }
    }
    
    func testStartTimer() throws {
        let mockView = MockStartTimerView()
        let presenter = StartTimerPresenter()
        presenter.view = mockView
        
        presenter.startTimer(workTime: 5, restTime: 5)
        XCTAssertTrue(mockView.timerPresented)
    }
}

