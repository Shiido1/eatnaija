import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/firebase/sign_in.dart';
import 'package:eatnaija/presentation/screens/register/register_screen.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'bloc/login_bloc.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  final foodItem;

  LoginScreen({Key key, @required this.userRepository, this.foodItem})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/auth_bg.png"),
                    fit: BoxFit.cover)),
            child: ListView(
              children: [
                Stack(children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150.0, bottom: 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 70.0,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Color(0xFFEF5B25),
                                        fontFamily: Resources.METROPOLIS,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0),
                                  ),
                                  LoginForm(
                                    foodItem: foodItem,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30.0, horizontal: 30.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () => signOutGoogle(),
                                          child: Text("Not a member?",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color:
                                                      Resources.PRIMARY_COLOR)),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        InkWell(
                                            onTap: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterScreen())),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 8.0, 0.0, 8.0),
                                              child: Text("Signup",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ))
                                      ],
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
