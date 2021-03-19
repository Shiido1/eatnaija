import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/validators.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/update_address/cubit/update_address_cubit.dart';
import 'package:eatnaija/presentation/screens/update_address/update_address_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateAddressForm extends StatefulWidget {
  final String callback;
  final changeMeeters;

  const UpdateAddressForm(callback, changeMeeters(String meeters))
      : this.callback = callback,
        this.changeMeeters = changeMeeters;

  @override
  State<UpdateAddressForm> createState() => _UpdateAddressFormState();
}

class _UpdateAddressFormState extends State<UpdateAddressForm>
    with TickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _autoValidate = false;

  UserDao userDao = UserDao();
  String address;
  String phone;

  CustomLoader _loader;

  @override
  void initState() {
    _autoValidate = false;
    _loader = CustomLoader(context);
    super.initState();
    getUser();
  }

  var user;


  getUser() async {
    user = await userDao.getUser("nandom");
    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    print(user);


    setState(() {
      address = user["address"] != null ? user["address"] : "";
      phone = user["phone"] != null ? user["phone"] : "";

      _phoneController.text = phone;
      _usernameController.text = address;
    });

    // setState(() {
    //   username = vendor["company_name"];
    // });
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      if (_key.currentState.validate()) {
        var _loginBloc = CubitProvider.of<UpdateAddressCubit>(context)
            .updateAddress(_usernameController.text.toString(), _phoneController.text.toString());
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return CubitListener<UpdateAddressCubit, UpdateAddressState>(
      listener: (context, state) {
        if (state is UpdateAddressFailureState) {
          _loader.hideLoader();

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Resources.PRIMARY_COLOR,
          ));
        }

        if (state is UpdateAddressLoadingState) {
          _loader.showLoader();
        }
        if (state is UpdateAddressSuccessState) {
          _loader.hideLoader();
          widget.changeMeeters(state.user.address);

          Fluttertoast.showToast(
              msg: "Address Updated successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        // if(state is LoginInitial){
        //   _loader.hideLoader();
        // }
      },
      child: CubitBuilder<UpdateAddressCubit, UpdateAddressState>(
        builder: (context, state) {
          return Container(
            child: Form(
              key: _key,
              autovalidate: _autoValidate,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      validator: (value) =>
                          value.isEmpty ? "Phone number is required" : null,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        hintText: "Enter Phone Number",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),                    TextFormField(
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      controller: _usernameController,
                      validator: (value) =>
                          value.isEmpty ? "Address is required" : null,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        hintText: "Enter Delivery Address",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
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
                          onPressed: _onLoginButtonPressed,
                          child: Text(
                            'Update',
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
}
