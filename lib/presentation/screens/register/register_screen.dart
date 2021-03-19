import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/presentation/screens/login/login_screen.dart';
import 'package:eatnaija/presentation/screens/otp_verify/otp_verify_page.dart';
import 'package:eatnaija/presentation/screens/register/bloc/register_bloc.dart';
import 'package:eatnaija/presentation/screens/register/register_form.dart';
import 'package:eatnaija/presentation/screens/register/register_screen.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatelessWidget {
  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/auth_bg.png",
                    ),
                    fit: BoxFit.cover)),
            child: ListView(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Stack(children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 150.0,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 60.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50.0,
                                      ),
                                      Text(
                                        "Create Account",
                                        style: TextStyle(
                                            color: Color(0xFFEF5B25),
                                            fontFamily: Resources.METROPOLIS,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.0),
                                      ),
                                    ],
                                  ),
                                ),
                                RegisterForm(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 140.0,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Already a  member?",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Resources.PRIMARY_COLOR)),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        InkWell(
                                            onTap: () =>
                                                Navigator.of(context).pop(false),
                                            child: Text("Login",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold)))
                                      ],
                                    ),
                                  ),
                                )
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
