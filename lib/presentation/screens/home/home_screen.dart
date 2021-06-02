import 'package:eatnaija/common/app_state.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/firebase/sign_in.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/all_restaurants_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final int callback;
  final changeMeeters;

  const HomeScreen(callback, changeMeeters(int meeters))
      : this.callback = callback,
        this.changeMeeters = changeMeeters;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _usernameController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String firstname;

  int cartCount;
  String userImage;

  UserDao userDao = UserDao();

  @override
  void initState() {
    firstname = "";
    super.initState();
    if (user != null) {
      getUser();
    } else {
      return;
    }
  }

  var user;

  getUser() async {
    user = await userDao.getUser("nandom");
    print(
        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print(user);

    var UserName = user["name"].toString().split(" ");
    cartCount = user["cart"];

    userImage = user["image"];
    setState(() {
      firstname = UserName[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 31.0,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: userImage != null
                              ? NetworkImage(userImage)
                              : AssetImage("assets/images/default_image.png"),
                          radius: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      Text(firstname,
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            // Container(
            //   height: 40.0,
            //   width: MediaQuery.of(context).size.width,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         flex: 10,
            //         child: Container(
            //           // child: TextFormField(
            //           //   keyboardType: TextInputType.text,
            //           //   controller: _usernameController,
            //           //   decoration: InputDecoration(
            //           //     focusedBorder: OutlineInputBorder(
            //           //       borderRadius:
            //           //           BorderRadius.all(Radius.circular(35.0)),
            //           //       borderSide:
            //           //           BorderSide(width: 1, color: Colors.grey),
            //           //     ),
            //           //     enabledBorder: OutlineInputBorder(
            //           //       borderRadius:
            //           //           BorderRadius.all(Radius.circular(35.0)),
            //           //       borderSide:
            //           //           BorderSide(width: 1, color: Colors.grey),
            //           //     ),
            //           //     labelText: "Search Food",
            //           //     contentPadding: EdgeInsets.symmetric(
            //           //         horizontal: 15.0, vertical: 10.0),
            //           //     labelStyle: TextStyle(color: Colors.grey),
            //           //     border: OutlineInputBorder(
            //           //         borderRadius: BorderRadius.circular(40.0)),
            //           //   ),
            //           // ),
            //           child: Container()
            //         ),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Container(child: Icon(Icons.search_rounded)),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 30.0,
            ),
            GridView.count(
              crossAxisCount: 2,
              primary: false,
              childAspectRatio: 10 / 9,
              crossAxisSpacing: 2.0,
              shrinkWrap: true,
              children: <Widget>[
                dashBoardItem('restaurant_item.png', 1, context),
                dashBoardItem('food_pot_item.png', 2, context),
                dashBoardItem('cafe_eatry.png', 3, context),
                dashBoardItem('snack_bar.png', 4, context),
                dashBoardItem('food_company.png', 5, context),
                dashBoardItem('food_equipment.png', 6, context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget dashBoardItem(String image, int cardIndex, BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return InkWell(
      onTap: () async {
        var result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AllRestaurantsPage(type: cardIndex)));

        getUser();

        // widget.changeMeeters(3);
        print(
            "--------------------------------------------------------------------------------------------------------------------");
        print("we are back to base $cartCount");
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.transparent,
          elevation: 4.0,
          child: Container(
            height: 190.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/' + image),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
          ),
          margin: cardIndex.isEven
              ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 25.0)
              : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 25.0)),
    );
  }
}
