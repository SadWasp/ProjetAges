import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Module/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar(bool back, this.headerText) :  preferredSize = Size.fromHeight(60.0);
  final String headerText;

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          context.watch<MyProvider>().loading ?IconButton(
              onPressed: () => {
                null}, icon: Icon(Icons.arrow_back)):
          IconButton(
              onPressed: () => {
                Navigator.pop(context)}, icon: Icon(Icons.arrow_back)),
          Opacity(
              opacity: 0.0,
              child: Icon(Icons
                  .ac_unit)) /*this is not visible but keep the flex even.*/,
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
      toolbarHeight: 60,
      elevation: 10,
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(2))),
    );
  }
}
