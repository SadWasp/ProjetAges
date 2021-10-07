import 'package:ages_app/Auths/functions.dart';
import 'package:ages_app/Module/Exceptions.dart';



class Item{
  int? id;
  String? name = "Item";
  String? description = "Un item";
  String? location ="";
  int? quantite = 0;


  Item({this.id,this.name,this.description,this.location,this.quantite});

  Item.fromJson(Map<String,dynamic> json)
  {
    id = json["id"];
    name = json["name"];
    name = json["description"];
    location = json["location"];
    quantite = json["quantite"];
  }

  Map<String,dynamic> toJson()
  {
    final Map<String,dynamic> data = new  Map<String,dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["description"] = this.description;
    data["location"] = this.location;
    data["quantite"] = this.quantite;
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

  static Future<Item> RegisterItem(String name, String location, int qty, String desc) async {
    if ((name.isEmpty || desc.isEmpty))
      throw UIException("nom ou description incorecte");
    if (qty < 0)
      throw UIException("Quantité incorrecte");
    
    Map<String, dynamic> _res = await postRequest(api: '/items/create/', body: {
      "name": name,
      "description": desc,
      "location": location,
      "quantity" : qty
    });

    return Future.delayed(Duration(seconds: 3), () {
      return Item(
          id: _res['id'], name: _res['name'], location: _res['location'],quantite : _res['quantity'], description: _res['desc'],);
    });
  }

  static Future<dynamic> delete(int id) async {
    
    var res = await deleteRequest(api: "items/"+ id.toString()+ "/delete/" );

    return res;
  }
  
  
  

}