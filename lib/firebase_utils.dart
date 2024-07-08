import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart'; // Consider using a logging library for debugging

class FirebaseUtil {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final Logger logger = Logger(); // Optional: For logging

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    logger.d(message.notification?.title ?? "No title available");
    logger.d(message.notification?.body ?? "No body available");
    logger.d(message.data);
    // Process the notification data here (e.g., display a local notification)
  }

  Future<void> initNotification() async {
    // Request notification permissions
    await _firebaseMessaging.requestPermission();

    // Get the FCM token for identification
    final fCMToken = await _firebaseMessaging.getToken();
    logger.d(fCMToken);

    // Listen for background messages
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}