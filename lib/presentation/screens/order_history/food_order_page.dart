import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/presentation/screens/order_history/new_food_order/new_food_order.dart';
import 'package:eatnaija/presentation/screens/order_history/processing_food_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'delivered_food_order.dart';

class FoodOrderPage extends StatefulWidget {
  @override
  _FoodOrderPageState createState() => _FoodOrderPageState();
}

class _FoodOrderPageState extends State<FoodOrderPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height - 100.0,
      child: Column(
        children: [

          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: Resources.PRIMARY_COLOR,
                  isScrollable: false,
                  labelPadding: EdgeInsets.only(right: 10.0),
                  unselectedLabelColor: Color(0xFFCDCDCD),
                  unselectedLabelStyle: TextStyle(
                    color: Color(0xFFCDCDCD),
                  ),
                  tabs: [
                    Tab(
                      child: Center(
                        child: Text(
                          "New Orders",
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 19.0,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'Processing',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 19.0,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          'Delivered',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 19.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 10,
              child: Center(
                child: ListView(
                  padding: EdgeInsets.only(left: 16.0),
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height - 50,
                      width: double.infinity,
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          NewFoodOrderPage(),
                          ProcessingFoodOrderPage(),
                          DeliveredFoodOrderPage(),
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
