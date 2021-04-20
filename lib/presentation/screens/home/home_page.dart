import 'package:badges/badges.dart';
import 'package:eatnaija/cart_counter_cubit/cart_counter_cubit.dart';
import 'package:eatnaija/common/app_state.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/cart/cart_items_page.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_item_model.dart';
import 'package:eatnaija/presentation/screens/food_detail/bloc/add_to_cart_cubit.dart';
import 'package:eatnaija/presentation/screens/home/home_screen.dart';
import 'package:eatnaija/presentation/screens/order_history/food_order_page.dart';
import 'package:eatnaija/presentation/screens/profile/profile_page.dart';
import 'package:eatnaija/common/globals.dart' as globals;

/// Flutter code sample for BottomNavigationBar

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

/// This is the stateful widget that the main application instantiates.
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

/// This is the private State class that goes with HomePage.
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  UserDao userDao = UserDao();

  String firstname;

  var user;
  int cartItems;
  String title = "Home";

  getUser() async {
    user = await userDao.getUser("nandom");
    // print(userDao);

    var UserName = user["name"].toString().split(" ");

    setState(() {
      firstname = UserName[0];
      cartItems = user["cart"];
    });

    // setState(() {
    //   username = vendor["company_name"];
    // });
  }

  @override
  void initState() {
    if (user != null) {
      getUser();
    } else {
      return;
    }
    super.initState();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(cartItems, (val) {
        setState(() {
          cartItems = val;
          // print(cartItems);
          if (val != null) {
            Navigator.of(context).pop({'selection': cartItems});
          }
        });
      }),
      FoodOrderPage(),
      ProfilePage(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;

        if (index == 0) {
          title = "Home";
        } else if (index == 1)
          title = "Order History";
        else if (index == 2) title = "Account";

        _widgetOptions[_selectedIndex];
      });
    }

    return CubitProvider(
      // create: (context) => CartCounterCubit(),
      // child: CubitListener<CartCounterCubit, CartCounterState>(
      //   listener: (context, state) {
      //     if (state.cartCount == 0) {
      //       print("Cart number is ${state.cartCount}");
      //     } else {
      //       print("Cart is ${state.cartCount}");
      //     }
      //   },
    create: (context) => AddToCartCubit(),
    child: CubitListener<AddToCartCubit, AddToCartState>(
      listener: (context, state) {},
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Resources.PRIMARY_COLOR,
              title: Text(title),
              actions: <Widget>[
                new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Container(
                      height: 150.0,
                      width: 30.0,
                      child: new GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new CartItemsPage()));
                          },
                          child: StreamBuilder<int>(
                            // stream: global.numbersStream(),
                              stream: globals.cartItemNumbers(),
                              initialData: GetIt.I<CartItemsModel>().getCartItemsNumber(),
                              builder: (context, snapshot) {
                                return new Stack(
                                  children: <Widget>[
                                    Badge(
                                      badgeColor: Colors.red,
                                      badgeContent: Text(
                                        snapshot.data.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      child: Icon(Icons.shopping_cart),
                                    )
                                    // 5 == 0
                                    //     ? new Container()
                                    //     : Badge(
                                    //         badgeColor: Colors.red,
                                    //         badgeContent: Text(
                                    //           snapshot.data.toString(),
                                    //           style: TextStyle(color: Colors.white),
                                    //         ),
                                    //         child: Icon(Icons.shopping_cart),
                                    //       )
                                  ],
                                );
                              }),
                          // StreamBuilder(
                          //     stream: globals.numbersStream(),
                          //     builder: (context, snapshot) {
                          //       return Stack(
                          //         children: <Widget>[
                          //           5 == 0
                          //               ? new Container()
                          //               : Badge(
                          //                   badgeColor: Colors.red,
                          //                   badgeContent: Text(
                          //                     snapshot.data.toString(),
                          //                     style: TextStyle(
                          //                         color: Colors.white),
                          //                   ),
                          //                   child: Icon(Icons.shopping_cart),
                          //                 )
                          //         ],
                          //       );
                          //     })
                      ),
                    )),
              ]),
          body: SingleChildScrollView(
            child: Column(children: [_widgetOptions.elementAt(_selectedIndex)]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Resources.PRIMARY_COLOR,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood_outlined),
                label: 'Order History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'My Account',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
