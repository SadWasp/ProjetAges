import 'package:ages_app/Module/Exceptions.dart';

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
          return Center(child: Text('Erreur'));
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
                  child: new InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("${item?.id}",
                              style:
                                  utils.CustomTextStyle.TextFontInfo(context)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text("${item?.name}",
                              style:
                                  utils.CustomTextStyle.TextFontTitle(context)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text("${item?.location}",
                              style:
                                  utils.CustomTextStyle.TextFontInfo(context)),
                        ),
                        
                        if(user.getRole() == "admin" && !context.watch<MyProvider>().loading)
                          TextButton(

                            onPressed: () {
                              
                              try{
                                try{
                                context.read<MyProvider>().setLoading(true);
                                  var res = Item.delete(item!.id!);
                              }
                              catch(e){
                                  final snackBar = SnackBar(
                                    content: Text('$e'),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }finally {context.read<MyProvider>().setLoading(false);}
                              
                              
                            },
                            child: buildCallContainer(
                                "Delete", Color(0xFFF44336), context),
                          )
                          else if( user.getRole() == 'admin')
                            CupertinoActivityIndicator()
                      ],
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

buildCallContainer(String Title, Color color, BuildContext context) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Center(
          child: Text(
        Title,
        style: utils.CustomTextStyle.HeaderCardTextFont(context),
      )),
    ),
  );
}
