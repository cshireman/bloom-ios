# Repository Guidelines

## Project Structure & Module Organization
- `Bloom/App` owns the SwiftUI App entry point and scene wiring.
- `Presentation` contains SwiftUI screens, theming primitives, and reusable components; keep assets in `Assets.xcassets` and interface files (e.g., `LaunchScreen.storyboard`) alongside them.
- `Domain` holds entities and pure business logic, while `Data` maps to remote/local sources and DTOs; `Infrastructure` provides config, dependency injection, and platform services.
- Tests live in `BloomTests` (unit) and `BloomUITests` (UI automation); mirror the production folder names when adding suites, and place snapshots or fixtures next to the test that consumes them.

## Build, Test, and Development Commands
```sh
xed Bloom.xcodeproj                         # Open the project in Xcode
xcodebuild -scheme Bloom \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build
xcodebuild test -scheme Bloom \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
swiftlint --fix Bloom && swiftlint Bloom    # Format/lint using the repo's .swiftlint.yml
```
Run commands from the repo root; CI expects a clean build and test pass before merging.

## Coding Style & Naming Conventions
Follow Swift 5.9 defaults with four-space indentation and 120-column lines. Prefer SwiftUI modifiers that group intent (layout, visuals, state). Type and protocol names are `PascalCase`; private helpers use `lowerCamelCase`. Use `enum ModuleName` namespaces for constants (see `Presentation/Theme`). SwiftLint runs as an Xcode build phase—keep files lint-clean locally before pushing.

## Testing Guidelines
Use XCTest for units and XCUITest for flows. Name unit tests `test_<Scenario>_<Expectation>` and UI tests `testFlow_<Screen>` so failures read clearly. New functionality requires direct unit coverage plus at least one UI sanity check when user-visible. Target 80% line coverage in the touched module; add test doubles inside `BloomTests/Support` rather than production targets.

## Commit & Pull Request Guidelines
History favors concise, imperative subjects (e.g., "SwiftLint Updates", "Minor cleanup"). Keep bodies brief but mention affected modules and any migration notes. PRs must include: summary, screenshots/GIFs for UI work, test evidence (`xcodebuild test` logs or Xcode screenshot), and linked issues. Draft early, re-request review after CI is green, and avoid force-pushing after reviews without calling out the changes.

