import 'package:flutter/material.dart';
import 'package:ages_app/Screens/Commande/components/ordercards.dart';
import 'package:ages_app/Module/custom_appbar.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(false,""),
      body: OrderCard(),
    );
  }
}