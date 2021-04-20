import 'package:badges/badges.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/Utils.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_cafe_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_company_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_port_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_restaurants_response.dart';
import 'package:eatnaija/common/slide_route_transition.dart';
import 'package:eatnaija/presentation/screens/cart/cart_items_page.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_item_model.dart';
import 'package:eatnaija/presentation/screens/restaurant_foods/restaurant_foods_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eatnaija/common/globals.dart' as global;
import 'package:get_it/get_it.dart';

import 'cubit/all_restaurants_cubit.dart';
import 'model/all_food_equipment_response.dart';

class AllRestaurantsPage extends StatefulWidget {
  final int type;

  const AllRestaurantsPage({Key key, this.type}) : super(key: key);

  @override
  _AllRestaurantsPageState createState() => _AllRestaurantsPageState();
}

class _AllRestaurantsPageState extends State<AllRestaurantsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  String title;

  var cartItems;

  UserDao userDao = UserDao();

  String firstname;

  var user;

  @override
  void initState() {
    super.initState();
    getTitle();
    if (user != null) {
      getUser();
    } else {
      return;
    }
  }

  getUser() async {
    user = await userDao.getUser("nandom");
    // print(userDao);

    var UserName = user==null?"Guest":user["name"].toString().split(" ")[0];

    setState(() {
      firstname = UserName;
      cartItems = user==null?[]:user["cart"];
    });

    // setState(() {
    //   username = vendor["company_name"];
    // });
  }

  getTitle() {
    switch (widget.type) {
      case 1:
        title = "Restaurants";
        break;
      case 2:
        title = "Food Ports";
        break;
      case 3:
        title = "Cafes";
        break;
      case 4:
        title = "Snack Bars";
        break;
      case 5:
        title = "Food Companies";
        break;
      default:
        title = "Food Equipments";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => AllRestaurantsCubit(type: widget.type),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "All $title",
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
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new CartItemsPage()));
                      },
                      child: StreamBuilder<Object>(
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
        body: CubitListener<AllRestaurantsCubit, AllRestaurantsState>(
          listener: (context, state) {
            if (state is AllRestaurantsFailureState)
              print("Error fetching $title");
          },
          child: CubitBuilder<AllRestaurantsCubit, AllRestaurantsState>(
            builder: (context, state) {
              if (state is AllRestaurantsLoadingState) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Commons.loadingWidget("Loading All $title")],
                ));
              } else if (state is AllRestaurantsSuccessState) {
                final restaurants = state.restaurants;
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  child: restaurants.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/empty-box.svg",
                                  height: 100.0,
                                  width: 100.0,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              "No $title found",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 18.0),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            return restaurantItem(index,
                                myrestaurant: restaurants[index]);
                          }),
                  onRefresh: () async {
                    print("it refreshed");
                    if (state is! AllRestaurantsLoadingState)
                      CubitProvider.of<AllRestaurantsCubit>(context)
                          .getAllCategories();
                  },
                );
              } else if (state is AllCafeSuccessState) {
                final restaurants = state.cafes;
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  child: restaurants.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Commons.showEmptyListMessage(
                                    "No $title found"))
                          ],
                        )
                      : ListView.builder(
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            return restaurantItem(index,
                                cafe: restaurants[index]);
                          }),
                  onRefresh: () async {
                    print("it refreshed");
                    if (state is! AllRestaurantsLoadingState)
                      CubitProvider.of<AllRestaurantsCubit>(context)
                          .getAllCategories();
                  },
                );
              } else if (state is AllFoodPortSuccessState) {
                final restaurants = state.foodPort;
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  child: restaurants.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Commons.showEmptyListMessage(
                                    "No $title found"))
                          ],
                        )
                      : ListView.builder(
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            return restaurantItem(index,
                                foodPort: restaurants[index]);
                          }),
                  onRefresh: () async {
                    print("it refreshed");
                    if (state is! AllRestaurantsLoadingState)
                      CubitProvider.of<AllRestaurantsCubit>(context)
                          .getAllCategories();
                  },
                );
              } else if (state is AllFoodEquipmentSuccess) {
                final restaurants = state.foodEquipment;
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  child: restaurants.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/empty-box.svg",
                                  height: 100.0,
                                  width: 100.0,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              "No $title found",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 18.0),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            return restaurantItem(index,
                                foodEquipment: restaurants[index]);
                          }),
                  onRefresh: () async {
                    print("it refreshed");
                    if (state is! AllRestaurantsLoadingState)
                      CubitProvider.of<AllRestaurantsCubit>(context)
                          .getAllCategories();
                  },
                );
              } else if (state is AllFoodCompanySuccessState) {
                final restaurants = state.foodCompany;
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  child: restaurants.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Commons.showEmptyListMessage("No $title found")
                          ],
                        )
                      : ListView.builder(
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            return restaurantItem(index,
                                foodCompany: restaurants[index]);
                          }),
                  onRefresh: () async {
                    print("it refreshed");
                    if (state is! AllRestaurantsLoadingState)
                      CubitProvider.of<AllRestaurantsCubit>(context)
                          .getAllCategories();
                  },
                );
              } else {
                return Center(
                  child: Text("Error loading categories"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget restaurantItem(int index,
      {Restaurants myrestaurant,
      FoodCompany foodCompany,
      FoodEquipment foodEquipment,
      Cafe cafe,
      FoodPort foodPort}) {
    var restaurant;
    Widget widgetPage;

    switch (widget.type) {
      case 1:
        {
          restaurant = myrestaurant;
          widgetPage =
              RestaurantFoodPage(index: widget.type, myrestaurants: restaurant);
        }
        break;
      case 2:
        {
          restaurant = foodPort;
          widgetPage =
              RestaurantFoodPage(index: widget.type, foodPort: restaurant);
        }
        break;
      case 3:
        {
          restaurant = cafe;
          widgetPage = RestaurantFoodPage(index: widget.type, cafe: restaurant);
        }
        break;
      case 4:
        {
          restaurant = cafe;
          widgetPage = RestaurantFoodPage(index: widget.type, cafe: restaurant);
        }
        break;
      case 5:
        {
          restaurant = foodCompany;
          widgetPage =
              RestaurantFoodPage(index: widget.type, foodCompany: restaurant);
        }
        break;
      default:
        {
          restaurant = foodEquipment;
          widgetPage =
              RestaurantFoodPage(index: widget.type, foodEquipment: restaurant);
        }
        break;
    }

    // print(restaurant);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, SlideLeftRoute(page: widgetPage))
              .then((value) => getUser());
        },
        child: Card(
            elevation: 4.0,
            child: Container(
              height: 150.0,
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/select_image.png",
                        image: Commons.formatImageUrl(restaurant.image),
                        fit: BoxFit.cover,
                      )),
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.companyName,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30.0,
                                  width: 45.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "4",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 16.0,
                                      )
                                    ],
                                  ),
                                  decoration:
                                      BoxDecoration(color: Color(0xFF32BC50)),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "Open now",
                                  style: TextStyle(color: Color(0xFF32BC50)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              restaurant.address,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
