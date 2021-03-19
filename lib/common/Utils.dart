import 'dart:convert';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class Commons {
  static const baseURL = "https://api.chucknorris.io/";
  static const apiBaseURL = "https://dev.doctalkng.com/api/";
  static const imageBaseURL = "https://dev.doctalkng.com/userfiles/";
  static const timeOut = 20;

  // static const apiBaseURL = "https://jiffix.jawharacloset.com/api/";

  static const usersPrefKey = "userKey";

  static const tileBackgroundColor = const Color(0xFFF1F1F1);
  static const chuckyJokeBackgroundColor = const Color(0xFFF1F1F1);
  static const chuckyJokeWaveBackgroundColor = const Color(0xFFA8184B);
  static const gradientBackgroundColorEnd = const Color(0xFF601A36);
  static const gradientBackgroundColorWhite = const Color(0xFFFFFFFF);
  static const mainAppFontColor = const Color(0xFF4D0F29);
  static const appBarBackGroundColor = const Color(0xFF4D0F28);
  static const categoriesBackGroundColor = const Color(0xFFA8184B);
  static const hintColor = const Color(0xFF4D0F29);
  static const mainAppColor = const Color(0xFF4D0F29);
  static const gradientBackgroundColorStart = const Color(0xFF4D0F29);
  static const popupItemBackColor = const Color(0xFFDADADB);

  static Widget spinkitLoader() {
    return Center(
        child: SpinKitRing(
          size: 50.0,
          lineWidth: 7.0,
          color: Resources.PRIMARY_COLOR,
        ));
  }

  static Widget otpLoader() {
    return Center(
        child: SpinKitRing(
          size: 50.0,
          lineWidth: 5.0,
          color: Resources.PRIMARY_COLOR,
        ));
  }

  static void showError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(message),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }


  static Future<int> getCartCount() async {
    UserDao userDao = UserDao();
    var user = await userDao.getUser("nandom");
    // print(userDao);

    var UserName = user["name"].toString().split(" ");

    print(user["cart"]);

    return user["cart"];
  }

  static formatImageUrl(String imageUrl){
    return imageUrl.startsWith("https://lh4") || imageUrl.startsWith("https://firebasestorage") ? imageUrl : "${Resources.IMAGE_BASE_URL}/${imageUrl}";
  }

  static Widget showErrorMessage(String message){
    return Column(
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
          message,
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static Widget showEmptyListMessage(String message){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/svgs/empty_list.svg",
          height: 100,
          width: 100,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          message,
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }

  static Widget loadingWidget(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              message,
              style: TextStyle(color: Colors.grey),
            )),
        spinkitLoader(),
      ],
    );
  }

  static Widget otpLoading(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              message,
              style: TextStyle(color: Resources.PRIMARY_COLOR),
            )),
        otpLoader(),
      ],
    );
  }
}