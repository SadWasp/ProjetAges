import 'package:ages_app/Auths/functions.dart';
import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Location/location.dart';
import 'package:flutter/cupertino.dart';

class mapModel extends ChangeNotifier{
  
  int? itemId;
  String? name;
  int? quantity;
  int? x = 0;
  int? y = 0;
  int? zone = 0;

  late Future<List<dynamic>> _items;

  mapModel.fromJson(Map<String,dynamic> json)
  {
    itemId = json["itemId"];
    name = json["name"];
    quantity = json["quantity"];
    x = json["x"];
    y = json["y"];
    zone = json["zone"];
  }
  
  void setItems(int id){
    _items = getListItemsByOrder(id.toString());
  }
  Future<List<dynamic>> get getItems => _items;

  static Future<List<dynamic>> getListItemsByOrder(String id) async{
    var res = await getRequestList(api: "orders/locations/$id/");
    return res.map((e) => mapModel.fromJson(e)).toList();
  }
}

