import 'package:ages_app/Auths/functions.dart';
import 'package:ages_app/Module/Exceptions.dart';
import 'package:ages_app/Users/User.dart';



class Item{
  int? id;
  String? name = "Item";
  String? description = "Un item";
  String? scan = "";
  int? location =0;
  int? quantite = 0;


  Item({this.id,this.name,this.description,this.location,this.quantite,this.scan});

  Item.fromJson(Map<String,dynamic> json)
  {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    location = json["locationId"];
    quantite = json["quantity"];
    scan = json["scan"];
  }

  Map<String,dynamic> toJson()
  {
    final Map<String,dynamic> data = new  Map<String,dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["description"] = this.description;
    data["locationId"] = this.location;
    data["quantity"] = this.quantite;
    data["scan"] = this.scan;
    return data;
  }

  

  static Future<List<Item>> getListItems() async{
    var res = await getRequestList(api: "items");
    List<Item> listItem = [];
    for (var i = 0; i < res.length; i++) {
      listItem.add(Item.fromJson(res[i]));
    }
    return listItem;
  }
  static Future<Item> getItem(int id) async{
    var res = await getRequest(api: "items/" + id.toString());
    Item item = Item.fromJson(res);
    return item;
  }

  static Future<Item> RegisterItem(String name, String location, int qty, String desc,String scan) async {
    if ((name.isEmpty || desc.isEmpty))
      throw UIException("nom ou description incorecte");
    if (qty < 0)
      throw UIException("Quantité incorrecte");
    
    Map<String, dynamic> _res = await postRequest(api: '/items/create/', body: {
      "name": name,
      "description": desc,
      "locationId": 2,
      "quantity" : qty,
      "scan" : scan
    });

    return Future.delayed(Duration(seconds: 3), () {
      return Item(
          id: _res['id'], name: _res['name'], location: _res['locationId'],quantite : _res['quantity'], description: _res['desc'],scan: _res['scan'],);
    });
  }

  static dynamic addOrder( List<Map<String,int>> data, User user) async {
    int id = user.getId();
    
    var _res = await singlePostRequest(
        api: 'orders/${id.toString()}/create/',
        body: {"Order":data});
    return Future.delayed(Duration(seconds: 3), () {
      return _res;
      //return User( id: 1, username:"Pat",role: "User");
    });
  }

  static Future<dynamic> delete(int id) async {
    
    var res = await deleteRequest(api: "items/"+ id.toString()+ "/delete/" );

    return res;
  }

  
  
  

}