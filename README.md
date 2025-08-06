# Camp Leader

## English

Camp Leader is a Flutter prototype that helps camp leaders plan events, manage tasks and stay in touch with their teams.

### Features
- **Authentication** – basic login/logout flow using a mocked `AuthService`.
- **Events** – create events with categories, priorities, repeat intervals and local notifications.
- **Tasks** – track tasks with priority, repeat schedules, reminders and the ability to reorder and toggle completion.
- **Chat** – Firestore‑backed chat with attachments, read receipts and typing indicators.
- **Admin tools** – manage users and invitations, edit roles and generate PDF reports.
- **Offline support** – persist tasks and events locally and sync them automatically when connectivity returns.
- **Theming & routing** – light and dark themes and navigation powered by `go_router`.

### Project Structure
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

### Getting Started
#### Prerequisites
- [Flutter SDK](https://flutter.dev) (Dart >=3.0.0 <4.0.0)
- Configured Firebase project for Firestore and Storage
- Optional: Sentry account for error reporting

#### Installation
```bash
flutter pub get
```

#### Running
Choose a target and run the application:

| Platform | Command |
| --- | --- |
| Android | `flutter run -d android` |
| iOS | `flutter run -d ios` |
| Web | `flutter run -d chrome` |
| Linux | `flutter run -d linux` |
| macOS | `flutter run -d macos` |
| Windows | `flutter run -d windows` |

#### Running Tests
```bash
flutter test
```

### Contributing
Contributions, issues and feature requests are welcome. Open a pull request to propose changes.

### License
This project is provided as‑is without a specified license.

---

## Русский

Camp Leader — это прототип Flutter, помогающий руководителям лагерей планировать события, управлять задачами и поддерживать связь с командой.

### Возможности
- **Аутентификация** — базовый вход и выход с использованием фиктивного `AuthService`.
- **События** — создание событий с категориями, приоритетами, интервалами повторения и локальными уведомлениями.
- **Задачи** — отслеживание задач с приоритетом, расписанием повторений, напоминаниями, а также возможность менять порядок и отмечать выполнение.
- **Чат** — чат на Firestore с вложениями, уведомлениями о прочтении и индикаторами набора текста.
- **Админ‑инструменты** — управление пользователями и приглашениями, редактирование ролей и генерация PDF‑отчётов.
- **Оффлайн‑поддержка** — локальное сохранение задач и событий с автоматической синхронизацией при появлении сети.
- **Темы и маршруты** — светлая и тёмная темы, навигация на базе `go_router`.

### Структура проекта
```
project/
  lib/
    core/        # Интерфейсные страницы
    models/      # Модели данных (Event, Task, User)
    providers/   # Управление состоянием через Provider
    routes/      # Конфигурация GoRouter
    services/    # Auth, чат, уведомления, оффлайн‑синхронизация, отчёты
    theme.dart   # Определение тем
  pubspec.yaml
```

### Начало работы
#### Предварительные требования
- [Flutter SDK](https://flutter.dev) (Dart >=3.0.0 <4.0.0)
- Настроенный проект Firebase для Firestore и Storage
- Необязательно: учётная запись Sentry для отчётов об ошибках

#### Установка зависимостей
```bash
flutter pub get
```

#### Запуск
Выберите целевую платформу и выполните:

| Платформа | Команда |
| --- | --- |
| Android | `flutter run -d android` |
| iOS | `flutter run -d ios` |
| Web | `flutter run -d chrome` |
| Linux | `flutter run -d linux` |
| macOS | `flutter run -d macos` |
| Windows | `flutter run -d windows` |

#### Запуск тестов
```bash
flutter test
```

### Участие
Мы приветствуем вклад, проблемы и запросы на новые функции. Отправляйте pull‑request с предложениями изменений.

### Лицензия
Проект предоставляется «как есть» без указанной лицензии.

