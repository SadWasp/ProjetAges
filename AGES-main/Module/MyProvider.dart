import 'package:ages_app/Users/User.dart';
import 'package:ages_app/Items/Items.dart';
import 'package:flutter/cupertino.dart';

class MyProvider with ChangeNotifier {
  bool loading = false;
  User? user;
  Item? item;

  disconnect(bool dc){
    dc ? user = null : null;
    notifyListeners();
  }

  setUser(User data) {
    user = data;
    notifyListeners();
  }

  getUser() => user;
  setLoading(bool l) {
    loading = l;
    notifyListeners();
  }

  setItem(Item data) {
    item = data;
    notifyListeners();
  }

  getItem() => item;
  

}
