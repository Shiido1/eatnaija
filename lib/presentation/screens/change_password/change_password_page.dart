
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/change_password/repository/change_password_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/change_password_bloc.dart';
import 'change_password_form.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: Resources.PRIMARY_COLOR,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: BlocProvider<ChangePasswordBloc>(
        create: (context) {
          return ChangePasswordBloc(vendorRepository: changePasswordRepository);
        },
        child: SafeArea(
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30.0,),
                      ChangePasswordForm(anotherContext: context)],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
