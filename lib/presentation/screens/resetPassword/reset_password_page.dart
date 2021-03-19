
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/change_password/bloc/change_password_bloc.dart';
import 'package:eatnaija/presentation/screens/change_password/repository/change_password_repository.dart';
import 'package:eatnaija/presentation/screens/register/register_screen.dart';
import 'package:eatnaija/presentation/screens/resetPassword/cubit/reset_password_cubit.dart';
import 'package:eatnaija/presentation/screens/resetPassword/cubit/reset_password_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_svg/svg.dart';

import 'reset_password_form.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  Map<String, dynamic> vendor = Map<String, dynamic>();

  String mycategory;
  String myState;

  bool isFormValid;

  var ss;

  ChangePasswordRepository changePasswordRepository;

  UserDao vendorDao;

  @override
  void initState() {
    super.initState();
    changePasswordRepository = ChangePasswordRepository();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CubitProvider<ResetPasswordCubit>(
        create: (context) {
          return ResetPasswordCubit();
        },
        child:       SafeArea(
      child: SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/auth_bg.png"), fit: BoxFit.cover)),
      child: Center(
        child: Stack(children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0, bottom: 60.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 70.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 70.0,),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Reset Password",
                              style: TextStyle(
                                  color: Color(0xFFEF5B25),
                                  fontFamily: Resources.METROPOLIS,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              "Please enter your registered email address into the form below",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.4,
                                  color: Colors.grey[700],
                                  fontFamily: Resources.METROPOLIS,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ResetPasswordForm(anotherContext: context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage:
                  AssetImage("assets/images/eatnaija_logo.png"),
                  radius: 48.0,
                ),
              ),
            ),
          ),
        ]),
      ),
    ),
    ),
    ),

    ),
    );
  }
}
