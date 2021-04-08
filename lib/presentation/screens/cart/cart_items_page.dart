import 'package:badges/badges.dart';
import 'package:eatnaija/cart_counter_cubit/cart_counter_cubit.dart';
import 'package:eatnaija/common/Utils.dart';
import 'package:eatnaija/common/app_state.dart';
import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_item_model.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_items_response.dart';
import 'package:eatnaija/presentation/screens/checkout/checkout_page.dart';
import 'package:eatnaija/presentation/screens/food_detail/bloc/add_to_cart_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eatnaija/common/globals.dart' as global;
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/presentation/screens/login/login_screen.dart';

import 'cubit/all_cart_items_cubit.dart';

class CartItemsPage extends StatefulWidget {
  @override
  _CartItemsPageState createState() => _CartItemsPageState();
}

class _CartItemsPageState extends State<CartItemsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List<AllCart> cartItems;
  // int total;
  double total;
  CustomLoader _loader;

  UserDao userDao = UserDao();

  String firstname;

  var user;

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
    total = 0;
    cartItems = List<AllCart>();
    _loader = CustomLoader(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return MultiCubitProvider(
        providers: [
          CubitProvider<CartCounterCubit>(
              create: (context) => CartCounterCubit()),
          CubitProvider<AllCartItemsCubit>(
            create: (context) => AllCartItemsCubit(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                "Cart",
              ),
              backgroundColor: Resources.PRIMARY_COLOR,
              actions: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Container(
                      height: 150.0,
                      width: 30.0,
                      child: new GestureDetector(
                        onTap: () {
                        print("display cart valut");
                        },
                        child: StreamBuilder(
                            // stream: global.numbersStream(),
                            stream: global.cartItemNumbers(),
                            initialData: GetIt.I<CartItemsModel>().getCartItemsNumber(),
                            builder: (context, snapshot) {
                              return new Stack(
                                children: <Widget>[
                                  // 5 == 0
                                  //     ? new Container()
                                  //     :
                                  Badge(
                                          badgeColor: Colors.red,
                                          badgeContent: Text(
                                            snapshot.data.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          child: Icon(Icons.shopping_cart),
                                        )
                                ],
                              );
                            }),
                      )),
                )
              ]),
          body: CubitListener<AllCartItemsCubit, AllCartItemsState>(
            listener: (context, state) {
              CartItemsModel dCart = GetIt.I<CartItemsModel>();
              global.streamController.sink.add(dCart.getCartItemsNumber());
              total = dCart.getTotalPrice();
              if (state is AllCartItemsFailureState)
                print("Error fetching carts");
              if (state is AddToCartItemsSuccess) {
                // total = 0;

                // appState.updateCart(state.cartResponse.items);

                // global.streamController.sink.add(state.cartResponse.items);


                print("I have added ${state}");

                // final cartItem = cartItems.firstWhere((item) =>
                //     item.productId ==
                //     state.cartResponse.cart.productId.toString());

                // cartItem.quantity = state.cartResponse.cart.quantity.toString();
                // cartItem.price = state.cartResponse.cart.price.toString();

                // cartItems.forEach((element) {
                //   int myprice = int.parse(element.price);
                //   total += myprice;
                // });

                _loader.hideLoader();
                Fluttertoast.showToast(
                    msg: "Cart updated",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
              if (state is SubtractFromCartItemsSuccess) {
                // total = 0;

                // appState.updateCart(state.cartResponse.items);

                // global.streamController.sink.add(state.cartResponse.items);
                // global.streamController.sink.add(dCart.getCartItemsNumber());

                // context
                //     .cubit<CartCounterCubit>()
                //     .setCartCount(state.cartResponse.items);
                //
                // final cartItem = cartItems.firstWhere((item) =>
                //     item.productId ==
                //     state.cartResponse.cart.productId.toString());
                //
                // cartItem.quantity = state.cartResponse.cart.quantity.toString();
                // cartItem.price = state.cartResponse.cart.price.toString();
                //
                // cartItems.forEach((element) {
                //   int myprice = int.parse(element.price);
                //   total += myprice;
                // });

                _loader.hideLoader();
                Fluttertoast.showToast(
                    msg: "Cart updated",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
              if (state is DeleteFromCartItemsSuccess) {
                // total = 0;

                // appState.updateCart(state.deleteResponse.items);
                //
                // global.streamController.sink.add(state.deleteResponse.items);
                //
                // final items = cartItems;
                //
                // context
                //     .cubit<CartCounterCubit>()
                //     .setCartCount(state.deleteResponse.items);
                //
                // cartItems.removeWhere(
                //     (element) => element.id.toString() == state.itemId);
                //
                // cartItems.forEach((element) {
                //   int myprice = int.parse(element.price);
                //   total += myprice;
                // });

                _loader.hideLoader();
                Fluttertoast.showToast(
                    msg: "Cart updated",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
              if (state is AddToCartItemsFailure) {
                _loader.hideLoader();

                Fluttertoast.showToast(
                    msg: "Failed to increment cart Item",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
              if (state is ManageCartLoading) {
                _loader.showLoader();
              }
            },
            child: CubitBuilder<AllCartItemsCubit, AllCartItemsState>(
              builder: (context, state) {
                CartItemsModel cart = GetIt.I<CartItemsModel>();
                List<Map<String,dynamic>> cItems = cart.getCartItems();
                int itemQuantity = cart.getCartItemsNumber();
                // print("state testing:");
                // print(cart.getCartItems());
                // print("price: "+ cart.getTotalPrice().toString());
                return Container(
                  child: itemQuantity < 1 ?
                        Container(child: Center(child: Text("No items to display"),),)
                        : Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: ListView.builder(
                        itemCount: cItems.length,
                        itemBuilder: (context,ind) {
                          return ListTile(
                            title: Text(cItems[ind]['item'].name),
                            trailing: Column(
                              children: [
                                Text("Quantity: "+cItems[ind]['quantity'].toString()),
                                SizedBox(height: 20,),
                                Text("Price: "+(cItems[ind]['quantity'] * double.parse(cItems[ind]['item'].price)).toString()),
                              ],
                            ),
                          );
                    }),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                      child: _checkoutButton(context, total),
                    ),
                  )
                ],
                ),
                );
                // if (state is AllCartItemsLoadingState) {
                //   return Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [Commons.loadingWidget("Loading Cart items")],
                //     ));
                // } else if (state is AllCartItemsSuccessState) {
                //   cartItems = state.cartItems;
                //
                //   cartItems.forEach((element) {
                //     int myprice = int.parse(element.price);
                //     total += myprice;
                //   });
                //
                //   return Container(
                //     height: MediaQuery.of(context).size.height,
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 18.0),
                //       child: RefreshIndicator(
                //         key: _refreshIndicatorKey,
                //         child: cartItems.isEmpty
                //             ? Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Row(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                         "assets/svgs/empty-cart.svg",
                //                         height: 100.0,
                //                         width: 100.0,
                //                         color: Colors.grey[600],
                //                       ),
                //                     ],
                //                   ),
                //                   SizedBox(height: 20.0),
                //                   Text(
                //                     "No Cart Items found",
                //                     style: TextStyle(
                //                         color: Colors.grey[600],
                //                         fontSize: 18.0),
                //                   ),
                //                 ],
                //               )
                //             : Container(
                //                 child: Column(
                //                   children: [
                //                     Expanded(
                //                       flex: 10,
                //                       child: ListView.builder(
                //                           itemCount: cartItems.length,
                //                           itemBuilder: (context, index) {
                //                             return cartItem(cartItems[index],
                //                                 index, context);
                //                           }),
                //                     ),
                //                     Expanded(
                //                         flex: 3,
                //                         child: Container(
                //                             width: MediaQuery.of(context)
                //                                     .size
                //                                     .width -
                //                                 30.0,
                //                             child: Column(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               children: [
                //                                 Column(
                //                                   children: [
                //                                     Row(
                //                                       mainAxisAlignment:
                //                                           MainAxisAlignment
                //                                               .spaceBetween,
                //                                       children: [
                //                                         Text(
                //                                           "Total",
                //                                           style: TextStyle(
                //                                               color: Colors
                //                                                   .grey[900],
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                         Text(
                //                                           "₦${total}",
                //                                           style: TextStyle(
                //                                               color: Resources
                //                                                   .PRIMARY_COLOR,
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                     SizedBox(
                //                                       height: 20.0,
                //                                     ),
                //                                     _checkoutButton(
                //                                         context, total)
                //                                   ],
                //                                 ),
                //                               ],
                //                             ))),
                //                   ],
                //                 ),
                //               ),
                //         onRefresh: () async {
                //           print("it refreshed");
                //           if (state is! AllCartItemsLoadingState) {
                //             total = 0;
                //             cartItems = [];
                //             CubitProvider.of<AllCartItemsCubit>(context)
                //                 .getAllCartItems();
                //           }
                //         },
                //       ),
                //     ),
                //   );
                // } else if (state is ManageCartLoading) {
                //   return Container(
                //     height: MediaQuery.of(context).size.height,
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 18.0),
                //       child: RefreshIndicator(
                //         key: _refreshIndicatorKey,
                //         child: cartItems.isEmpty
                //             ? Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Row(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                         "assets/svgs/empty-box.svg",
                //                         height: 100.0,
                //                         width: 100.0,
                //                         color: Colors.grey[600],
                //                       ),
                //                     ],
                //                   ),
                //                   SizedBox(height: 20.0),
                //                   Text(
                //                     "No Categories found",
                //                     style: TextStyle(
                //                         color: Colors.grey[600],
                //                         fontSize: 18.0),
                //                   ),
                //                 ],
                //               )
                //             : Container(
                //                 child: Column(
                //                   children: [
                //                     Expanded(
                //                       flex: 9,
                //                       child: ListView.builder(
                //                           itemCount: cartItems.length,
                //                           itemBuilder: (context, index) {
                //                             return cartItem(cartItems[index],
                //                                 index, context);
                //                           }),
                //                     ),
                //                     Expanded(
                //                         flex: 2,
                //                         child: Container(
                //                             width: MediaQuery.of(context)
                //                                     .size
                //                                     .width -
                //                                 30.0,
                //                             child: Column(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               children: [
                //                                 Column(
                //                                   children: [
                //                                     Row(
                //                                       mainAxisAlignment:
                //                                           MainAxisAlignment
                //                                               .spaceBetween,
                //                                       children: [
                //                                         Text(
                //                                           "Total",
                //                                           style: TextStyle(
                //                                               color: Colors
                //                                                   .grey[900],
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                         Text(
                //                                           // "₦${total}",
                //                                           "₦$total",
                //                                           style: TextStyle(
                //                                               color: Resources
                //                                                   .PRIMARY_COLOR,
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                     SizedBox(
                //                                       height: 20.0,
                //                                     ),
                //                                     _checkoutButton(
                //                                         context, total)
                //                                   ],
                //                                 ),
                //                               ],
                //                             ))),
                //                   ],
                //                 ),
                //               ),
                //         onRefresh: () async {
                //           print("it refreshed");
                //           if (state is! AllCartItemsLoadingState) {
                //             total = 0;
                //             cartItems = [];
                //             CubitProvider.of<AllCartItemsCubit>(context)
                //                 .getAllCartItems();
                //           }
                //         },
                //       ),
                //     ),
                //   );
                // } else if (state is AddToCartItemsSuccess) {
                //   return Container(
                //     height: MediaQuery.of(context).size.height,
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 18.0),
                //       child: RefreshIndicator(
                //         key: _refreshIndicatorKey,
                //         child: cartItems.isEmpty
                //             ? Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Row(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                         "assets/svgs/empty-box.svg",
                //                         height: 100.0,
                //                         width: 100.0,
                //                         color: Colors.grey[600],
                //                       ),
                //                     ],
                //                   ),
                //                   SizedBox(height: 20.0),
                //                   Text(
                //                     "No Categories found",
                //                     style: TextStyle(
                //                         color: Colors.grey[600],
                //                         fontSize: 18.0),
                //                   ),
                //                 ],
                //               )
                //             : Container(
                //                 child: Column(
                //                   children: [
                //                     Expanded(
                //                       flex: 9,
                //                       child: ListView.builder(
                //                           itemCount: cartItems.length,
                //                           itemBuilder: (context, index) {
                //                             return cartItem(cartItems[index],
                //                                 index, context);
                //                           }),
                //                     ),
                //                     Expanded(
                //                         flex: 2,
                //                         child: Container(
                //                             width: MediaQuery.of(context)
                //                                     .size
                //                                     .width -
                //                                 30.0,
                //                             child: Column(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               children: [
                //                                 Column(
                //                                   children: [
                //                                     Row(
                //                                       mainAxisAlignment:
                //                                           MainAxisAlignment
                //                                               .spaceBetween,
                //                                       children: [
                //                                         Text(
                //                                           "Total",
                //                                           style: TextStyle(
                //                                               color: Colors
                //                                                   .grey[900],
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                         Text(
                //                                           "₦${total}",
                //                                           style: TextStyle(
                //                                               color: Resources
                //                                                   .PRIMARY_COLOR,
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                     SizedBox(
                //                                       height: 20.0,
                //                                     ),
                //                                     _checkoutButton(
                //                                         context, total)
                //                                   ],
                //                                 ),
                //                               ],
                //                             ))),
                //                   ],
                //                 ),
                //               ),
                //         onRefresh: () async {
                //           print("it refreshed");
                //           if (state is! AllCartItemsLoadingState) {
                //             total = 0;
                //             cartItems = [];
                //             CubitProvider.of<AllCartItemsCubit>(context)
                //                 .getAllCartItems();
                //           }
                //         },
                //       ),
                //     ),
                //   );
                // } else if (state is SubtractFromCartItemsSuccess) {
                //   return Container(
                //     height: MediaQuery.of(context).size.height,
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 18.0),
                //       child: RefreshIndicator(
                //         key: _refreshIndicatorKey,
                //         child: cartItems.isEmpty
                //             ? Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Row(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                         "assets/svgs/empty-box.svg",
                //                         height: 100.0,
                //                         width: 100.0,
                //                         color: Colors.grey[600],
                //                       ),
                //                     ],
                //                   ),
                //                   SizedBox(height: 20.0),
                //                   Text(
                //                     "No Categories found",
                //                     style: TextStyle(
                //                         color: Colors.grey[600],
                //                         fontSize: 18.0),
                //                   ),
                //                 ],
                //               )
                //             : Container(
                //                 child: Column(
                //                   children: [
                //                     Expanded(
                //                       flex: 9,
                //                       child: ListView.builder(
                //                           itemCount: cartItems.length,
                //                           itemBuilder: (context, index) {
                //                             return cartItem(cartItems[index],
                //                                 index, context);
                //                           }),
                //                     ),
                //                     Expanded(
                //                         flex: 2,
                //                         child: Container(
                //                             width: MediaQuery.of(context)
                //                                     .size
                //                                     .width -
                //                                 30.0,
                //                             child: Column(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               children: [
                //                                 Column(
                //                                   children: [
                //                                     Row(
                //                                       mainAxisAlignment:
                //                                           MainAxisAlignment
                //                                               .spaceBetween,
                //                                       children: [
                //                                         Text(
                //                                           "Total",
                //                                           style: TextStyle(
                //                                               color: Colors
                //                                                   .grey[900],
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                         Text(
                //                                           "₦${total}",
                //                                           style: TextStyle(
                //                                               color: Resources
                //                                                   .PRIMARY_COLOR,
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                     SizedBox(
                //                                       height: 20.0,
                //                                     ),
                //                                     _checkoutButton(
                //                                         context, total)
                //                                   ],
                //                                 ),
                //                               ],
                //                             ))),
                //                   ],
                //                 ),
                //               ),
                //         onRefresh: () async {
                //           print("it refreshed");
                //           if (state is! AllCartItemsLoadingState) {
                //             total = 0;
                //             cartItems = [];
                //             CubitProvider.of<AllCartItemsCubit>(context)
                //                 .getAllCartItems();
                //           }
                //         },
                //       ),
                //     ),
                //   );
                // } else if (state is DeleteFromCartItemsSuccess) {
                //   return Container(
                //     height: MediaQuery.of(context).size.height,
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 18.0),
                //       child: RefreshIndicator(
                //         key: _refreshIndicatorKey,
                //         child: cartItems.isEmpty
                //             ? Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   Row(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       SvgPicture.asset(
                //                         "assets/svgs/empty-box.svg",
                //                         height: 100.0,
                //                         width: 100.0,
                //                         color: Colors.grey[600],
                //                       ),
                //                     ],
                //                   ),
                //                   SizedBox(height: 20.0),
                //                   Text(
                //                     "No Food Items found",
                //                     style: TextStyle(
                //                         color: Colors.grey[600],
                //                         fontSize: 18.0),
                //                   ),
                //                 ],
                //               )
                //             : Container(
                //                 child: Column(
                //                   children: [
                //                     Expanded(
                //                       flex: 9,
                //                       child: ListView.builder(
                //                           itemCount: cartItems.length,
                //                           itemBuilder: (context, index) {
                //                             return cartItem(cartItems[index],
                //                                 index, context);
                //                           }),
                //                     ),
                //                     Expanded(
                //                         flex: 2,
                //                         child: Container(
                //                             width: MediaQuery.of(context)
                //                                     .size
                //                                     .width -
                //                                 30.0,
                //                             child: Column(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               children: [
                //                                 Column(
                //                                   children: [
                //                                     Row(
                //                                       mainAxisAlignment:
                //                                           MainAxisAlignment
                //                                               .spaceBetween,
                //                                       children: [
                //                                         Text(
                //                                           "Total",
                //                                           style: TextStyle(
                //                                               color: Colors
                //                                                   .grey[900],
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                         Text(
                //                                           "₦${total}",
                //                                           style: TextStyle(
                //                                               color: Resources
                //                                                   .PRIMARY_COLOR,
                //                                               fontSize: 22.0,
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .bold),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                     SizedBox(
                //                                       height: 20.0,
                //                                     ),
                //                                     _checkoutButton(
                //                                         context, total)
                //                                   ],
                //                                 ),
                //                               ],
                //                             ))),
                //                   ],
                //                 ),
                //               ),
                //         onRefresh: () async {
                //           print("it refreshed");
                //           if (state is! AllCartItemsLoadingState) {
                //             total = 0;
                //             cartItems = [];
                //             CubitProvider.of<AllCartItemsCubit>(context)
                //                 .getAllCartItems();
                //           }
                //         },
                //       ),
                //     ),
                //   );
                // } else {
                //   return Center(
                //     child: Text("Error loading My categories"),
                //   );
                // }
              },
            ),
          ),
        ));
  }

  Widget _checkoutButton(BuildContext context, double total) {
    return InkWell(
      onTap: () => _navigateToCheckout(context, total),
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width - 30.0,
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
    );
  }

  _navigateToCheckout(BuildContext context, double total) {
    print("we are here");
    final authState = Provider.of<AuthenticationBloc>(context,listen: false).state;
    if(authState is AuthenticationAuthenticated){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CheckoutPage(total: total)));
    }else{
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginScreen(fromCheckout: true,)));
    }
    // if(appState.)

  }

  Widget cartItem(AllCart cart, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: InkWell(
        onTap: () {
          print(cart);
        },
        child: Container(
            height: 200.0,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Card(
                    elevation: 4.0,
                    child: Container(
                      height: 170.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 18.0, top: 65.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cart.productName,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () => _showConfirmationAlert(
                                      context, cart.id.toString()),
                                  child: Icon(
                                    Icons.delete_forever_rounded,
                                    color: Resources.PRIMARY_COLOR,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () => int.parse(cart.quantity) >
                                                1
                                            ? CubitProvider.of<
                                                    AllCartItemsCubit>(context)
                                                .subtractFromCartItems(
                                                    cart.productId)
                                            : null,
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: int.parse(cart.quantity) > 1
                                              ? Resources.PRIMARY_COLOR
                                              : Resources.PRIMARY_COLOR
                                                  .withOpacity(0.4),
                                          size: 28.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        cart.quantity,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          CubitProvider.of<AllCartItemsCubit>(
                                                  context)
                                              .addToCartCartItems(
                                                  cart.productId);
                                        },
                                        child: Icon(
                                          Icons.add_circle,
                                          color: Resources.PRIMARY_COLOR,
                                          size: 28.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "₦${cart.price}",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20.0),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 51.0,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(cart.image),
                        radius: 50.0,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  _showConfirmationAlert(BuildContext context, String id) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text("Are you Sure?"),
        content: Text("Are you sure you want to delete this item?."),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          BasicDialogAction(
            title: Text("Delete Food"),
            onPressed: () {
              Navigator.pop(context);
              _onDeleteConfirmed(context, id);
            },
          ),
        ],
      ),
    );
  }

  void _onDeleteConfirmed(BuildContext context, String id) {
    CubitProvider.of<AllCartItemsCubit>(context).deleteFromCartItems(id);
  }
}
