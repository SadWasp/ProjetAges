import 'dart:math';

import 'package:ages_app/Auths/functions.dart';
import 'package:ages_app/Location/location.dart';
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

Container LocalisationBody(Future<List<Location>> listLoc, User user) {
  var cart = FlutterCart();
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
    child: FutureBuilder<List<Location>>(
      future: listLoc,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erreur'));
        }

        return ListView.separated(
          
            itemBuilder: (context, index) {
              var location = snapshot.data?[index];
              var listItems = Location.getItems(location!.id!);

              return Container(
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  height: 100.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(HeroDialogRoute(builder: (context) {
                        return PopUpCard(user: user, location: location, items: listItems,);
                      }));
                    },
                    child: Hero(
                      tag: "${location.location}",
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("${location.id}",
                                style: utils.CustomTextStyle.TextFontInfo(
                                    context)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text("${location.location}",
                                style: utils.CustomTextStyle.TextFontTitle(
                                    context)),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 1,
                height: 10,
              );
            },
            itemCount: snapshot.data?.length ?? 0);
      },
    ),
  );
}

buildCallContainer(String Title, Color color, BuildContext context, User user) {
  return Container(
    width: user.getRole() == "admin" ? 100 : 250,
    height: 50,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(
        Title,
        style: utils.CustomTextStyle.HeaderCardButtonFont(context),
      )),
    ),
  );
}

class PopUpCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  ///

  const PopUpCard({Key? key, this.location, required this.user, required this.items})
      : super(key: key);
  final User user;
  final Location? location;
  final Future<List<Item>> items;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cart = FlutterCart();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "${location?.location}",
          child: Material(
            color: kPrimaryColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 300,
                        child: Column(children: [
                          SizedBox(height: size.height * 0.03),
                          Container(
                            width: 500,
                            height: 50,
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black, spreadRadius: 1.5),
                              ],
                            ),
                            child: Center(
                              child: Text("${location!.location}",
                                  style: utils.CustomTextStyle.TextFontTitle(
                                      context)),
                            ),
                          ),
                          Divider(
                            color: kPrimaryLightColor,
                          ),
                           Container(
                            width: 500,
                            
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black, spreadRadius: 1.5),
                              ],
                            ),
                            child: SizedBox(
                              height:MediaQuery.of(context).size.height-300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Liste articles dans la localisation: ",
                                          style: utils.CustomTextStyle.TextFontInfo(context)),
                                      Column(
                                        children: [
                                          FutureBuilder<List<Item>>(
                                            
                                            future: items,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                              }
                                              if (snapshot.hasError) {
                                                return Center(child: Text('Erreur'));
                                              }
                                
                                              return ListView.separated(
                                                physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, index) {
                                                    var item = snapshot.data?[index];
                                
                                                    return Container(
                                                        decoration: BoxDecoration(
                                                          color: kPrimaryLightColor,
                                                          border: Border.all(color: Colors.black, width: 1.5),
                                                        ),
                                                        height: 100.0,
                                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                                        child: Container(
                                                          child: Text("${item!.name}"),
                                                        )
                                                        );
                                                  },
                                                  separatorBuilder: (context, index) {
                                                    return Divider(
                                                      thickness: 1,
                                                      height: 10,
                                                    );
                                                  },
                                                  itemCount: snapshot.data?.length ?? 0);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: kPrimaryLightColor,
                          ),
                        ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
