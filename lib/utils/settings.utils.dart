import 'package:shared_preferences/shared_preferences.dart';
import 'package:sotapp/models/Settings.model.dart';

Future<Settings> getSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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



    return Settings(
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