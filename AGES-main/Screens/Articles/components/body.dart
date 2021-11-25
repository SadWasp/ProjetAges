import 'package:ages_app/Commande/commande.dart';
import 'package:ages_app/Location/location.dart';
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

Container ArticlesBody(Future<List<Item>> listItem, User user) {
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
    child: FutureBuilder<List<Item>>(
      future: listItem,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        return ListView.separated(
            itemBuilder: (context, index) {
              var item = snapshot.data?[index];

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
                        return PopUpCard(user: user, item: item);
                      }));
                    },
                    child: Hero(
                      tag: "${item!.id}",
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text("${item.name}",
                                style: utils.CustomTextStyle.TextFontTitle(
                                    context)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 8.0, // gap between adjacent chips
                              runSpacing: 4.0,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Description: ${item.description}",
                                        style:
                                            utils.CustomTextStyle.TextFontInfo(
                                                context), overflow: TextOverflow.fade,maxLines: 2, softWrap: true,),
                                    Text("Quantite restante: ${item.quantite}",
                                        style:
                                            utils.CustomTextStyle.TextFontInfo(
                                                context)),
                                  ],
                                )
                              ],
                            ),
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

buildCallContainer(String Title, BuildContext context) {
  return Container(
    width: 150,
    height: 50,
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
    return Center(
      child: Hero(
        tag: "${item?.id}",
        child: Material(
          color: kPrimaryLightColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    width: 350,
                    child: Column(children: [
                      Container(
                        height: 110,
                        width: 150,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Center(
                            child: Text("Photo de l'article",
                                style: utils.CustomTextStyle.TextFontInfo(
                                    context))),
                      ),
                      Container(
                        height: 75,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Center(
                            child: Text(item!.name!,
                                style: utils.CustomTextStyle.TextFontTitle(
                                    context))),
                      ),
                      Container(
                        width: 350,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Description de l'article",
                                style: utils.CustomTextStyle.TextFontInfo(
                                    context)),
                            Text(item!.description!,
                                style: utils.CustomTextStyle
                                    .TextFontPrimaryDescription(context)),
                          ],
                        ),
                      ),
                      Container(
                        width: 350,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Information: ",
                                style: utils.CustomTextStyle.TextFontInfo(
                                    context)),
                            Text(
                                "Quantité restante: " +
                                    item!.quantite!.toString() +
                                    " unités",
                                style: utils.CustomTextStyle
                                    .TextFontPrimaryDescription(context)),
                          ],
                        ),
                      ),
                      if (user.getRole() == "Client" &&
                          !context.watch<MyProvider>().loading)
                        TextButton(
                          onPressed: () {
                            try {
                              try {
                                context.read<MyProvider>().setLoading(true);
                                context.read<MyProvider>().addToCart(item!, 1);
                              } catch (e) {
                                final snackBar = SnackBar(
                                  content: Text('$e'),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } finally {
                              context.read<MyProvider>().setLoading(false);
                            }
                          },
                          child:
                              buildCallContainer("Ajouter au panier", context),
                        ),
                      if ((user.getRole() == "User" ||
                              user.getRole() == "admin") &&
                          !context.watch<MyProvider>().loading)
                        
                        Container(
                          width: 350,
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Localisation: ",
                                  style: utils.CustomTextStyle.TextFontInfo(
                                      context)),
                              Container(
                                width: 150,
                                child: ElevatedButton(onPressed: ()=>{

                                },
                                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(kPrimaryColor),),
                                  child: Text(
                                    item!.location!.toString(),
                                    style: utils.CustomTextStyle
                                        .TextFontPrimaryDescription(context)),),
                              )
                              
                            ],
                          ),
                        ),
                      if (user.getRole() == "admin" &&
                          !context.watch<MyProvider>().loading)
                        TextButton(
                          onPressed: () {
                            try {
                              try {
                                context.read<MyProvider>().setLoading(true);
                                var res = Item.delete(item!.id!);
                              } catch (e) {
                                final snackBar = SnackBar(
                                  content: Text('$e'),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } finally {
                              context.read<MyProvider>().setLoading(false);
                            }
                          },
                          child: buildCallContainer(
                              "Supprimer l'article", context),
                        ),
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
