import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/validators.dart';
import 'package:eatnaija/presentation/screens/login/bloc/login_bloc.dart';
import 'package:eatnaija/presentation/screens/login/login_screen.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'bloc/otp_verify_bloc.dart';

class OtpVerifyForm extends StatefulWidget {

  final String otp;
  final bool fromCheckout;

  const OtpVerifyForm({Key key, this.otp,this.fromCheckout}) : super(key: key);

  @override
  State<OtpVerifyForm> createState() => _OtpVerifyFormState();
}

class _OtpVerifyFormState extends State<OtpVerifyForm>
    with TickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  UserRepository userRepository;

  String _otpCollector;

  bool _autoValidate = false;

  // String otp = "2322";
  CustomLoader _loader;

  @override
  void initState() {
    _autoValidate = false;
    userRepository = UserRepository();
    _loader = CustomLoader(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _verifyOtpButtonPressed() {
      if (_otpCollector == null ||
          _otpCollector.isEmpty ||
          _otpCollector.length != 4) {
        // customSnackBar(_scaffoldKey, 'OTP required');
        return;
      }

      if(_otpCollector != widget.otp){
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Incorrect OTP... Please try again'),
          backgroundColor: Resources.PRIMARY_COLOR,
        ));
      }else {
        var _loginBloc = BlocProvider.of<OtpVerifyBloc>(context)
            .add(OtpButtonPressed(otp: _otpCollector));
      }
    }

    return BlocListener<OtpVerifyBloc, OtpVerifyState>(
      listener: (context, state) {
        if (state is OtpVerifyFaliureState) {
          print("back to failure");
          _loader.hideLoader();

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Resources.PRIMARY_COLOR,
          ));
        }
        if (state is OtpVerifyLoadingState) {
          print("back to loading");
          _loader.showLoader();
        }
        if (state is OtpVerifySuccessState) {
          // _loader.hideLoader();

          Fluttertoast.showToast(
              msg: "OTP Verification Successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      LoginScreen(userRepository: userRepository,fromCheckout: widget.fromCheckout)),
              (Route<dynamic> route) => false);
        }
        if (state is OtpVerifyInitialState) {
          print("back to initial");
          _loader.hideLoader();
        }
      },
      child: BlocBuilder<OtpVerifyBloc, OtpVerifyState>(
        builder: (context, state) {
          return Container(
            child: Form(
              key: _key,
              autovalidate: _autoValidate,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _otpField(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.18,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: RaisedButton(
                          color: Color(0xFFEF5B25),
                          onPressed: _verifyOtpButtonPressed,
                          child: Text(
                            'Verify OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                          shape: StadiumBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _otpField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15.0),
        child: PinCodeTextField(
          length: 4,
          obscureText: false,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            inactiveColor: Resources.PRIMARY_COLOR,
            inactiveFillColor: Colors.white,
            activeColor: Resources.PRIMARY_COLOR,
            selectedColor: Colors.white,
            selectedFillColor: Resources.PRIMARY_COLOR,
            activeFillColor: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          onChanged: (value) {
            setState(() => _otpCollector = value);
          },
          appContext: context,
        ),
      ),
    );
  }

  _validateAndMakeRequest() async {
    if (_otpCollector == null ||
        _otpCollector.isEmpty ||
        _otpCollector.length != 4) {
      // customSnackBar(_scaffoldKey, 'OTP required');
      return;
    }
  }
}
