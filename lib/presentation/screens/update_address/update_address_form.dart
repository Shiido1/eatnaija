import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/validators.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/update_address/cubit/update_address_cubit.dart';
import 'package:eatnaija/presentation/screens/update_address/place_service.dart';
import 'package:eatnaija/presentation/screens/update_address/update_address_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'location_search.dart';
import 'package:uuid/uuid.dart';

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
    print("getting user");
    user = await userDao.getUser("nandom");
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
                    ),                    
                    TextFormField(
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      controller: _usernameController,
                      onTap: () async{
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context)=> LocationSearch())
                          // );
                          // generate a new token here
                          final sessionToken = Uuid().v4();
                          final Suggestion result = await showSearch(
                            context: context,
                            delegate: LocationSearch(sessionToken),
                          );
                          // This will change the text displayed in the TextField
                          if (result != null) {
                            setState(() {
                               _usernameController.text = result.description;
                            });
                          }
                        },
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
                    SizedBox(height: 20.0,),

                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(color: Colors.grey, thickness: 1.0),
                          ),
                          Container(
                            width: 30,
                            child: Center(
                              child:
                                Text("or", style: TextStyle(color: Colors.grey)),
                              )
                          ),
                          Expanded(
                            child: Divider(color: Colors.grey, thickness: 1.0),
                          ),
                      ],),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10.0, // soften the shadow
                            spreadRadius: .0, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 10  horizontally
                              5.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      child: FlatButton(
                        onPressed: _determinePosition,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.grey.withOpacity(0.1),
                              width: 1,
                              style: BorderStyle.solid
                            ), 
                          borderRadius: BorderRadius.circular(50)
                          ),
                        child: Row(
                          children: [
                            Icon(Icons.location_searching, color: Colors.grey),
                            SizedBox(width: 10),
                            Text("Use current location", style: TextStyle(color: Colors.grey, fontSize: 14))
                          ],
                        )
                      )
                    ),
                    SizedBox(height: 20.0,),
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


  /// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }

  Position position = await Geolocator.getCurrentPosition();
  // Position positon2 = await Geolocator.;
  print(position);
  _getAddressFromLatLng(position.latitude,position.longitude);

  return position;
}

_getAddressFromLatLng(latitude, longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude
      );

      Placemark place = placemarks[0];
      setState(() {
              _usernameController.text = "${place.street}, ${place.locality},${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}.";
            });
      print("${place.street}, ${place.locality},${place.subAdministrativeArea}, ${place.postalCode}, ${place.administrativeArea}, ${place.country}");
      // setState(() {
      //   _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      // });
    } catch (e) {
      print(e);
    }
  }
}
