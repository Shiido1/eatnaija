import 'package:eatnaija/common/Utils.dart';
import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/slide_route_transition.dart';
import 'package:eatnaija/common/validators.dart';
import 'package:eatnaija/firebase/facebook_auth.dart';
import 'package:eatnaija/firebase/sign_in.dart';
import 'package:eatnaija/presentation/screens/food_detail/food_detail_page.dart';
import 'package:eatnaija/presentation/screens/resetPassword/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  final foodItem;

  const LoginForm({Key key, this.foodItem}) : super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _autoValidate = false;

  CustomLoader _loader;

  String facebookName, facebookEmail, facebookImage;

  @override
  void initState() {
    _autoValidate = false;
    _loader = CustomLoader(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      if (_key.currentState.validate()) {
        var _loginBloc =
            BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text.toString(),
        ));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          _loader.hideLoader();

          Commons.hideKeyboard(context);

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Resources.PRIMARY_COLOR,
          ));
        }
        if (state is LoginLoading) {
          _loader.showLoader();
        }
        if (state is LoginSuccess) {
          print("wer are going there");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => FoodDetailPage(
                        foodItem: widget.foodItem,
                      )),
              (Route<dynamic> route) => false);
        }
        if (state is LoginInitial) {
          Commons.hideKeyboard(context);

          _loader.hideLoader();
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            child: Form(
              key: _key,
              autovalidate: _autoValidate,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _usernameController,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        labelText: "Email",
                        suffixIcon: Icon(Icons.mail_outline),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) =>
                          value.isEmpty ? "Password is required" : null,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        labelText: "Password",
                        suffixIcon: Icon(Icons.lock_outline),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () => Navigator.push(context,
                                SlideLeftRoute(page: ResetPasswordPage())),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 12.0, 0, 5.0),
                              child: Text(
                                "Forgot Password?",
                                textAlign: TextAlign.end,
                              ),
                            )),
                        Icon(Icons.arrow_right_alt_outlined)
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.18,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: RaisedButton(
                          color: Color(0xFFEF5B25),
                          onPressed: _onLoginButtonPressed,
                          child: Text(
                            'Sign in',
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
                      height: 50.0,
                    ),
                    _signInButton(context)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            print(result);

            BlocProvider.of<LoginBloc>(context).add(GoogleLoginButtonPressed(
                email: googleEmail, image: googleImageUrl, name: googleName));
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
