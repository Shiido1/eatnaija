import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/main.dart';
import 'package:eatnaija/presentation/screens/register/register_screen.dart';
import 'package:eatnaija/presentation/screens/update_address/cubit/update_address_cubit.dart';
import 'package:eatnaija/presentation/screens/update_address/update_address_form.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_svg/svg.dart';

class UpdateAddressPage extends StatefulWidget {
  UpdateAddressPage({Key key}) : super(key: key);

  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();

  static _UpdateAddressPageState of(BuildContext context) =>
      context.findAncestorStateOfType<_UpdateAddressPageState>();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
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
          return UpdateAddressCubit();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UpdateAddressForm(mainAddress, (val) {
                          setState(() {
                            mainAddress = val;
                            print(mainAddress);
                            if (val != null) {
                              Navigator.of(context).pop({'selection': mainAddress});
                            }
                          });
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
}

typedef void StringCallback(String val);
