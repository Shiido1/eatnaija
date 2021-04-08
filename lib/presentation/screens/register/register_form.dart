import 'package:eatnaija/common/Utils.dart';
import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/validators.dart';
import 'package:eatnaija/presentation/screens/otp_verify/otp_verify_page.dart';
import 'package:eatnaija/presentation/screens/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';



class RegisterForm extends StatefulWidget {
  final bool fromCheckOut;
  RegisterForm({this.fromCheckOut});
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with TickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityContoller = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _autoValidate = false;

  CustomLoader _loader;


  @override
  void initState() {
    _autoValidate = false;
    _loader = CustomLoader(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _registerButtonPressed() {
      if (_key.currentState.validate()) {
        var _loginBloc =
            BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(
          name: _nameController.text,
          password: _passwordController.text.toString(),
          email: _emailController.text.toString(),
          city: _cityContoller.text,
          phone: _phoneController.text,
        ));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailureState) {
          _loader.hideLoader();

          Commons.hideKeyboard(context);

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Resources.PRIMARY_COLOR,
          ));
        }

        if (state is RegisterLoadingState) {
          _loader.showLoader();
        }

        if (state is RegisterCompleteState) {
          _loader.hideLoader();

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => OtpVerifyPage(otp: state.registerResponse.otp.toString(),
                    fromCheckOut: widget.fromCheckOut,)),
              (Route<dynamic> route) => false);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
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
                    nameField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    emailField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    phoneField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    cityField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    passwordField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.18,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: RaisedButton(
                          color: Color(0xFFEF5B25),
                          onPressed: _registerButtonPressed,
                          child: Text(
                            'Signup',
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
                      height: 10.0,
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

  TextFormField passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      autofocus: false,
      validator: (value) => value.isEmpty ? "Password is required" : null,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
    );
  }

  TextFormField emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: validateEmail,
      autofocus: false,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
    );
  }

  TextFormField cityField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _cityContoller,
      autofocus: false,
      validator: (value) => value.isEmpty ? "City is required" : null,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        labelText: "City",
        suffixIcon: Icon(Icons.location_on_sharp),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
    );
  }

  TextFormField nameField() {
    return TextFormField(
      autofocus: false,
      keyboardType: TextInputType.name,
      controller: _nameController,
      validator: (value) => value.isEmpty ? "Full Name is required" : null,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        labelText: "Full Name",
        suffixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
    );
  }

  TextFormField phoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _phoneController,
      autofocus: false,
      validator: validatePhone,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        labelText: "Phone Number",
        suffixIcon: Icon(Icons.phone),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
    );
  }

  TextFormField addressField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _nameController,
      validator: validateEmail,
      autofocus: false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        labelText: "Address",
        suffixIcon: Icon(Icons.mail_outline),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
    );
  }
}
