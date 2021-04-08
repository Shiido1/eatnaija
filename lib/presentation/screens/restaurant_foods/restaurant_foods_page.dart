import 'dart:async';

import 'package:badges/badges.dart';
import 'package:eatnaija/common/Utils.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_cafe_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_company_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_equipment_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_port_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_restaurants_response.dart';
import 'package:eatnaija/presentation/screens/cart/cart_items_page.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_item_model.dart';
import 'package:eatnaija/presentation/screens/food_detail/food_detail_page.dart';
import 'package:eatnaija/presentation/screens/restaurant_foods/model/get_all_restaurant_food_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:eatnaija/common/globals.dart' as global;
import 'package:get_it/get_it.dart';

import 'cubit/restaurant_foods_cubit.dart';

class RestaurantFoodPage extends StatefulWidget {
  final Restaurants myrestaurants;
  final FoodCompany foodCompany;
  final FoodEquipment foodEquipment;
  final Cafe cafe;
  final FoodPort foodPort;
  final int index;

  const RestaurantFoodPage(
      {Key key,
      this.myrestaurants,
      this.foodCompany,
      this.foodEquipment,
      this.cafe,
      this.foodPort,
      @required this.index})
      : super(key: key);

  @override
  _RestaurantFoodPageState createState() => _RestaurantFoodPageState();
}

class _RestaurantFoodPageState extends State<RestaurantFoodPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var restaurants;

  var cartItems;

  UserDao userDao = UserDao();

  String firstname;

  var user;

  @override
  void initState() {
    super.initState();
    // restaurants = widget.myrestaurants;
    // getUser();
    print(widget.index);

    switch (widget.index) {
      case 1:
        restaurants = widget.myrestaurants;
        break;
      case 2:
        restaurants = widget.foodPort;
        break;
      case 3:
        restaurants = widget.cafe;
        break;
      case 4:
        restaurants = widget.cafe;
        break;
      case 5:
        restaurants = widget.foodCompany;
        break;
      default:
        restaurants = widget.foodEquipment;
    }
    print(restaurants);
  }

  getUser() async {
    user = await userDao.getUser("nandom");
    // print(userDao);

    var UserName = user==null? "Guest": user["name"].toString().split(" ")[0];

    setState(() {
      firstname = UserName;
      cartItems = user["cart"];
    });

    // setState(() {
    //   username = vendor["company_name"];
    // });
  }

  @override
  Widget build(BuildContext context) {
    CartItemsModel cItem = GetIt.I<CartItemsModel>();
    return CubitProvider(
      create: (context) => RestaurantFoodsCubit(id: restaurants.id.toString()),
      child: Scaffold(
        backgroundColor: Resources.PRIMARY_COLOR,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: CubitListener<RestaurantFoodsCubit, RestaurantFoodsState>(
              listener: (context, state) {
                if (state is RestaurantFoodFailureState)
                  print("Error fetching restaurants");
              },
              child: CubitBuilder<RestaurantFoodsCubit, RestaurantFoodsState>(
                builder: (context, state) {
                  if (state is RestaurantFoodLoadingState) {
                    return NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return [
                          StreamBuilder(
                              // stream: global.numbersStream(),
                            stream: global.cartItemNumbers(),
                              initialData: GetIt.I<CartItemsModel>().getCartItemsNumber(),
                              builder: (context, snapshot) {
                                return SliverAppBar(
                                  backgroundColor: Resources.PRIMARY_COLOR,
                                  expandedHeight: 200.0,
                                  floating: false,
                                  pinned: true,
                                  actions: <Widget>[
                                    new Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: new Container(
                                          height: 150.0,
                                          width: 30.0,
                                          child: new GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          new CartItemsPage()));
                                            },
                                            child: new Stack(
                                              children: <Widget>[
                                                // 5 == 0
                                                //     ? new Container()
                                                //     :
                                                Badge(
                                                        badgeColor: Colors.red,
                                                        badgeContent: Text(
                                                          snapshot.data
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        child: Icon(Icons
                                                            .shopping_cart),
                                                      )
                                              ],
                                            ),
                                          )),
                                    )
                                  ],
                                  flexibleSpace: FlexibleSpaceBar(
                                      centerTitle: true,
                                      title: Text(restaurants.companyName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          )),
                                      background: Image.network(
                                        Commons.formatImageUrl(
                                            restaurants.image),
                                        fit: BoxFit.cover,
                                      )),
                                );
                              }),
                        ];
                      },
                      body: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Commons.loadingWidget("Loading All foods")],
                      )),
                    );
                  } else if (state is RestaurantFoodSuccessState) {
                    final foodList = state.foodlist;
                    return NestedScrollView(
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return [
                            SliverAppBar(
                              backgroundColor: Resources.PRIMARY_COLOR,
                              expandedHeight: 200.0,
                              floating: false,
                              pinned: true,
                              actions: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: new Container(
                                      height: 150.0,
                                      width: 30.0,
                                      child: new GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          new CartItemsPage()));
                                        },
                                        child: new Stack(
                                          children: <Widget>[
                                            // 5 == 0
                                            //     ? new Container()
                                            //     :
                                            Badge(
                                                    badgeColor: Colors.red,
                                                    badgeContent: Text(
                                                      cItem.getCartItemsNumber().toString(),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    child: Icon(
                                                        Icons.shopping_cart),
                                                  )
                                          ],
                                        ),
                                      )),
                                )
                              ],
                              flexibleSpace: FlexibleSpaceBar(
                                  centerTitle: true,
                                  title: Text(restaurants.companyName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      )),
                                  background: Image.network(
                                    Commons.formatImageUrl(restaurants.image),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ];
                        },
                        body: RefreshIndicator(
                            key: _refreshIndicatorKey,
                            child: foodList.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Commons.showEmptyListMessage(
                                              "No Items found"))
                                    ],
                                  )
                                : ListView.builder(
                                    itemCount: foodList.length,
                                    itemBuilder: (context, index) {
                                      return _myStoreItem(
                                          foodList[index], context, index);
                                    }),
                            onRefresh: () async {
                              print("it refreshed");
                              if (state is! RestaurantFoodLoadingState)
                                CubitProvider.of<RestaurantFoodsCubit>(context)
                                    .getAllCategories(
                                        restaurants.id.toString());
                            }));
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/error.svg",
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Error loading restaurant foods",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
  FutureOr onPopBack(){
    setState((){

    });
  }

  Widget _myStoreItem(Menu sales, BuildContext context, int index) {
    return InkWell(
      onTap: () async {
        var myresults = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodDetailPage(
                      foodItem: sales,
                    ))).then(onPopBack());
        // then((value) => getUser());
        //   if (value != null) {
        //     var message = "";
        //     if (value == "2") message = "Food Updated Successfully";
        //     if (value == "3") message = "Food Deleted Successfully";
        //
        //   }
        // });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Card(
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Hero(
                  tag: sales.id,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: sales.image == null
                                ? AssetImage("assets/images/select_image.png")
                                : NetworkImage(
                                    Commons.formatImageUrl(sales.image)))),
                    height: 140.0,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sales.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        RatingBarIndicator(
                          rating: 3.75,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 16.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "₦${sales.price}",
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.grey[400]),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_sharp,
                              size: 15,
                            ),
                            Text(
                              "${sales.location}",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Resources.PRIMARY_COLOR,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 4.0),
                                  child: Text(
                                    sales.category,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
