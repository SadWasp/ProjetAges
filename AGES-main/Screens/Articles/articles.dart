import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Module/cartAppBar.dart';
import 'package:ages_app/Screens/Scanner/scanner.dart';
import 'package:ages_app/Users/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Module/custom_appbar.dart';
import 'components/Cart.dart';
import 'components/body.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Item>> listItem = Item.getListItems();
    List<Map<Item,int>> cart = context.read<MyProvider>().getCart();
    User user = context.read<MyProvider>().getUser();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
          
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
          /*this is not visible but keep the flex even.*/
          Opacity(
              opacity: 0.0,
              child: Icon(Icons
                  .ac_unit)) /*this is not visible but keep the flex even.*/,
          Expanded(flex: 2, child: Center(child: Text("AGES"))),
          Row(
            children: [
              IconButton(
                  onPressed: () => {/*go back*/}, icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () => {/*go back*/}, icon: Icon(Icons.filter_alt))
            ],
          ),
        ],
      ),
          bottom: TabBar(
            tabs: <Widget>[
              Text("Articles"),
              (user.getRole() == "User" || user.getRole() == "admin")?  Text("Scanner") :Text("Panier"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ArticlesBody(listItem, user),
             (user.getRole() == "User" || user.getRole() == "admin") ? BarcodeScanPage() : CartBody(cart,user,context),
        ]),
        ),
    );
  }
}