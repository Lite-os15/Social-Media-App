import 'package:flutter/widgets.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';

class UserProvider extends ChangeNotifier{
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();


  UserModel? get getUser => _user;


  Future<void> refreshUser() async  {
    UserModel? user = await _authMethods.getUserDetails();
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }
}