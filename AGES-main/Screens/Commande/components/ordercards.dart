import 'dart:async';

import 'package:ages_app/Auths/functions.dart';
import 'package:ages_app/Commande/commande.dart';
import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Module/constants.dart';
import 'package:ages_app/Screens/Articles/components/body.dart';
import 'package:ages_app/Screens/Articles/components/hero_dialog_route.dart';
import 'package:ages_app/Users/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:flutter/material.dart';
import '../../../Module/utils.dart';
import 'package:provider/provider.dart';
import 'package:ages_app/Module/MyProvider.dart';

import '../../../Module/utils.dart' as utils;

//DATABASE & BACKEND

class OrderCard extends StatefulWidget {
  @override
  _OrderCardState createState() => _OrderCardState();
}

//Must update 3 or 4 at the time so we dont crash the app
class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    List<Commande> commandes = context.read<MyProvider>().getCommande();
    User user = context.read<MyProvider>().getUser();
    commandes.length <= 0 ? context.read<MyProvider>().setCommande() : null;
    List<Cards> cards = [];
    commandes.forEach((element) {
      cards.add(Cards(element, user));
    });

    return commandes.length != 0
        ? Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment(-1, 0),
              end: Alignment(-0.5, -0.7),
              colors: [
                Colors.blue.shade400,
                Colors.red.shade200,
              ],
            )),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(color: Colors.black, spreadRadius: 1),
                            ],
                          ),
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              child: Stack(children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Stack(
                                    children: <Widget>[cards[index]],
                                  ),
                                )
                              ]),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                CircularProgressIndicator(),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Aucune Commande",
                      style: CustomTextStyle.CardsNoOrder(context),
                    )),
              ],
            ),
          );
  }
}

class Cards extends StatelessWidget {
  final Commande commande;
  final User user;
  int hauteurCard = 100;
  Cards(this.commande, this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: kPrimaryLightColor, spreadRadius: 3),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      "#Commande : ",
                      style: utils.CustomTextStyle.TextFontInfo(context),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      "${commande.orderId}",
                      style: utils.CustomTextStyle.TextFontTitle(context),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      "12/12/12",
                      style: utils.CustomTextStyle.TextFontInfo(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            color: Color(0x4DFFFFFF),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      "Nom Article",
                      style: utils.CustomTextStyle.TextFontSemiTitle(context),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Description",
                      style: utils.CustomTextStyle.TextFontSemiTitle(context),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      "Quantité",
                      style: utils.CustomTextStyle.TextFontSemiTitle(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(children: [
              Container(
                color: kPrimaryLightColor,
                child: FutureBuilder<Map<Item, int>>(
                  future: commande.Orders,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Erreur'));
                    }
                    return SizedBox(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var item = snapshot.data?.keys.elementAt(index);
                            var qty = snapshot.data?.values.elementAt(index);
                            print(item);
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
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            "${item!.name}",
                                            style: utils.CustomTextStyle
                                                .TextFontInfo(context),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            "${item.description}",
                                            style: utils.CustomTextStyle
                                                .TextFontInfo(context),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "${qty}",
                                            style: utils.CustomTextStyle
                                                .TextFontInfo(context),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: snapshot.data?.length ?? 0),
                    );
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: user.getRole()=="admin" ?const EdgeInsets.only(left :25.0)  :const EdgeInsets.only(left :110.0, top: 10),
                  child: Row(
                    children: [
                      if ((user.getRole() == "admin" || user.getRole() == "User") &&
                          !context.watch<MyProvider>().loading)
                        TextButton(
                            onPressed: () {
                              try {
                                try {
                                  context.read<MyProvider>().setLoading(true);
                                  //Commande.complete(commande.orderId!);               //TO DO in backend ?
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    content: Text('$e'),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } finally {
                                context.read<MyProvider>().setCommande();
                                context.read<MyProvider>().setLoading(false);
                              }
                            },
                            child: context.watch<MyProvider>().loading
                                ? CupertinoActivityIndicator()
                                : Container(
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: buildCallContainer(
                                        "Completer",
                                        kPrimaryLightColor,
                                        context),
                                  ))
                      else if (user.getRole() == 'admin' ||
                          user.getRole() == 'User')
                        CupertinoActivityIndicator(),
                      if ((user.getRole() == "admin" ||
                              user.getRole() == "Client") &&
                          !context.watch<MyProvider>().loading)
                        TextButton(
                            onPressed: () {
                              try {
                                try {
                                  context.read<MyProvider>().setLoading(true);
                                  Commande.delete(commande.orderId!);
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    content: Text('$e'),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } finally {
                                context.read<MyProvider>().setCommande();
                                context.read<MyProvider>().setLoading(false);
                              }
                            },
                            child: context.watch<MyProvider>().loading
                                ? CupertinoActivityIndicator()
                                : Container(
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: buildCallContainer(
                                        "Supprimer",
                                        kPrimaryLightColor,
                                        context),
                                  ))
                      else if (user.getRole() == 'admin' ||
                          user.getRole() == 'Client')
                        CupertinoActivityIndicator(),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

buildCallContainer(String Title, Color color, BuildContext context) {
  return Container(
    width: 150,
    height: 30,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.black, spreadRadius: 1.5),
      ],
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
