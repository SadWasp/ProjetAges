import 'package:ages_app/Auths/functions.dart';
import 'package:ages_app/Items/Items.dart';

class Location{
  int? id = -1;
  String? location = "Reception";
  Map<String, int> x = {"x" : 0};
  Map<String, int> y = {"y" : 0};

  Location({this.id,this.location});

  Location.fromJson(Map<String,dynamic> json)
  {
    id = json["id"];
    location = json["location"];
  }

  Map<String,dynamic> toJson()
  {
    final Map<String,dynamic> data = new  Map<String,dynamic>();
    data["id"] = this.id;
    data["location"] = this.location;
    return data;
  }

  static Future<List<Item>> getItems(int id) async{
    var res = await getRequest(api: "locations/"+ id.toString() +"/getItems/");
    List<Item> listItem = [];
    for (var i = 0; i < res.length; i++) {
      listItem.add(Item.fromJson(res[i]));
    }
    return listItem;
  }

  static Future<List<Location>> getListLocations() async{
    var res = await getRequest(api: "locations");
    List<Location> listItem = [];
    for (var i = 0; i < res.length; i++) {
      listItem.add(Location.fromJson(res[i]));
    }
    return listItem;
  }
  static Future<Location> getLocation(int id) async{
    var res = await getRequest(api: "locations/" + id.toString());
    Location location = Location.fromJson(res);
    return location;
  }
  

}