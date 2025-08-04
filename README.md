# Camp Leader

Camp Leader is a Flutter prototype for managing tasks, events, and team communication for camp leaders.

## Features
- **Authentication**: Simulated login/logout flow using a basic `AuthService`.
- **Events**: Create events with categories, priority, repeat intervals, and local notifications.
- **Tasks**: Track tasks with priority, repeat schedules, and reminders. Tasks can be reordered and toggled complete.
- **Chat**: Firestore‑backed chat with attachments, read receipts, and typing indicators.
- **Admin tools**: Manage users and invitations, edit roles, and generate PDF reports.
- **Offline support**: Persist tasks and events locally and sync them automatically when connectivity returns.
- **Theming & routing**: Light/dark themes and navigation powered by `go_router`.

## Project Structure
```
lib/
  core/        # UI pages (home, login, events, tasks, admin, etc.)
  models/      # Data models such as Event, Task, User
  providers/   # State management using Provider
  routes/      # Central GoRouter configuration
  services/    # Auth, chat, notification, offline sync, reports
  theme.dart   # Light and dark theme definitions
```

## Getting Started
1. **Install prerequisites**
   - [Flutter SDK](https://flutter.dev) (compatible with Dart >=2.17 <3.0)
   - A configured Firebase project for Firestore and Storage
   - Optional: Sentry account for error reporting
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Configure services**
   - Update `lib/main.dart` with your Sentry DSN.
   - Add Firebase configuration files to the `android` and `ios` folders and enable Firestore/Storage.
   - Ensure notification permissions are requested on your target platforms.
4. **Run the app**
   ```bash
   flutter run
   ```
5. **Tests**
   ```bash
   flutter test
   ```

## License
This project is provided as‑is without a specified license.

