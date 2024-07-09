import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sotapp/firebase_options.dart';
import 'package:sotapp/utils/firebase.utils.dart';
import 'package:sotapp/utils/local_notification.utils.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize notification handling
  await FirebaseUtil().initNotification();

  await LocalNotificationService.init();
  runApp(const MyApp());
}




