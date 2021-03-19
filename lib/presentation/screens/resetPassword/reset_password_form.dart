import 'package:eatnaija/common/Utils.dart';
import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/presentation/screens/change_password/repository/change_password_repository.dart';
import 'package:eatnaija/presentation/screens/resetPassword/cubit/reset_password_cubit.dart';
import 'package:eatnaija/presentation/screens/resetPassword/cubit/reset_password_cubit.dart';
import 'package:eatnaija/presentation/screens/resetPassword/cubit/reset_password_cubit.dart';
import 'package:eatnaija/presentation/screens/resetPassword/cubit/reset_password_cubit.dart';
import 'package:eatnaija/presentation/screens/resetPassword/cubit/reset_password_cubit.dart';
import 'package:eatnaija/presentation/screens/resetPassword/repository/reset_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPasswordForm extends StatefulWidget {
  final BuildContext anotherContext;

  const ResetPasswordForm({Key key, this.anotherContext}) : super(key: key);

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {

  final _emailController = TextEditingController();

  ResetPasswordCubit _resetPasswordBloc;

  final GlobalKey<FormState> _change_password_key = GlobalKey<FormState>();
  bool _autoValidate = false;

  ResetPasswordRepository resetPasswordRepository = ResetPasswordRepository();

  CustomLoader _loader;

  @override
  void initState() {
    _loader = CustomLoader(context);
    _resetPasswordBloc = ResetPasswordCubit();
    _emailController.text = "";
    _autoValidate = false;
  }

  @override
  Widget build(BuildContext mycontext) {
    _onResetPasswordButtonPressed() {
      if (_change_password_key.currentState.validate()) {

        var myemail =  _emailController.text.toString();
        CubitProvider.of<ResetPasswordCubit>(context).getAllCategories(
          email: myemail.toString(),
        );
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return CubitListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordFailureState) {
          _loader.hideLoader();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Resources.PRIMARY_COLOR,
          ));
        }
        if (state is ResetPasswordLoadingState) {
          _loader.showLoader();
        }
        if (state is ResetPasswordSuccessState) {
          _loader.hideLoader();
          Commons.hideKeyboard(context);
          if (state.resetPasswordResponse.status == "false") {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${state.resetPasswordResponse.message}'),
              backgroundColor: Resources.PRIMARY_COLOR,
              duration: Duration(seconds: 4),
            ));
          } else {
            _emailController.text = "";
            _autoValidate = false;

            Fluttertoast.showToast(
                msg: "Reset password email sent successfully",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      child: CubitBuilder<ResetPasswordCubit, ResetPasswordState>(
          builder: (context, state) {
        return Form(
          key: _change_password_key,
          autovalidate: _autoValidate,
          child: Container(
            width: MediaQuery.of(context).size.width - 70,
            child: Column(
              children: [
                TextFormField(
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  controller: _emailController,
                  validator: (value) =>
                      value.isEmpty ? "Email is required" : null,
                ),
                SizedBox(
                  height: 40.0,
                ),
                InkWell(
                  onTap: state is! ResetPasswordLoadingState
                      ? _onResetPasswordButtonPressed
                      : null,
                  child: Container(
                    width: 250.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Resources.PRIMARY_COLOR),
                    child: Center(
                        child: Text(
                      "Submit",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: Colors.white,
                          fontSize: 18.0),
                    )),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                        quarterTurns: 2,
                        child: Icon(Icons.arrow_right_alt_outlined)),
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "Back to Login",
                          textAlign: TextAlign.end,
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
