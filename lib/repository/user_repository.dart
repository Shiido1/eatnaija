import 'package:eatnaija/api_connection/api_connection.dart';
import 'package:eatnaija/dao/user_dao.dart';
import 'package:eatnaija/presentation/screens/checkout/model/update_profile_request.dart';
import 'package:eatnaija/presentation/screens/checkout/model/update_user_response.dart';
import 'package:eatnaija/presentation/screens/login/models/login_request.dart';
import 'package:eatnaija/presentation/screens/login/models/login_response.dart';
import 'package:eatnaija/presentation/screens/login/models/google_login_request.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';
import 'package:eatnaija/presentation/screens/register/models/resgister_request.dart';
import 'package:eatnaija/presentation/screens/register/models/register_response.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final userDao = UserDao();

  Future<LoginResponse> authenticate({
    @required String username,
    @required String password,
  }) async {
    LoginRequest userLogin = LoginRequest(email: username, password: password);
    LoginResponse loginResponse = await myuserLogin(userLogin);

    return loginResponse;
  }

  Future<LoginResponse> googleLoginRepo({
    @required String email,
    @required String image,
    @required String name,
  }) async {
    GoogleLoginRequest userLogin = GoogleLoginRequest(email: email, image: image, name: name);
    LoginResponse loginResponse = await googleLoginRequest(userLogin);

    return loginResponse;
  }

  Future<RegisterResponse> register(
      {@required String name,
      @required String email,
      @required String phone,
      @required String password,
      @required String state,
      @required String city,
      @required String address,
      @required String image}) async {
    RegisterRequest userRegister = RegisterRequest(
        name: name,
        email: email,
        phone: phone,
        password: password,
        state: state,
        city: city,
        address: address,
        image: image);
    return await userRegistration(userRegister);
  }

  Future<User> updateUserInfo({String address, String phone}) async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];
    var cart = vendor["cart"];
    var userId = vendor["id"];

    UpdateProfileRequest updateProfileRequest = UpdateProfileRequest(
        image: vendor["image"],
        phone: phone,
        city: vendor["city"],
        address: address,
        state: vendor["state"]);

    UpdateUserResponse uploadResponse =
        await updateUserInfoRequest(updateProfileRequest, token);
    User user = uploadResponse.user;

    User myUser = User();

    myUser.id = user.id;
    myUser.name = user.name;
    myUser.email = user.email;
    myUser.emailVerifiedAt = user.emailVerifiedAt;
    myUser.twoFactorSecret = null;
    myUser.twoFactorRecoveryCodes = null;
    myUser.currentTeamId = user.currentTeamId;
    myUser.image = user.image;
    myUser.createdAt = user.createdAt;
    myUser.updatedAt = user.updatedAt;
    myUser.phone = user.phone;
    myUser.address = user.address;
    myUser.otp = user.otp;
    myUser.city = user.city;
    myUser.state = user.state;
    myUser.token = token;
    myUser.cart = cart;

    await userDao.deleteUser();
    //
    int intresult = await userDao.createUser(myUser);

    String myaddress = user.address;

    // myuser["address"] = user.address;

    return user;
  }

  Future<User> updateUserProfile(
      {String image,
      String city,
      String state,
      String address,
      String phone}) async {
    dynamic vendor = await userDao.getUser("nandom");

    var token = vendor["token"];
    var userId = vendor["id"];

    UpdateProfileRequest updateProfileRequest = UpdateProfileRequest(
        image: image, phone: phone, city: city, address: address, state: state);

    UpdateUserResponse uploadResponse =
        await updateUserInfoRequest(updateProfileRequest, token);
    User user = uploadResponse.user;

    User myUser = User();

    myUser.id = user.id;
    myUser.name = user.name;
    myUser.email = user.email;
    myUser.emailVerifiedAt = user.emailVerifiedAt;
    myUser.twoFactorSecret = null;
    myUser.twoFactorRecoveryCodes = null;
    myUser.currentTeamId = user.currentTeamId;
    myUser.image = user.image;
    myUser.createdAt = user.createdAt;
    myUser.updatedAt = user.updatedAt;
    myUser.phone = user.phone;
    myUser.address = user.address;
    myUser.otp = user.otp;
    myUser.city = user.city;
    myUser.state = user.state;
    myUser.token = token;

    await userDao.deleteUser();
    //
    int intresult = await userDao.createUser(myUser);

    String myaddress = user.address;

    // myuser["address"] = user.address;

    return user;
  }

  Future<LoginResponse> verifyOtpRepo({String otp}) async {
    LoginResponse loginResponse = await verifyOtpRequest(otp);
    return loginResponse;
  }

  Future<void> persistToken({@required User user}) async {
    // write token with the user to the database
    int result = await userDao.createUser(user);

    print(result);
  }

  Future<void> deleteUser() async {
    await userDao.deleteUser();
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser("nandom");
    return result;
  }
}
