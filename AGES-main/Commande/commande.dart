
import 'package:ages_app/Auths/functions.dart';
import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Screens/Commande/components/ordercards.dart';
import 'package:ages_app/Users/User.dart';

class Commande{
  int? orderId;
  Future<Map<Item,int>>? Orders;


  Commande({this.orderId,this.Orders});

  Commande.fromJson(Map<String,dynamic> json)
  {
    orderId = json["orderId"];
    Orders = Commande.OrdersFromJSON(json);
  }

  Map<String,dynamic> toJson()
  {
    final Map<String,dynamic> data = new  Map<String,dynamic>();
    data["id"] = this.orderId;
    data["Orders"] = this.Orders;
    return data;
  }
  
  static Future<List<Commande>> getListCommandes(int idUser) async{
    var res = await getRequestListCommande(api: "orders/", idUser: idUser);
    List<Commande> listCommande = [];
    for (var i = 0; i < res.length; i++) {
      listCommande.add(Commande.fromJson(res[i]));
    }
    return Future.delayed(Duration(seconds: 3), () {
      return listCommande;
    });
  }
  static Future<List<Commande>> getListAllCommandes() async{
    var res = await getRequest(api: "orders/");
    List<Commande> listCommande = [];
    for (var i = 0; i < res.length; i++) {
      listCommande.add(Commande.fromJson(res[i]));
    }
    return Future.delayed(Duration(seconds: 3), () {
      return listCommande;
    });
  }               //[{item,int}]
  

  static Future<Map<Item,int>> OrdersFromJSON (Map<String,dynamic> json) async{
    Map<Item,int> listItemQty = {};
    for (var i = 0; i < json["Orders"].length; i++) {
      Item item = await Item.getItem(json["Orders"][i]["itemId"]);
      listItemQty[item] = json["Orders"][i]["quantity"];
    }
    return Future.delayed(Duration(seconds: 3), () {
      return listItemQty;
    });
  }

  static Future<dynamic> delete(int id) async {
    
    var res = await deleteRequest(api: "orders/"+ id.toString()+ "/delete/" );

    return res;
  }

}