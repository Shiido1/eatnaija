import 'dart:async';
import 'dart:convert';

import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_cafe_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_company_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_equipment_response.dart';
import 'package:eatnaija/presentation/screens/cart/model/manage_cart_response.dart';
import 'package:eatnaija/presentation/screens/change_password/model/change_password_request.dart';
import 'package:eatnaija/presentation/screens/resetPassword/model/reset_password_request.dart';
import 'package:eatnaija/presentation/screens/resetPassword/model/reset_password_response.dart';
import 'package:eatnaija/presentation/screens/change_password/model/change_password_response.dart';
import 'package:eatnaija/presentation/screens/order_history/model/food_order_response.dart';
import 'package:eatnaija/presentation/screens/order_history/model/get_uploaded_food_response.dart';
import 'package:eatnaija/presentation/screens/order_history/model/request_response.dart';
import 'package:eatnaija/presentation/screens/order_history/model/order_history_response.dart';
import 'package:eatnaija/presentation/screens/otp_verify/model/otp_verify_request.dart';
import 'package:eatnaija/presentation/screens/cart/model/cart_items_response.dart';
import 'package:eatnaija/presentation/screens/cart/model/delete_cart_item_response.dart';
import 'package:eatnaija/presentation/screens/checkout/model/update_profile_request.dart';
import 'package:eatnaija/presentation/screens/checkout/model/checkout_request.dart';
import 'package:eatnaija/presentation/screens/checkout/model/checkout_response.dart';
import 'package:eatnaija/presentation/screens/checkout/model/update_user_response.dart';
import 'package:eatnaija/presentation/screens/login/models/login_request.dart';
import 'package:eatnaija/presentation/screens/login/models/google_login_request.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_restaurants_response.dart';
import 'package:eatnaija/presentation/screens/allrestaurants/model/all_food_port_response.dart';

import 'package:eatnaija/presentation/screens/food_detail/model/cart_response.dart';
import 'package:eatnaija/presentation/screens/login/models/login_response.dart';
import 'package:eatnaija/presentation/screens/register/models/resgister_request.dart';
import 'package:eatnaija/presentation/screens/register/models/register_response.dart';
import 'package:eatnaija/presentation/screens/restaurant_foods/model/get_all_restaurant_food_response.dart';

import 'package:http/http.dart' as http;

import 'api_endpoints.dart';
import 'failure_exceptions.dart';
import 'myexceptions.dart';

Future<LoginResponse> myuserLogin(LoginRequest userLogin) async {
  print(tokenURL);
  try {
    final http.Response response = await http
        .post(
          tokenURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userLogin.toJson()),
        )
        .timeout(Duration(seconds: Resources.timeOut));
    if (response.statusCode == 200) {
      print(response.body);
      return LoginResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw UnauthorisedException("Invalid Username or Password");
    }
  } catch (exception) {
    print(exception);

    if (exception.runtimeType == UnauthorisedException) {
      throw ("Invalid Username or Password");
    } else {
      FailureException failureException = FailureException(exception);
      throw failureException.response();
    }
  }
}

Future<LoginResponse> googleLoginRequest(GoogleLoginRequest userLogin) async {
  print(googleLoginURL);
  print(userLogin);
  try {
    final http.Response response = await http
        .post(
          googleLoginURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userLogin.toJson()),
        )
        .timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return LoginResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw UnauthorisedException("Invalid Username or Password");
    }
  } catch (exception) {
    print(exception);

    if (exception.runtimeType == UnauthorisedException) {
      throw ("Invalid Username or Password");
    } else {
      FailureException failureException = FailureException(exception);
      throw failureException.response();
    }
  }
}

// Future<UploadResponse> uploadFoods(
//     UploadRequest uploadRequest, String token) async {
//   print(uploadFoodURL);
//   try {
//     final http.Response response = await http.post(
//       uploadFoodURL,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(uploadRequest.toJson()),
//     );
//     print(response.body);
//     if (response.statusCode == 200) {
//       print(response.body);
//       return UploadResponse.fromJson(json.decode(response.body));
//     }
//   } catch (e) {
//     FailureException failureException = FailureException(e);
//     throw failureException.response();
//   }
// }

Future<ManageCartResponse> addToCartRequest(String foodId, String token) async {
  print(addToCartURL + '/$foodId');
  try {
    final http.Response response = await http.post(
      addToCartURL + "/$foodId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return ManageCartResponse.fromJson(json.decode(response.body));
    }
    return null;
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
  return null;
}

Future<ChangePasswordResponse> changePassword(
    ChangePasswordRequest changePasswordRequest, String token) async {
  print(changePasswordURL);
  try {
    final http.Response response = await http
        .post(
          changePasswordURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(changePasswordRequest.toJson()),
        )
        .timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return ChangePasswordResponse.fromJson(json.decode(response.body));
    } else {
      throw ("Unable to change password");
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<ResetPasswordResponse> resetPasswordRequest(
    ResetPasswordRequest resetPasswordRequest) async {
  print(resetPasswordURL);
  try {
    final http.Response response = await http
        .post(
          resetPasswordURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(resetPasswordRequest.toJson()),
        )
        .timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return ResetPasswordResponse.fromJson(json.decode(response.body));
    } else {
      throw ("Unable to change password");
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<LoginResponse> verifyOtpRequest(String otp) async {
  print(otpVerifyUrl);

  OtpVerifyRequest otpVerifyRequest = OtpVerifyRequest();
  otpVerifyRequest.otp = otp;

  try {
    final http.Response response = await http
        .post(otpVerifyUrl,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(otpVerifyRequest.toJson()))
        .timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return LoginResponse.fromJson(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<UpdateUserResponse> updateUserInfoRequest(
    UpdateProfileRequest updateProfileRequest, String token) async {
  print(updateUserInfoURL);
  try {
    final http.Response response = await http
        .post(updateUserInfoURL,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(updateProfileRequest.toJson()))
        .timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return UpdateUserResponse.fromJson(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<CheckoutResponse> checkoutRequest(
    CheckoutRequest checkoutRequest, String token) async {
  print(checkoutURL);
  try {
    final http.Response response = await http
        .post(checkoutURL,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(checkoutRequest.toJson()))
        .timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return CheckoutResponse.fromJson(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<ManageCartResponse> subtractFromCartRequest(
    String foodId, String token) async {
  print(subtractFromCartURL + '/$foodId');
  try {
    final http.Response response = await http.post(
      subtractFromCartURL + "/$foodId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return ManageCartResponse.fromJson(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<DeleteCartItemResponse> deleteFromCartRequest(
    String foodId, String token) async {
  print(deleteFromCartURL + '/$foodId');
  try {
    final http.Response response = await http.delete(
      deleteFromCartURL + "/$foodId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return DeleteCartItemResponse.fromJson(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

// Future<GetUploadedFoodsResponse> allUploadedFoods(String token) async {
//   print(allFoodURL);
//   try {
//     final http.Response response = await http.get(
//       allFoodURL,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF0bmFpamEuY29tXC9hcGlcL2xvZ2luXC92ZW5kb3IiLCJpYXQiOjE2MDU1NzkzNTgsIm5iZiI6MTYwNTU3OTM1OCwianRpIjoidVRhWnNqczFSWUZQMEZQVyIsInN1YiI6MTIxLCJwcnYiOiI5MjNhNzM3NWI2NTZjYTViYjlhNzIxNjIzZmU1OWViNWY0NTFmM2U5In0.pwZW--C_TZtuqlH5x1HWMhsYRd09SysD8Pl8KN0zu0s',
//       },
//     );
//     print(response.body);
//     if (response.statusCode == 200) {
//       print(response.body);
//       return GetUploadedFoodsResponse.fromJson(json.decode(response.body));
//     } else {
//       print(json.decode(response.body).toString());
//       throw Exception(json.decode(response.body));
//     }
//   } catch (e) {
//     FailureException failureException = FailureException(e);
//     throw failureException.response();
//   }
// }

Future<AllRestaurantsResponse> getAllRestaurants() async {
  print(allRestaurantsURL);
  try {
    final http.Response response = await http.get(
      allRestaurantsURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return AllRestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<AllFoodPortResponse> getAllFoodPorts() async {
  print(allFoodPortFoodURL);
  try {
    final http.Response response = await http.get(
      allFoodPortFoodURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return AllFoodPortResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<AllFoodCompanyResponse> getFoodCompanies() async {
  print(allFoodCompanyURL);
  try {
    final http.Response response = await http.get(
      allFoodCompanyURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return AllFoodCompanyResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<GetUploadedFoodResponse> allUploadedFoods(String token) async {
  print(allFoodURL);
  try {
    final http.Response response = await http.get(
      allFoodURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return GetUploadedFoodResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception("Failed get Uploaded Foods");
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<OrderHistoryResponse> orderHistoryRequest(String token) async {
  print(orderHistoryURL);
  try {
    final http.Response response = await http.get(
      orderHistoryURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return OrderHistoryResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception("Failed get Uploaded Foods");
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<FoodOrderResponse> allFoodOrders(String token) async {
  print(allFoodOrderURL);
  try {
    final http.Response response = await http.get(
      allFoodOrderURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return FoodOrderResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<AllCafeResponse> getCafes() async {
  print(allCafeEndURL);
  try {
    final http.Response response = await http.get(
      allCafeEndURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return AllCafeResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<AllFoodEquipmentResponse> getFoodEquipment() async {
  print(allFoodEquipmentURL);
  try {
    final http.Response response = await http.get(
      allFoodEquipmentURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return AllFoodEquipmentResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<GetAllRestaurantFoodResponse> getAllRestaurantFood(
  String id,
  // String token
) async {
  print(allRestaurantFoodURL + "/$id");
  try {
    final http.Response response = await http.get(
      allRestaurantFoodURL + "/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return GetAllRestaurantFoodResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<CartItemsResponse> getAllCartItems(String token) async {
  print(allCartItemsUrl);
  try {
    final http.Response response = await http.get(
      allCartItemsUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return CartItemsResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<RequestResponse> acceptFoodOrder(String foodId, String token) async {
  print(acceptRequestURL);
  try {
    final http.Response response = await http.get(
      acceptRequestURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return RequestResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<RequestResponse> rejectFoodOrder(String foodId, String token) async {
  print(rejectRequestURL);
  try {
    final http.Response response = await http.get(
      rejectRequestURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return RequestResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

Future<RequestResponse> deliverFoodOrder(String foodId, String token) async {
  print(deliverRequestURL + "/$foodId");
  try {
    final http.Response response = await http
        .get(deliverRequestURL + "/$foodId", headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    }).timeout(Duration(seconds: Resources.timeOut));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return RequestResponse.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    FailureException failureException = FailureException(e);
    throw failureException.response();
  }
}

// Future<dynamic> deleteFoodItem(String foodId, String token) async {
//   print(deleteFoodItemURL);
//   try {
//     final http.Response response = await http.delete(
//       deleteFoodItemURL+"/$foodId",
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//     );
//     print(response);
//     if (response.statusCode == 200) {
//       print(response.body);
//       return response.body;
//     } else {
//       print(json.decode(response.body).toString());
//       throw Exception(json.decode(response.body));
//     }
//   } catch (e) {
//     FailureException failureException = FailureException(e);
//     throw failureException.response();
//   }
// }
//
// Future<DashboardRequestResponse> allDashboardRequests(String token) async {
//   print(allDashboardRequestURL);
//   try {
//     final http.Response response = await http.get(
//       allDashboardRequestURL,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//     );
//     print(response);
//     if (response.statusCode == 200) {
//       print(response.body);
//       return DashboardRequestResponse.fromJson(json.decode(response.body));
//     } else {
//       print(json.decode(response.body).toString());
//       throw Exception(json.decode(response.body));
//     }
//   } catch (e) {
//     FailureException failureException = FailureException(e);
//     throw failureException.response();
//   }
// }

Future<RegisterResponse> userRegistration(
    RegisterRequest vendorRegister) async {
  print(registerURL);

  try {
    final http.Response response = await http
        .post(registerURL,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(vendorRegister.toJson()))
        .timeout(Duration(seconds: Resources.timeOut));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return RegisterResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 409) {
      // throw ("User already Exists...");
      throw CustomException("User already exists");
    }
  } catch (error) {
    FailureException failureException = FailureException(error);
    throw failureException.response();
  }
}
