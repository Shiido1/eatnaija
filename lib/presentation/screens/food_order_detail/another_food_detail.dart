import 'dart:async';

import 'package:eatnaija/presentation/screens/order_history/model/food_order_response.dart';
import 'package:flutter/material.dart';
import 'package:eatnaija/presentation/screens/order_history/model/order_history_response.dart';

class AnotherFoodDetail extends StatefulWidget {
  final Orderhistory foodRequests;

  AnotherFoodDetail({Key key, this.foodRequests}) : super(key: key);

  @override
  _AnotherFoodDetailState createState() => _AnotherFoodDetailState();
}

class _AnotherFoodDetailState extends State<AnotherFoodDetail> {
  StreamController streamController;

  String foodDeliveryStatus;
  int deliveryStatusInt;

  @override
  void initState() {
    super.initState();
    foodDeliveryStatus = "";
    streamController = StreamController();
    deliveryStatusInt = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.foodRequests.accept == "1" &&
        widget.foodRequests.delivered == "1" &&
        widget.foodRequests.reject == "0") {
      foodDeliveryStatus = "Delivered";
      deliveryStatusInt = 3;
      streamController.sink.add(3);
    } else if (widget.foodRequests.accept == "0" &&
        widget.foodRequests.delivered == "0" &&
        widget.foodRequests.reject == "0") {
      foodDeliveryStatus = "New Order";
      streamController.sink.add(1);
    } else if (widget.foodRequests.accept == "1" &&
        widget.foodRequests.delivered == "0" &&
        widget.foodRequests.reject == "0") {
      foodDeliveryStatus = "Processing";
      streamController.sink.add(2);
    } else {
      foodDeliveryStatus = "Rejected";
      streamController.sink.add(4);
    }

    return Scaffold(
        body: SafeArea(
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
                          InkWell(
                            onTap: () {
                              print("its working");
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
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
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18.0, right: 16.0, left: 16.0),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              child: Container(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            foodDeliveryStatus,
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
                                                  flex: 2,
                                                  child: Text(
                                                    "Order Number: ",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey
                                                            .withOpacity(0.7)),
                                                  )),
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                      widget
                                                          .foodRequests.orderNo,
                                                      style: TextStyle(
                                                          fontSize: 14.0))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "Delivery Address: ",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey
                                                            .withOpacity(0.7)),
                                                  )),
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                      widget.foodRequests
                                                          .address1,
                                                      style: TextStyle(
                                                          fontSize: 14.0))),
                                            ],
                                          ),
                                          Divider(
                                            height: 40.0,
                                            thickness: 0.5,
                                            color: Colors.grey[500],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    "${widget.foodRequests.product} (${widget.foodRequests.quantity}) ",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.grey
                                                            .withOpacity(0.7)),
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      "₦${widget.foodRequests.price}",
                                                      style: TextStyle(
                                                          fontSize: 14.0))),
                                            ],
                                          ),
                                          Divider(
                                            height: 40.0,
                                            thickness: 0.5,
                                            color: Colors.grey[500],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Text("Subtotal ",
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      "₦${widget.foodRequests.price}",
                                                      style: TextStyle(
                                                          fontSize: 14.0))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Text("Delivery Fee ",
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text("₦1000",
                                                      style: TextStyle(
                                                          fontSize: 14.0))),
                                            ],
                                          ),
                                          SizedBox(height: 20.0),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Text("Total ",
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.grey[800]
                                                              .withOpacity(0.9),
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text("₦${int.parse(widget.foodRequests.price) + 1000}",
                                                      style: TextStyle(
                                                          fontSize: 18.0))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          StreamBuilder<Object>(
                                              stream: streamController.stream,
                                              builder: (context, snapshot) {
                                                if (snapshot.data == 1) {
                                                  return Container();
                                                } else if (snapshot.data == 2) {
                                                  return Container();
                                                } else if (snapshot.data == 3) {
                                                  return Container();
                                                } else {
                                                  return Container();
                                                }
                                              }),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class ButtonRow extends StatefulWidget {
  final Orderhistory foodRequests;

  const ButtonRow({Key key, this.foodRequests}) : super(key: key);

  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: InkWell(
                onTap: () {
                  // BlocProvider.of<NewFoodOrderBloc>(context).add(
                  //     AcceptFoodRequestsEvent(
                  //         foodId: widget.foodRequests.id));
                },
                child: Container(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("New Order"),
                  )),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            )),
      ],
    );
  }
}

class DeliverButton extends StatefulWidget {
  final Orderhistory foodRequests;

  const DeliverButton({Key key, this.foodRequests}) : super(key: key);

  @override
  _DeliverButtonState createState() => _DeliverButtonState();
}

class _DeliverButtonState extends State<DeliverButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: InkWell(
                onTap: () {
                  if (widget.foodRequests.delivered != "1") {
                    // BlocProvider.of<NewFoodOrderBloc>(context).add(
                    //     AcceptFoodRequestsEvent(
                    //         foodId: widget.foodRequests.id));
                  }
                },
                child: Container(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(widget.foodRequests.delivered != "1"
                        ? "Deliver Food"
                        : "Food Request Delivered"),
                  )),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            )),
      ],
    );
  }
}
