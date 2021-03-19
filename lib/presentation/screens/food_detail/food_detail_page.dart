import 'package:badges/badges.dart';
import 'package:eatnaija/common/Utils.dart';
import 'package:eatnaija/common/app_state.dart';
import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/cart/cart_items_page.dart';
import 'package:eatnaija/presentation/screens/food_detail/bloc/add_to_cart_cubit.dart';
import 'package:eatnaija/presentation/screens/restaurant_foods/model/get_all_restaurant_food_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:eatnaija/presentation/screens/login/login_screen.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:eatnaija/common/globals.dart' as global;

class FoodDetailPage extends StatefulWidget {
  final Menu foodItem;

  const FoodDetailPage({Key key, this.foodItem}) : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  final oCcy = new NumberFormat("#,##0.0", "en_US");
  UserRepository _userRepository = UserRepository();

  CustomLoader _loader;

  var cartItems;

  UserDao userDao = UserDao();

  String firstname;

  var user;

  @override
  void initState() {
    super.initState();
    _loader = CustomLoader(context);
    // getUser();
  }

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
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    appState.getCart;

    return CubitProvider<AddToCartCubit>(
      create: (context) => AddToCartCubit(id: widget.foodItem.id.toString()),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Resources.PRIMARY_COLOR,
            title: Text("Food Detail"),
            actions: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Container(
                    height: 150.0,
                    width: 30.0,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new CartItemsPage()))
                            .then((value) => getUser());
                      },
                      child: StreamBuilder(
                          stream: global.numbersStream(),
                          builder: (context, snapshot) {
                            return new Stack(
                              children: <Widget>[
                                5 == 0
                                    ? new Container()
                                    : Badge(
                                        badgeColor: Colors.red,
                                        badgeContent: Text(
                                          snapshot.data.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        child: Icon(Icons.shopping_cart),
                                      )
                              ],
                            );
                          }),
                    )),
              )
            ]),
        body: CubitListener<AddToCartCubit, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartLoadingState) {
              _loader.showLoader();
            }
            if (state is AddToCartSuccessState) {
              _loader.hideLoader();

              appState.updateCart(state.cart.items);
              global.streamController.sink.add(state.cart.items);

              Fluttertoast.showToast(
                  msg: "Food Added to Cart",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            if (state is AddToCartFailedState) {
              _loader.hideLoader();

              Fluttertoast.showToast(
                  msg: "Failed to Add to cart",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          child: CubitBuilder<AddToCartCubit, AddToCartState>(
              builder: (context, state) {
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Hero(
                        tag: widget.foodItem.createdAt,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(Commons.formatImageUrl(
                                        widget.foodItem.image)),
                                    fit: BoxFit.cover))),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.foodItem.name,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Category:",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      widget.foodItem.category,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Resources.PRIMARY_COLOR),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 7,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "₦${oCcy.format(double.parse(widget.foodItem.price))}",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              widget.foodItem.description,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                dynamic vendor =
                                    await userDao.getUser("nandom");
                                print(vendor);
                                if (vendor != null) {
                                  CubitProvider.of<AddToCartCubit>(context)
                                      .addToCart();
                                  print("k");
                                } else {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LoginScreen(
                                                  userRepository:
                                                      _userRepository,
                                                  foodItem: widget.foodItem)),
                                      (Route<dynamic> route) => false);
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_shopping_cart_outlined,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Text("Add to Cart",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white))
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Resources.PRIMARY_COLOR,
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
