import 'package:eatnaija/bloc/authentication_bloc.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/common/slide_route_transition.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/firebase/sign_in.dart';
import 'package:eatnaija/presentation/screens/change_password/change_password_page.dart';
import 'package:eatnaija/presentation/screens/login/login_screen.dart';
import 'package:eatnaija/presentation/screens/profile/personal_information_page.dart';
import 'package:eatnaija/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstname;
  String email;
  String userImage;

  UserDao userDao = UserDao();
  UserRepository userRepository;

  @override
  void initState() {
    firstname = "";
    email = "";
    userImage = "";
    super.initState();
    userRepository = UserRepository();
    if (user != null) {
      getUser();
    } else {
      return;
    }
  }

  var user;

  getUser() async {
    user = await userDao.getUser("nandom");
    // print(userDao);

    var UserName = user["name"].toString().split(" ");
    userImage = user["image"];

    setState(() {
      firstname = UserName[0];
      email = user["email"];
    });

    // setState(() {
    //   username = vendor["company_name"];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height - 150.0,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      height: 100.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Resources.PRIMARY_COLOR),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              firstname,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 17.0),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0, top: 25.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          radius: 51.0,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: userImage != null
                                ? NetworkImage(userImage)
                                : AssetImage("assets/images/default_image.png"),
                            radius: 50.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "MY ACCOUNT",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    profileItems(
                        context, "Personal Information", Icons.person, 1),
                    SizedBox(
                      height: 15.0,
                    ),
                    profileItems(context, "Order History", Icons.history, 2),
                    SizedBox(
                      height: 15.0,
                    ),
                    profileItems(context, "Change Password",
                        Icons.lock_outline_rounded, 3),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: InkWell(
                  onTap: () {
                    signOutGoogle();

                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LoginScreen(userRepository: userRepository)));
                  },
                  child: Container(
                    width: 250.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Resources.PRIMARY_COLOR),
                    child: Center(
                        child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 18.0),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material profileItems(
      BuildContext context, String title, IconData iconData, int index) {
    return Material(
      child: InkWell(
        onTap: () {
          if (index == 1)
            Navigator.push(
                context, SlideLeftRoute(page: PersonalInformationPage()));
          // else if (index == 2)
          //   Navigator.push(
          //       context, SlideLeftRoute(page: RestaurantCategories()));
          else if (index == 3)
            Navigator.push(context, SlideLeftRoute(page: ChangePasswordPage()));
          //
          // }
        },
        child: Card(
          elevation: 4.0,
          child: Container(
            width: MediaQuery.of(context).size.width - 70,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          iconData,
                          color: Colors.grey[700],
                        ),
                      ],
                    )),
                Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[700]),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_right_alt,
                      color: Colors.grey[700],
                    )),
              ]),
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}
