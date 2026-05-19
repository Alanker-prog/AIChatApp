//
//  AppState.swift
//  AIChatApp
//
//  Created by Алан Парастаев on 15.04.2026.
//
import SwiftUI

@Observable
@MainActor
class AppState {
    
    private(set) var showTabBar: Bool = false {
        didSet {
            UserDefaults.showTabbarView = showTabBar
        }
    }
    
    private(set) var isDarkMode: Bool = true {
        didSet {
            UserDefaults.isDarkMode = isDarkMode
        }
    }
    
    init(
        showTabBar: Bool = UserDefaults.showTabbarView,
        isDarkMode: Bool = UserDefaults.isDarkMode
    ) {
        self.showTabBar = showTabBar
        self.isDarkMode = isDarkMode
    }
    
    func updateViewState(showTabBarView: Bool) {
        showTabBar = showTabBarView
    }
    
    func updateColorScheme(isDarkMode: Bool) {
        self.isDarkMode = isDarkMode
    }
}

// MARK: - UserDefaults Extension

extension UserDefaults {
    
    private struct Keys {
        static let showTabbarView = "showTabbarView"
        static let isDarkMode = "isDarkMode"
    }
    
    static var showTabbarView: Bool {
        get { standard.bool(forKey: Keys.showTabbarView) }
        set { standard.set(newValue, forKey: Keys.showTabbarView) }
    }
    
    static var isDarkMode: Bool {
        get {
            // если ключ не существует — возвращаем true (тёмная по умолчанию)
            guard standard.object(forKey: Keys.isDarkMode) != nil else {
                return true
            }
            return standard.bool(forKey: Keys.isDarkMode)
        }
        set { standard.set(newValue, forKey: Keys.isDarkMode) }
    }
}
