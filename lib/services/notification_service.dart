/// Simple notification service that prints messages to the console.
class NotificationService {
  void notify(String message) {
    // In a production app this would display a system notification.
    // For this prototype we simply print the message to the console.
    // ignore: avoid_print
    print('Notification: $message');
  }
}

