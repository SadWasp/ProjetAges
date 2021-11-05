import 'package:ages_app/Commande/commande.dart';
import 'package:ages_app/Module/Exceptions.dart';
import 'package:ages_app/Screens/Articles/components/hero_dialog_route.dart';
import 'package:flutter_cart/flutter_cart.dart';

import 'package:provider/provider.dart';
import 'package:ages_app/Module/MyProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ages_app/Users/User.dart';
import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Module/constants.dart';
import '../../../Module/utils.dart' as utils;

Container CartBody(List<Map<Item, int>> cart, User user, BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(1, 1),
        end: Alignment(-1, -1),
        colors: [
          Colors.blue.shade400,
          Colors.red.shade200,
        ],
      )),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kPrimaryLightColor,
          boxShadow: [
            BoxShadow(color: Colors.black, spreadRadius: 1),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 35),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text("Article",
                          style: utils.CustomTextStyle.TextFontTitle(context))),
                  Expanded(
                      flex: 1,
                      child: Text("Quantité",
                          style: utils.CustomTextStyle.TextFontTitle(context))),
                ],
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = cart[index].keys.elementAt(0);
                      var qty = cart[index].values.elementAt(0);
                      return Column(
                        children: [
                          Divider(
                            thickness: 2,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Text(
                                      "${item.name}",
                                      style: utils.CustomTextStyle.TextFontInfo(
                                          context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      qty.toString(),
                                      style: utils.CustomTextStyle.TextFontInfo(
                                          context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: cart.length),
              ),
            ),
            if(cart.length > 0)
              TextButton(
                onPressed: () {
                  try {
                    try {
                      context.read<MyProvider>().setLoading(true);
                      context.read<MyProvider>().orderCart();
                    } catch (e) {
                      final snackBar = SnackBar(
                        content: Text('$e'),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } finally {
                    context.read<MyProvider>().setLoading(false);
                  }
                },
                child: buildCallContainer("Commander", context),
              ),
          ],
        ),
      ));
}

buildCallContainer(String Title, BuildContext context) {
  return Container(
    width: 150,
    height: 50,
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: kPrimaryLightColor,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.black, width: 2),
    ),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Center(
          child: Text(
        Title,
        style: utils.CustomTextStyle.TextFontInfo(context),
      )),
    ),
  );
}

class PopUpCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  ///

  const PopUpCard({Key? key, this.item, required this.user}) : super(key: key);
  final User user;
  final Item? item;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cart = FlutterCart();
    return Container();
  }
}
