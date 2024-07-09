import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:sotapp/utils/local_notification.utils.dart'; // Consider using a logging library for debugging


final Logger logger = Logger();

@pragma('vm:entry-point')
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    LocalNotificationService().showNotification(
      title: message.data["callsign"] + " - " + message.data["association"] + "/" + message.data["summit"], 
      description: message.data["frequency"]
    );


    // Process the notification data here (e.g., display a local notification)
  }
class FirebaseUtil {
  final _firebaseMessaging = FirebaseMessaging.instance;
   // Optional: For logging

  


  Future<void> initNotification() async {
    // Request notification permissions
    await _firebaseMessaging.requestPermission();

    // Get the FCM token for identification
    final fCMToken = await _firebaseMessaging.getToken();
    logger.d(fCMToken);

    // Listen for background messages
    print("WTF IS THIS");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    
  }
}