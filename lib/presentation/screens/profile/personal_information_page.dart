import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/presentation/screens/profile/cubit/personal_information_cubit.dart';
import 'package:eatnaija/presentation/screens/profile/personal_information_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_cubit/flutter_cubit.dart';

class PersonalInformationPage extends StatefulWidget {
  PersonalInformationPage({Key key}) : super(key: key);

  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();

  static _PersonalInformationPageState of(BuildContext context) =>
      context.findAncestorStateOfType<_PersonalInformationPageState>();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  String _string;

  String mainAddress;

  @override
  void initState() {
    super.initState();
    mainAddress = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Address"),
        backgroundColor: Resources.PRIMARY_COLOR,
      ),
      body: CubitProvider(
        create: (context) {
          return PersonalInformationCubit();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.0,),
                  PersonalInformationForm(mainAddress, (val) {
                    setState(() {
                      mainAddress = val;
                      print(mainAddress);
                      if (val != null) {
                        Navigator.of(context).pop({'selection': mainAddress});
                      }
                    });
                  }),
                  SizedBox(height: 30.0,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
