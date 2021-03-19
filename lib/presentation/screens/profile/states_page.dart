

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StatesPage extends StatefulWidget {
  @override
  _StatesPageState createState() => _StatesPageState();
}

class _StatesPageState extends State<StatesPage> {

  List<String> states = new List();

  bool isLoading;

  void setupWorldTime() async {
    states =  getTime();
  }

  @override
  void initState() {
    isLoading = true;
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select State"),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: states.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: Card(
                child: ListTile(
                  onTap: () {

                    Navigator.pop(context, states[index]);

                  },
                  title: Text(states[index]),
                ),
              ),
            );
          }
      ),
    );
  }

  List<String> getTime() {
    // make the request

    List<String> locations = [
      "Abia",
      "Adamawa",
      "Akwa Ibom",
      "Anambra",
      "Bauchi",
      "Bayelsa",
      "Benue",
      "Borno",
      "Cross River",
      "Delta",
      "Ebonyi",
      "Edo",
      "Ekiti",
      "Enugu",
      "FCT - Abuja",
      "Gombe",
      "Imo",
      "Jigawa",
      "Kaduna",
      "Kano",
      "Katsina",
      "Kebbi",
      "Kogi",
      "Kwara",
      "Lagos",
      "Nasarawa",
      "Niger",
      "Ogun",
      "Ondo",
      "Osun",
      "Oyo",
      "Plateau",
      "Rivers",
      "Sokoto",
      "Taraba",
      "Yobe",
      "Zamfara"
    ];
    return locations;

  }
}

