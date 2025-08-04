# Camp Leader

Camp Leader is a Flutter prototype that helps camp leaders plan events, track tasks, and stay in touch with their teams.

## Table of Contents
- [Features](#features)
- [For All Users](#for-all-users)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running](#running)
- [Running Tests](#running-tests)
- [Contributing](#contributing)
- [License](#license)

## Features
- **Authentication**: simulated login/logout flow using a basic `AuthService`.
- **Events**: create events with categories, priorities, repeat intervals, and local notifications.
- **Tasks**: track tasks with priority, repeat schedules, reminders, and the ability to reorder and toggle completion.
- **Chat**: Firestore‑backed chat with attachments, read receipts, and typing indicators.
- **Admin tools**: manage users and invitations, edit roles, and generate PDF reports.
- **Offline support**: persist tasks and events locally and sync them automatically when connectivity returns.
- **Theming & routing**: light and dark themes and navigation powered by `go_router`.

## For All Users
Camp Leader welcomes campers and administrators alike. If you're trying out the app or planning to contribute, start with [Getting Started](#getting-started) for setup instructions and visit [Contributing](#contributing) to learn how to share feedback and improvements.

## Project Structure
```
project/
  lib/
    core/        # UI pages (home, login, events, tasks, admin, etc.)
    models/      # Data models such as Event, Task, User
    providers/   # State management using Provider
    routes/      # Central GoRouter configuration
    services/    # Auth, chat, notification, offline sync, reports
    theme.dart   # Light and dark theme definitions
  pubspec.yaml
```

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev) (compatible with Dart >=2.17 <3.0)
- A configured Firebase project for Firestore and Storage
- Optional: Sentry account for error reporting

### Installation
```bash
flutter pub get
```

### Running
```bash
flutter run
```

## Running Tests
```bash
flutter test
```

## Contributing
Contributions, issues, and feature requests are welcome. Feel free to open a pull request to propose changes.

## License
This project is provided as‑is without a specified license.
