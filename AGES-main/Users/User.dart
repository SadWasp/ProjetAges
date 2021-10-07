import 'package:ages_app/Auths/functions.dart';
import 'package:ages_app/Module/Exceptions.dart';
import 'package:ages_app/Module/constants.dart';
import 'package:encrypt/encrypt.dart';

class User {
  int _id = 999999999999999;
  String _username = "Anon";
  String _role = "User";

  String getRole() => _role;
  String getUsername() => _username;
  int getId() => _id;

  User({required int id, required String username, String? role}) {
    this._id = id;
    this._username = username;

    if (role != null) {
      this._role = role;
    }
  }

  static Future<User> AuthenticateUser(String username, String Password) async {
    final key = Key.fromUtf8(Tokekey);
    final iv = IV.fromLength(8);
    final encrypter = Encrypter(Salsa20(key));
    final encrypted = encrypter.encrypt(Password, iv: iv);

    Map<String, dynamic> _res = await postRequest(
        api: 'auth/login',
        body: {"userName": username, "password": encrypted.base64});
    if (username.isEmpty || Password.isEmpty)
      throw UIException("Identifiants Incorectes");
    return Future.delayed(Duration(seconds: 3), () {
      return User(
          id: _res['id'], username: _res['userName'], role: _res['role']);
      //return User( id: 1, username:"Pat",role: "User");
    });
  }

  static Future<User> RegisterUser(
    
    
      String username, String Password, String role) async {
    if ((username.isEmpty || Password.isEmpty))
      throw UIException("Identifiants Incorectes");
    if (!regExp.hasMatch(Password)) {
      throw UIException(
          "Minimum 1 majuscule, minuscule, nombre ,caractere special et 8 caractere de long.");
    }
    final key = Key.fromUtf8(Tokekey);
    final iv = IV.fromLength(8);
    final encrypter = Encrypter(Salsa20(key));
    final encrypted = encrypter.encrypt(Password, iv: iv);
    Map<String, dynamic> _res = await postRequest(api: 'auth/register', body: {
      "userName": username,
      "password": encrypted.base64,
      "role": "User"
    });

    return Future.delayed(Duration(seconds: 3), () {
      return User(
          id: _res['id'], username: _res['userName'], role: _res['role']);
    });
  }

  static Future<bool> Disconnect(int Id) async {
    
    var _res = await singlePostRequest(
        api: 'auth/'+Id.toString()+'/logout',
        body: {});

    return Future.delayed(Duration(seconds: 3), () {
      if(_res == 'true'){return true;}else{return false; }
    });
  }

}
