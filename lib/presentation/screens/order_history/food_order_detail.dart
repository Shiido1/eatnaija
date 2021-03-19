import 'package:flutter/cupertino.dart';
import 'package:eatnaija/presentation/screens/order_history/model/food_order_response.dart';
import 'package:flutter/material.dart';

class FoodOrderDetail extends StatefulWidget {
  final Requests foodRequests;

  const FoodOrderDetail({Key key, this.foodRequests}) : super(key: key);

  @override
  _FoodOrderDetailState createState() => _FoodOrderDetailState();
}

class _FoodOrderDetailState extends State<FoodOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              onTap: () {
                                print("its working");
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.foodRequests.product,
                            style: TextStyle(
                                fontSize: 28.0,
                                fontFamily: "Metropolis",
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.dstATop),
                        image: AssetImage("assets/images/food_image_bg.jpg"),
                        fit: BoxFit.cover)),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Card(
                          color: Colors.grey[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.grey, width: 1.0)),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 70.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Delivering",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Order Number: ",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white
                                                        .withOpacity(0.7)),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Text("#4FKD3239329",
                                                  style: TextStyle(
                                                      fontSize: 16.0))),
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text("Bottom side"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
