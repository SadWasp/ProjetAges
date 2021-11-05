import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Module/constants.dart';
import 'package:flutter/material.dart';
import 'package:ages_app/Module/custom_appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ages_app/Users/User.dart';

import '../../../Module/utils.dart' as utils;

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User user = context.read<MyProvider>().getUser();
    return Scaffold(
      appBar: CustomAppBar(false, "Profile"),
      body: Stack(
        children: [
          Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment(-1, 0),
          end: Alignment(-0.5, -0.7),
          colors: [
            Colors.blue.shade400,
            Colors.red.shade200,
          ],
        )),
          
        ),
        
        Center(
          child: Container(
            decoration: BoxDecoration(
            color: Colors.transparent),
            width: size.width - 50,
            height: size.height -200,
            child: Card(
              color: kPrimaryLightColor,
              child: Padding(
                padding: const EdgeInsets.only(top : 50.0),
                child: Column(
                  children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    child: Icon( Icons.person, size: 55 ),
                  ),
                   SizedBox(height: size.height * 0.03),
                  Container(
                    width: 150,
                    height: 25,
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1)
              ),
                    child: Center(child: Text(user.getUsername(),
                          style: utils.CustomTextStyle.TextFontInfo(context))),
                  ),


                   context.watch<MyProvider>().loading
                  ? CupertinoActivityIndicator()
                  : ElevatedButton(
                        onPressed: () async {
                        try {
                          try {
                            context.read<MyProvider>().setLoading(true);
                            context.read<MyProvider>().disconnect(await User.Disconnect(user.getId()));
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
                          Navigator.pushNamed(context, '/');
                        }
                      },
                      child: Text(" Déconnection",style:  utils.CustomTextStyle.DisconnectButton(context))),
                ],),
              ),
            ),
          ),
        )
        ]
      ),
    );
  }
}
