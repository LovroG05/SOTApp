import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sotapp/models/Settings.model.dart';
import 'package:sotapp/utils/local_notification.utils.dart';
import 'package:sotapp/utils/settings.utils.dart'; // Consider using a logging library for debugging


final Logger logger = Logger();



@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  Settings settings = await getSettings();

  List<String> modes = [];
  settings.am! ? modes.add("AM") : null;
  settings.cw! ? modes.add("CW") : null;
  settings.data! ? modes.add("DATA") : null;
  settings.dv! ? modes.add("DV") : null;
  settings.fm! ? modes.add("FM") : null;
  settings.ssb! ? modes.add("SSB") : null;
  settings.other_modes! ? modes.add("Other") : null;

  if (modes.contains(message.data["mode"]) 
      && settings.associations!.contains(message.data["association"])) {  // TODO add bands filter (idk how)
    LocalNotificationService().showNotification(
      title: message.data["callsign"] + " - " + message.data["association"] + "/" + message.data["summit"], 
      description: message.data["frequency"] + " " + message.data["mode"]
    );
  }

  
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

    final prefs = await SharedPreferences.getInstance();

    List<String>? associations = prefs.getStringList("associations");
    List<String>? bands = prefs.getStringList("bands");
    bool? cw = prefs.getBool("cw");
    bool? ssb = prefs.getBool("ssb");
    bool? fm = prefs.getBool("fm");
    bool? data = prefs.getBool("data");
    bool? am = prefs.getBool("am");
    bool? dv = prefs.getBool("dv");
    bool? other_modes = prefs.getBool("other_modes");

    cw ??= false;
    ssb ??= false;
    fm ??= false;
    data ??= false;
    am ??= false;
    dv ??= false;
    other_modes ??= false;

    bands ??= [];
    associations ??= [];



    Settings s = Settings(
      associations: associations, 
      bands: bands,
      cw: cw,
      ssb: ssb,
      fm: fm,
      data: data,
      am: am,
      dv: dv,
      other_modes: other_modes
    );

    
  }


}