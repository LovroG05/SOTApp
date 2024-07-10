import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sotapp/models/Settings.model.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
  bool cw = false;
  bool ssb = false;
  bool fm = false;
  bool data = false;
  bool am = false;
  bool dv = false;
  bool other = false;

  List<String> bands = [];
  List<String> associations = [];

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

  final TextEditingController associationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getSettings(), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                var dat = snapshot.data;
                if (dat == null) {
                  return const CircularProgressIndicator();
                }
                

                cw = dat.cw!;
                ssb = dat.ssb!;
                fm = dat.fm!;
                data = dat.data!;
                am = dat.am!;
                dv = dat.dv!;
                other = dat.other_modes!;

                bands = dat.bands!;
                associations = dat.associations!;


                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color.fromARGB(60, 227, 124, 247),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Spotter Settings",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),

                              const Divider(
                                color: Colors.black,
                              ),

                              const Text(
                                "Modes",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: cw, 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        cw = !cw;
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setBool("cw", cw);
                                    },
                                  ),
                                  const Text(
                                    "CW"
                                  ),

                                  Checkbox(
                                    value: ssb, 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        ssb = !ssb;
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setBool("ssb", ssb);
                                    },
                                  ),
                                  const Text(
                                    "SSB"
                                  ),

                                  Checkbox(
                                    value: fm, 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        fm = !fm;
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setBool("fm", fm);
                                    },
                                  ),
                                  const Text(
                                    "FM"
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: data, 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        data = !data;
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setBool("data", data);
                                    },
                                  ),
                                  const Text(
                                    "Data"
                                  ),

                                  Checkbox(
                                    value: am, 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        am = !am;
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setBool("am", am);
                                    },
                                  ),
                                  const Text(
                                    "AM"
                                  ),

                                  Checkbox(
                                    value: dv, 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        dv = !dv;
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setBool("dv", dv);
                                    },
                                  ),
                                  const Text(
                                    "DV"
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: other, 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        other = !other;
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setBool("other_modes", other);
                                    },
                                  ),
                                  const Text(
                                    "Other modes"
                                  ),
                                ]
                              ),

                              const Text(
                                "Bands",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: bands.contains("160m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("160m")) {
                                          bands.remove("160m");
                                        } else {
                                          bands.add("160m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "160m"
                                  ),

                                  Checkbox(
                                    value: bands.contains("80m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("80m")) {
                                          bands.remove("80m");
                                        } else {
                                          bands.add("80m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "80m"
                                  ),

                                  Checkbox(
                                    value: bands.contains("60m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("60m")) {
                                          bands.remove("60m");
                                        } else {
                                          bands.add("60m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "60m"
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: bands.contains("40m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("40m")) {
                                          bands.remove("40m");
                                        } else {
                                          bands.add("40m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "40m"
                                  ),

                                  Checkbox(
                                    value: bands.contains("30m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("30m")) {
                                          bands.remove("30m");
                                        } else {
                                          bands.add("30m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "30m"
                                  ),

                                  Checkbox(
                                    value: bands.contains("20m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("20m")) {
                                          bands.remove("20m");
                                        } else {
                                          bands.add("20m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "20m"
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: bands.contains("17m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("17m")) {
                                          bands.remove("17m");
                                        } else {
                                          bands.add("17m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "17m"
                                  ),

                                  Checkbox(
                                    value: bands.contains("15m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("15m")) {
                                          bands.remove("15m");
                                        } else {
                                          bands.add("15m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "15m"
                                  ),

                                  Checkbox(
                                    value: bands.contains("12m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("12m")) {
                                          bands.remove("12m");
                                        } else {
                                          bands.add("12m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "12m"
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: bands.contains("10m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("10m")) {
                                          bands.remove("10m");
                                        } else {
                                          bands.add("10m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "10m"
                                  ),

                                  Checkbox(
                                    value: bands.contains("6m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("6m")) {
                                          bands.remove("6m");
                                        } else {
                                          bands.add("6m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "6m"
                                  ),

                                  Checkbox(
                                    value: bands.contains("4m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("4m")) {
                                          bands.remove("4m");
                                        } else {
                                          bands.add("4m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "4m"
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: bands.contains("2m"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("2m")) {
                                          bands.remove("2m");
                                        } else {
                                          bands.add("2m");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "2m"
                                  ),

                                  Checkbox(
                                    value: bands.contains("70cm"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("70cm")) {
                                          bands.remove("70cm");
                                        } else {
                                          bands.add("70cm");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "70cm"
                                  ),

                                  Checkbox(
                                    value: bands.contains("23cm"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("23cm")) {
                                          bands.remove("23cm");
                                        } else {
                                          bands.add("23cm");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "23cm"
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: bands.contains("microwave"), 
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if (bands.contains("microwave")) {
                                          bands.remove("microwave");
                                        } else {
                                          bands.add("microwave");
                                        }
                                      });
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("bands", bands);
                                    },
                                  ),
                                  const Text(
                                    "Microwave"
                                  ),
                                ],
                              ),

                              const Text(
                                "Associations",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter association',
                                      ),
                                      controller: associationsController,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextButton(
                                      onPressed: () async {
                                        String assocs = associationsController.text;

                                        if (assocs != "") {
                                          setState(() {
                                            associations.add(assocs);
                                          });
                                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.setStringList("associations", associations);
                                        }
                                        
                                        
                                      }, 
                                      child: const Icon(Icons.add),
                                    ),
                                  )
                                ],
                              ),

                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: associations.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,

                                    onDismissed: (_) async {
                                      setState(() {
                                        associations.removeAt(index);
                                      });

                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setStringList("associations", associations);
                                    },

                                    background: Container(
                                      color: Colors.red,
                                      margin: const EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.centerRight,
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),

                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Card(
                                        color: Colors.pink[200],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(associations[index]),
                                          )
                                        ),
                                      )
                                    )
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Text("No data");
              }
            } else {
              return const CircularProgressIndicator();
            }
          }
        ),
      )
    );
  }

}