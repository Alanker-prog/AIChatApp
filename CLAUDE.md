# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AIChatApp is a SwiftUI iOS application — an AI chat interface currently in early development. The project was created with Xcode and targets iOS.

## Build & Run

Open and run via Xcode. There is no package manager (no SPM, CocoaPods, or Carthage) at this stage.

```bash
# Build from command line (adjust scheme/destination as needed)
xcodebuild -scheme AIChatApp -destination 'platform=iOS Simulator,name=iPhone 16'

# Run tests
xcodebuild test -scheme AIChatApp -destination 'platform=iOS Simulator,name=iPhone 16'
```

## Architecture

### Entry Point & Routing

`AIChatAppApp.swift` is the `@main` entry point. It currently renders `ContentView` (default Xcode template stub), but the real app shell is `AppView` / `AppViewBuilder` in `Core /AppView/`.

**App-level routing** is handled by two components:
- `AppViewBuilder` — a generic, reusable `View` that accepts `tabbarView` and `onboarding` view builders and animates between them based on a `showTabbar: Bool` flag. This is a pure, logic-free layout component designed to be previewed and tested in isolation.
- `AppView` — wires `AppViewBuilder` to `@AppStorage("showTabbarView")` for persistence, passing `TabBarView` and `WelcomeView` as the two states.

This two-component pattern (generic builder + concrete wiring view) is the established convention in this codebase — follow it when adding similar routing or conditional-display logic.

### Feature Structure

All feature screens live under `Core /` (note: folder name has a trailing space). Each feature gets its own subfolder:

```
Core /
  AppView/       — app shell (AppView + AppViewBuilder)
  TabBar/        — TabBarView (Explore / Chats / Profile tabs)
  Welcome/       — onboarding entry screen
  Explore/       — Explore tab
  Chats/         — Chats tab
  Profile/       — Profile tab (has a Settings sheet)
```

Each feature file is named `<Feature>View.swift` and wraps its content in a `NavigationStack`.

### State Management Conventions

- `@AppStorage` — used for state that must survive app restarts (e.g., whether onboarding has been completed)
- `@State` — local view state (e.g., `showSettingsView` in `ProfileView`)

### Previews

Every view includes one or more `#Preview` blocks. `AppViewBuilder` and `AppView` include multiple named previews (`"AppView - Tabbar"`, `"AppView - Onboarding"`) to cover both routing states — follow this pattern for any view with conditional display logic.
