import 'package:ages_app/Users/User.dart';
import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Commande/commande.dart';
import 'package:flutter/cupertino.dart';

class MyProvider with ChangeNotifier {
  bool loading = false;
  String scan = "";
  User? user;
  Item? item;
  List<Map<Item, int>> cart = [];
  Map<String,String>newItemData = {'name': "", 'location': "", 'quantity': "",'description': ""};
  List<Commande> commande = [];
  List<Commande> commandeEnCours = [];
  List<Commande> commandeTerminer = [];

  disconnect(bool dc) {
    
    dc ? user = null : null;
    dc ? newItemData = {'name': "", 'location': "", 'quantity': "",'description': ""} : null;
    dc ? scan = "" : null;
    dc ? item = null : null;
    dc ? commande = [] : null;
    dc ? cart = [] : null;
    dc ? commandeEnCours = [] : null;
    dc ? commandeTerminer = [] : null;
    notifyListeners();
  }

  addToCart(Item item, int qty) {
    int index = 0;
    bool present = false;
    cart.forEach((itemInCart) {
      if (itemInCart.keys.elementAt(0).id == item.id) {
        itemInCart[itemInCart.keys.elementAt(0)] = itemInCart.values.elementAt(0) + qty;
        present = true;
      }
      index++;
    });

    if (!present) {
      cart.add({item: qty});
    }

    notifyListeners();
  }
  orderCart() async {
    
    List<Map<String,int>> data = [];
    print(cart);
      cart.forEach((element) {
      data.add(
        {
          "itemId" : element.keys.elementAt(0).id!, 
          "quantity": element.values.elementAt(0) 
        },
      );
    });
    var i =Item.addOrder(data,this.user!);
    deleteCart();
    setCommande();
    print(i);
  }
  deleteCart() {
    cart = [];
  }
  RemoveFromCart(Item item, int qty) {
    cart.remove({item: qty});
    notifyListeners();
  }

  getCart() => cart;
  
  setnewItemDataMap(Map<String,String> m) {
    newItemData = m;
    notifyListeners();
  }
  setnewItem(String n , String v) {
    newItemData[n] = v;
    notifyListeners();
  }
  
  getNewItem() => newItemData;


  setUser(User data) {
    user = data;
    notifyListeners();
  }

  getUser() => user;

  setLoading(bool l) {
    loading = l;
    notifyListeners();
  }

  setScan(String data) {
    scan = data;
    notifyListeners();
  }
  getScan() => scan;
  
  setItem(Item data) {
    item = data;
    notifyListeners();
  }

  getItem() => item;

  setCommande() async {
    commande = await (this.user!.getRole() == "Client"
        ? Commande.getListCommandes(this.user!.getId())
        : Commande.getListAllCommandes());
    notifyListeners();
  }

  getCommande() => commande;

  setCommandeEnCours() async {
    commande = await (this.user!.getRole() == "user"
        ? Commande.getListCommandes(this.user!.getId())
        : Commande.getListAllCommandes());
    notifyListeners();
  }

  getCommandeEnCours() => commande;

  setCommandeEnTerminer() async {
    commande = await (this.user!.getRole() == "admin"
        ? Commande.getListCommandes(this.user!.getId())
        : Commande.getListAllCommandes());
    notifyListeners();
  }

  getCommandeEnTerminer() => commande;
}
