import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/slide_route_transition.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/checkout/cubit/checkout_cubit.dart';
import 'package:eatnaija/presentation/screens/checkout/order_success_page.dart';
import 'package:eatnaija/presentation/screens/update_address/update_address_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rave_flutter/rave_flutter.dart';

class CheckoutPage extends StatefulWidget {
  final int total;

  const CheckoutPage({Key key, this.total}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int delivery = 1000;
  double mysummary;
  CustomLoader _loader;
  String address, phone;
  UserDao userDao = UserDao();

  var user;

  String firstname,lastname;
  String email;

  @override
  void initState() {
    super.initState();
    _loader = CustomLoader(context);
    getUser();
    mysummary = double.parse(widget.total.toString()) +
        double.parse(delivery.toString());
    print(mysummary);
  }

  getUser() async {
    user = await userDao.getUser("nandom");

    var UserName =  user["name"].toString().split(" ");

    setState(() {
      // print(user["address"]);

      if((UserName?.length ?? 0) > 2 ){
        firstname = UserName[0];
        lastname = UserName[1];
      }
      email = user["email"];
      address = user["address"] != null ? user["address"].toString() : "";
      phone = user["phone"] != null ? user["phone"].toString() : "";

    });

    // setState(() {
    //   username = vendor["company_name"];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider<CheckoutCubit>(
      create: (context) => CheckoutCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Checkout"),
            backgroundColor: Resources.PRIMARY_COLOR,
          ),
          body: CubitListener<CheckoutCubit, CheckoutState>(
            listener: (context, state) {
              if (state is CheckoutLoadingState) {
                _loader.showLoader();
              }

              if (state is CheckoutSuccessState) {
                // _loader.hideLoader();
                print("Successfully sent");

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => OrderSuccessPage(orderId: state.checkoutResponse.orderNo,)),
                    (Route<dynamic> route) => false);
              }

              if (state is CheckoutFailedState) {
                _loader.hideLoader();
                print("Failed to send ${state.error.toString()}");
              }
            },
            child: SafeArea(
              child: CubitBuilder<CheckoutCubit, CheckoutState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 140.0,
                                  width:
                                      MediaQuery.of(context).size.width - 30.0,
                                  decoration: BoxDecoration(
                                      color: Resources.PRIMARY_COLOR,
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 18.0,
                                      right: 18.0,
                                      left: 18.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Delivery Address",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  _navigateAndDisplaySelection(
                                                      context),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 18.0,
                                              ),
                                              child: Text(
                                                phone != null
                                                    ? phone
                                                    : "No Phone number",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 18.0,
                                              ),
                                              child: Text(
                                                address != null
                                                    ? address
                                                    : "No address found",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width - 30.0,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Order:",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey[700])),
                                  Text("${Resources.NAIRA_SIGN}${widget.total}",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Resources.PRIMARY_COLOR)),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Delivery:",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey[700])),
                                  Text("${Resources.NAIRA_SIGN}$delivery",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Resources.PRIMARY_COLOR)),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Summary:",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey[700])),
                                  Text("${Resources.NAIRA_SIGN}$mysummary",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Resources.PRIMARY_COLOR)),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              InkWell(
                                onTap: () async {

                                  if(address.isEmpty){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Phone Number/Address is required'),
                                      backgroundColor: Resources.PRIMARY_COLOR,
                                    ));
                                    return;
                                  }

                                  RaveResult response =
                                      await startPayment(context);

                                  if (response.status == RaveStatus.success) {
                                    CubitProvider.of<CheckoutCubit>(context)
                                        .getCheckOut(user["address"],
                                            widget.total.toString());
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Failed to place order",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                child: Container(
                                  height: 50.0,
                                  width:
                                      MediaQuery.of(context).size.width - 30.0,
                                  decoration: BoxDecoration(
                                    color: Resources.PRIMARY_COLOR,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Checkout",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    Navigator.of(context)
        .push(
      MaterialPageRoute(builder: (context) => UpdateAddressPage()),
    )
        .then((value) {
      getUser();
    });

    // if (result != null) {
    //   setState(() {
    //     print(result);
    //     address = result.toString();
    //   });
    // } else {
    //   print("we are ready");
    // }
  }

  Future<RaveResult> startPayment(BuildContext context) async {
    var initializer = RavePayInitializer(
        amount: mysummary,
        publicKey: Resources.PUBLIC_KEY,
        encryptionKey: Resources.ENCRYPTION_KEY,
        subAccounts: null)
    ..acceptAchPayments = true
      ..companyName = Text("EatNaija")
      ..companyLogo = Image.asset("assets/images/eatnaija.png")
      ..country = "NG"
      ..currency = "NGN"
      ..email = email
      ..fName = firstname
      ..lName = lastname
      ..narration = 'Food payment'
      ..txRef = 'SJDF232323'
      ..orderRef = '23023LKLDS'
      ..acceptAccountPayments = true
      ..acceptCardPayments = true
      ..displayEmail = true
      ..displayAmount = true
      ..staging = false
      ..isPreAuth = true
      ..displayFee = true;


    var response = await RavePayManager()
        .prompt(context: context, initializer: initializer);
    print(response);
    return response;
  }
}
