import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/presentation/screens/otp_verify/otp_verify_form.dart';
import 'package:eatnaija/presentation/screens/register/register_screen.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_svg/svg.dart';
import 'bloc/otp_verify_bloc.dart';

class OtpVerifyPage extends StatefulWidget {

  final String otp;
  final bool fromCheckOut;
  OtpVerifyPage({Key key, this.otp,this.fromCheckOut}) : super(key: key);

  @override
  _OtpVerifyPageState createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {



  AuthenticationBloc authenticationBloc;
  UserRepository userRepository;

  @override
  void initState() {
    super.initState();

    userRepository = UserRepository();
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return OtpVerifyBloc(userRepository: userRepository, authenticationBloc: authenticationBloc);
        },
        child: SafeArea(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "OTP Verification",
                                    style: TextStyle(
                                        color: Color(0xFFEF5B25),
                                        fontFamily: Resources.METROPOLIS,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Please type the verification number sent to your email",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontFamily: Resources.METROPOLIS,
                                          fontWeight: FontWeight.normal,
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
                                  OtpVerifyForm(otp: widget.otp,fromCheckout: widget.fromCheckOut,),
                                ],
                              ),
                            ),
                            Column(
                              children: [],
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
