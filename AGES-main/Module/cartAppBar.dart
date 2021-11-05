import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Module/constants.dart';
import 'package:ages_app/Screens/Articles/articles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CartAppBar extends StatefulWidget implements PreferredSizeWidget {
  CartAppBar(bool back, this.headerText) :  preferredSize = Size.fromHeight(60.0);
  final String headerText;

  @override
  final Size preferredSize;

  @override
  _CartAppBarAppBarState createState() => _CartAppBarAppBarState();
}

class _CartAppBarAppBarState extends State<CartAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      
      bottom: TabBar(
        tabs: <Widget>[
          Text("Articles"),
          Text("Panier"),
        ],
      ),
      toolbarHeight: 60,
      elevation: 10,
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(2))),
    );
  }
}
