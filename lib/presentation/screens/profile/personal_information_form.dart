import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/validators.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/profile/cubit/personal_information_cubit.dart';
import 'package:eatnaija/presentation/screens/update_address/cubit/update_address_cubit.dart';
import 'package:eatnaija/presentation/screens/update_address/update_address_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'states_page.dart';

class PersonalInformationForm extends StatefulWidget {
  final String callback;
  final changeMeeters;

  const PersonalInformationForm(callback, changeMeeters(String meeters))
      : this.callback = callback,
        this.changeMeeters = changeMeeters;

  @override
  State<PersonalInformationForm> createState() =>
      _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm>
    with TickerProviderStateMixin {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _autoValidate = false;

  UserDao userDao = UserDao();

  String myState;

  var user;
  String imageUrl = "";

  CustomLoader _loader;

  @override
  void initState() {
    super.initState();
    _autoValidate = false;
    _loader = CustomLoader(context);
    getUser();
  }

  getUser() async {
    user = await userDao.getUser("nandom");
    // print(userDao);

    var UserName = user["name"].toString().split(" ");

    setState(() {
      _fullNameController.text = user["name"];
      _phoneController.text = user["phone"];
      _emailController.text = user["email"];
      _addressController.text = user["address"];
      _cityController.text = user["city"];
      _stateController.text = user["state"];
    });
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      print("button clicked");
      if (_key.currentState.validate()) {
        var _loginBloc = CubitProvider.of<PersonalInformationCubit>(context)
            .updateUserProfileInformation(
                image: imageUrl,
                city: _cityController.text.toString(),
                phone: _phoneController.text.toString(),
                address: _addressController.text.toString());
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return CubitListener<PersonalInformationCubit, PersonalInformationState>(
      listener: (context, state) {
        if (state is PersonalInformationFailureState) {
          _loader.hideLoader();

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Resources.PRIMARY_COLOR,
          ));
        }
        if (state is PersonalInformationLoadingState) {
          _loader.showLoader();
        }
        if (state is PersonalInformationSuccessState) {
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
      },
      child: CubitBuilder<PersonalInformationCubit, PersonalInformationState>(
        builder: (context, state) {
          return Form(
            key: _key,
            autovalidate: _autoValidate,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 67.0,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    backgroundImage: user["image"] == null
                        ? AssetImage("assets/images/select_image.png")
                        : NetworkImage(user["image"]),
                    radius: 65.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 70,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                            labelText: 'Full Name',
                            icon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            )),
                        controller: _fullNameController,
                        validator: (value) =>
                            value.isEmpty ? "Full name is required" : null,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Phone',
                            icon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            )),
                        controller: _phoneController,
                        validator: (value) =>
                            value.isEmpty ? "Phone Number is required" : null,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            )),
                        controller: _emailController,
                        validator: validateEmail,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                            labelText: 'Address',
                            icon: Icon(
                              Icons.location_on_sharp,
                              color: Colors.grey,
                            )),
                        controller: _addressController,
                        validator: (value) =>
                            value.isEmpty ? "Address is required" : null,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                            labelText: 'City',
                            icon: Icon(
                              Icons.location_on_sharp,
                              color: Colors.grey,
                            )),
                        controller: _cityController,
                        validator: (value) =>
                            value.isEmpty ? "City is required" : null,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () async {
                          var results = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => StatesPage()));
                          if (results != null) {
                            // You code goes here.
                            setState(() {
                              _stateController.text = results;
                              myState = results;
                              print(myState);
                            });
                          }
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                                labelText: 'State',
                                icon: Icon(
                                  Icons.location_on_sharp,
                                  color: Colors.grey,
                                )),
                            controller: _stateController,
                            validator: (value) =>
                                value.isEmpty ? "State is required" : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: _onLoginButtonPressed,
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 18.0),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
