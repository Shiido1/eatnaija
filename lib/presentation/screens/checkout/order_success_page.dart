import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/presentation/screens/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class OrderSuccessPage extends StatefulWidget {

  final String orderId;

  const OrderSuccessPage({Key key, this.orderId}) : super(key: key);

  @override
  _OrderSuccessPageState createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Image.asset(
                    "assets/images/eatnaija_logo.png",
                    height: 120.0,
                    width: 120.0,
                  )),
              Expanded(
                  flex: 4,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 70,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 50.0,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              "THANK YOU FOR VISITING EATNAIJA",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Your Transaction was successful",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Order ID:",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  widget.orderId,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 60.0,
                          width: MediaQuery.of(context).size.width - 70,
                          decoration: DottedDecoration(
                              shape: Shape.box,
                              color: Colors.green,
                              strokeWidth: 3),
                          child: Center(
                              child: Text(
                            'SHOW THIS SCREEN TO VENDOR',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.green),
                          ))),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()));
                        },
                        child: Container(
                          height: 60.0,
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Center(
                            child: Text(
                              'Back to Home',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Resources.PRIMARY_COLOR
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
