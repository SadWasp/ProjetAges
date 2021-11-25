import 'package:ages_app/Module/constants.dart';
import 'package:ages_app/Module/gridView_widget.dart';
import 'package:ages_app/Module/mapAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloorPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: MapAppBar(),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        child: Container(
          color: kPrimaryColor,
          child: Center(
            child: GridViewWidget(orderId:22),
          ),
        ),
      ),
    );
  }
}
