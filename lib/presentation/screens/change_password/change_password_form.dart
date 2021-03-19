
import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/Utils.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/presentation/screens/change_password/repository/change_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bloc/change_password_bloc.dart';

class ChangePasswordForm extends StatefulWidget {
  final BuildContext anotherContext;

  const ChangePasswordForm({Key key, this.anotherContext}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _confirmPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _passwordController = TextEditingController();

  ChangePasswordBloc _changePasswordBloc;

  final GlobalKey<FormState> _change_password_key = GlobalKey<FormState>();
  bool _autoValidate = false;

  ChangePasswordRepository changePasswordRepository =
      ChangePasswordRepository();

  CustomLoader _loader;

  @override
  void initState() {
    _loader = CustomLoader(context);
    _changePasswordBloc =
        ChangePasswordBloc(vendorRepository: changePasswordRepository);
    _confirmPasswordController.text = "";
    _newPasswordController.text = "";
    _passwordController.text = "";
    _autoValidate = false;
  }

  @override
  Widget build(BuildContext mycontext) {
    _onChangePasswordButtonPressed() {
      if (_change_password_key.currentState.validate()) {
        BlocProvider.of<ChangePasswordBloc>(context)
            .add(ChangePasswordButtonPressed(
          currentPassword: _passwordController.text,
          newPassword: _newPasswordController.text,
        ));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordFailureState) {
          _loader.hideLoader();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Resources.PRIMARY_COLOR,
          ));
        }
        if (state is ChangePasswordLoadingState) {
          _loader.showLoader();
        }
        if (state is ChangePasswordSuccessState) {
          _loader.hideLoader();
          Commons.hideKeyboard(context);
          if (state.changePasswordResponse.status == "false") {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${state.changePasswordResponse.message}'),
              backgroundColor: Resources.PRIMARY_COLOR,
              duration: Duration(seconds: 6),
            ));
          } else {

            _confirmPasswordController.text = "";
            _newPasswordController.text = "";
            _passwordController.text = "";
            _autoValidate = false;

            Fluttertoast.showToast(
                msg: "Password Changed successfully",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
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
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Old Password',
                      icon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      )),
                  controller: _passwordController,
                  validator: (value) =>
                      value.isEmpty ? "Old Password is required" : null,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'New Password',
                        icon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        )),
                    controller: _newPasswordController,
                    validator: (value) {
                      if (value.isEmpty)
                        return "New Password is required";
                      else if (value !=
                          _confirmPasswordController.text.toString())
                        return "Passwords do not match";
                      else
                        return null;
                    }),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        icon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        )),
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value.isEmpty)
                        return "New Password is required";
                      else if (value != _newPasswordController.text.toString())
                        return "Passwords do not match";
                      else
                        return null;
                    }),
                SizedBox(
                  height: 40.0,
                ),
                InkWell(
                  onTap: state is! ChangePasswordLoadingState
                      ? _onChangePasswordButtonPressed
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
              ],
            ),
          ),
        );
      }),
    );
  }
}
